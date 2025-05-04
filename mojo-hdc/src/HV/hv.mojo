from random import random, seed as seedf
from memory import UnsafePointer
from algorithm import parallelize, vectorize
from sys import info, simdwidthof
from bit import pop_count
import time
from utils.numerics import max_finite, min_finite


struct HV[D: Int = 2**9, dtype: DType = DType.uint64](Writable):
    alias nelts = 2 * simdwidthof[dtype]()

    # Calculate the number of UInt64 elements needed for storage
    var _num_storage_elements: Int
    var _bits_per_element: Int
    var _storage: UnsafePointer[Scalar[dtype]]

    fn __init__(out self) raises:
        """Initializes the bit vector to random values."""
        self._bits_per_element = dtype.bitwidth()
        if D % self._bits_per_element != 0:
            raise Error(
                "D must be a multiple of the size of the dtype: "
                + String(self._bits_per_element)
            )
        self._num_storage_elements = D // self._bits_per_element
        self._storage = UnsafePointer[Scalar[dtype]].alloc(
            self._num_storage_elements
        )
        seedf(time.monotonic())
        random.randint[dtype](
            self._storage,
            self._num_storage_elements,
            low=Int(min_finite[dtype]()),
            high=Int(max_finite[dtype]()),
        )

    fn __copyinit__(out self, existing: Self):
        self._num_storage_elements = existing._num_storage_elements
        self._bits_per_element = existing._bits_per_element
        self._storage = UnsafePointer[Scalar[dtype]].alloc(
            self._num_storage_elements
        )
        for i in range(self._num_storage_elements):
            self._storage.store(i, existing._storage.load(i))

    fn __moveinit__(out self, owned existing: Self):
        self._num_storage_elements = existing._num_storage_elements
        self._bits_per_element = existing._bits_per_element
        self._storage = existing._storage

    fn __str__(self) -> String:
        return String.write(self)

    fn __repr__(self) -> String:
        return self.__str__()

    @always_inline
    fn _get_indices(self, bit_index: Int) raises -> (Int, Int):
        if bit_index < 0 or bit_index >= D:
            raise Error("Bit index out of bounds")
        var storage_idx: Int = bit_index // self._bits_per_element
        var bit_offset: Int = bit_index % self._bits_per_element
        return (storage_idx, bit_offset)

    @always_inline
    fn __getitem__(self, bit_index: Int) raises -> Bool:
        storage_idx, bit_offset = self._get_indices(bit_index)
        var mask = Scalar[dtype](1) << bit_offset
        return (self._storage[storage_idx] & mask) != 0

    @always_inline
    fn __setitem__(mut self, bit_index: Int, value: Bool) raises:
        storage_idx, bit_offset = self._get_indices(bit_index)
        var mask = Scalar[dtype](1) << bit_offset
        if value:  # set bit
            self._storage[storage_idx] |= mask
        else:  # clear bit
            self._storage[storage_idx] &= ~mask

    # --- Performance-Critical Operations ---

    fn __add__(self, other: Self) raises -> Self:
        raise Error(
            "Addition (+) is disabled. Use bundle_majority() for multi-vector"
            " bundling or XOR (^) for pairwise bundling/binding."
        )

    fn __sub__(self, other: Self) raises -> Self:
        raise Error(
            "Subtraction (-) is not a standard HDC operation for binary HVs."
            " Consider using XOR (^)."
        )

    fn __mul__(self, other: Self) raises -> Self:
        """Performs bitwise multiplication (element-wise XOR, same as binding) between two HVs.
        """
        # In binary HDC, multiplication/binding is typically XOR.
        return self ^ other

    fn __and__(self, other: Self) raises -> Self:
        """Performs bitwise AND between two BitVectors using vectorized operations.
        """
        var result = Self()
        for i in range(self._num_storage_elements):
            result._storage.store(
                i, self._storage.load(i) & other._storage.load(i)
            )
        return result

    fn __or__(self, other: Self) raises -> Self:
        """Performs bitwise OR between two BitVectors using vectorized operations.
        """
        var result = Self()
        for i in range(self._num_storage_elements):
            result._storage.store(
                i, self._storage.load(i) | other._storage.load(i)
            )
        return result

    fn __xor__(self, other: Self) raises -> Self:
        """Performs bitwise XOR between two BitVectors using vectorized operations.
        """
        var result = Self()
        for i in range(self._num_storage_elements):
            result._storage.store(
                i, self._storage.load(i) ^ other._storage.load(i)
            )
        return result

    fn __invert__(self) raises -> Self:
        """Performs bitwise NOT on the BitVector using vectorized operations."""
        var result = Self()
        for i in range(self._num_storage_elements):
            result._storage.store(i, ~self._storage.load(i))
        return result

    fn __lshift__(self, other: Int) raises -> Self:
        """Performs circular left shift (rotate) on the HV's visual representation (LSB-first).
        Internally, this performs a circular *right* shift on the indices."""
        var D_val: Int = D
        var k: Int = other
        if D_val == 0:
            return Self()  # Return an empty vector if D is 0

        var s: Int = k % D_val
        # Ensure s is non-negative for consistent modulo behavior
        if s < 0:
            s += D_val

        if s == 0:
            return self

        var result = Self()  # Initialize result vector

        # Copy bit by bit based on circular *right* shift logic (indices decrease)
        for j in range(D_val):
            # Source index for internal right shift
            var source_idx: Int = (j + s) % D_val
            result[j] = self[source_idx]  # Use getitem/setitem

        return result

    fn __rshift__(self, other: Int) raises -> Self:
        """Performs circular right shift (rotate) on the HV's visual representation (LSB-first).
        Internally, this performs a circular *left* shift on the indices."""
        var D_val: Int = D
        var k: Int = other
        if D_val == 0:
            return Self()  # Return an empty vector if D is 0

        var s: Int = k % D_val
        # Ensure s is non-negative for consistent modulo behavior
        if s < 0:
            s += D_val

        if s == 0:
            return self

        var result = Self()  # Initialize result vector

        # Copy bit by bit based on circular *left* shift logic (indices increase)
        for j in range(D_val):
            # Source index for internal left shift
            var source_idx: Int = (j - s + D_val) % D_val
            result[j] = self[source_idx]  # Use getitem/setitem

        return result

    fn bind(self, other: Self) raises -> Self:
        """Performs the binding operation (element-wise XOR) with another HV."""
        # Binding is typically implemented using XOR (^) for binary HVs.
        return self ^ other

    @staticmethod
    fn bundle_majority[
        D: Int, dtype: DType
    ](vectors: List[Self]) raises -> Self:
        """
        Bundles multiple Hypervectors using a bitwise majority vote.

        Args:
            vectors: A DynamicVector containing the HV objects to bundle.

        Returns:
            A new HV representing the majority vote bundle.

        Raises:
            CompilerError: If the input vector list is empty.
        """
        var n: Int = len(vectors)
        if n == 0:
            # Or handle appropriately, e.g., return a zero vector?
            raise Error("Cannot bundle an empty list of vectors.")

        # Initialize the result vector. We'll set every bit explicitly.
        # Initializing randomly and then setting is fine too.
        var result = Self()

        # If only one vector, return a copy (or the vector itself if ownership allows)
        if n == 1:
            # This assumes HV has a copy constructor (__copyinit__)
            return vectors[0]

        # Iterate through each bit dimension
        for j in range(D):
            var count: Int = 0
            # Count how many vectors have a '1' at this bit position
            for i in range(n):
                # Assuming __getitem__ returns Bool
                if vectors[i][j]:
                    count += 1

            # Set the result bit based on majority
            # (count * 2 > n) handles ties correctly:
            # - If count > n/2, then count*2 > n (True -> set bit to 1)
            # - If count < n/2, then count*2 < n (False -> set bit to 0)
            # - If count == n/2 (only for even n), then count*2 == n (False -> set bit to 0, tie-break)
            result[j] = count * 2 > n

        return result

    fn pop_count(self) -> Int:
        var count: Int = 0
        for i in range(self._num_storage_elements):
            count += Int(pop_count(self._storage.load(i)))
        return count

    fn write_to[W: Writer](self, mut writer: W) -> None:
        writer.write("HV[ ")
        for i in range(self._num_storage_elements):
            var value = self._storage.load(i)
            var binary = String()
            for j in range(self._bits_per_element):
                var bit_val = (value >> j) & 1
                binary += String(bit_val)
            writer.write(binary)
            writer.write(" ")
        writer.write("]")
