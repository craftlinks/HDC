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
        # var result = Self()
        # for i in range(self._num_storage_elements):
        #     result._storage.store(
        #         i, self._storage.load(i) | other._storage.load(i)
        #     )
        # return result

        var result = Self()
        # Use the struct's nelts alias for the vector width
        alias vec_width = self.nelts

        # Define the kernel function to be vectorized
        @parameter
        fn or_kernel[vec_width: Int](idx: Int):
            # Load SIMD vectors from self and other
            var self_vec = self._storage.load[width=vec_width](idx)
            var other_vec = other._storage.load[width=vec_width](idx)
            # Perform SIMD OR and store the result
            result._storage.store(idx, self_vec | other_vec)

        # Apply the vectorized kernel over the storage elements
        vectorize[or_kernel, vec_width, size = D // dtype.bitwidth()]()

        return result

    fn __xor__(self, other: Self) raises -> Self:
        """Performs bitwise XOR between two BitVectors using vectorized operations.
        """
        # var result = Self()
        # for i in range(self._num_storage_elements):
        #     result._storage.store(
        #         i, self._storage.load(i) ^ other._storage.load(i)
        #     )
        # return result

        var result = Self()
        # Use the struct's nelts alias for the vector width
        alias vec_width = self.nelts

        # Define the kernel function to be vectorized
        @parameter
        fn xor_kernel[vec_width: Int](idx: Int):
            # Load SIMD vectors from self and other
            var self_vec = self._storage.load[width=vec_width](idx)
            var other_vec = other._storage.load[width=vec_width](idx)
            # Perform SIMD XOR and store the result
            result._storage.store(idx, self_vec ^ other_vec)

        # Apply the vectorized kernel over the storage elements
        vectorize[xor_kernel, vec_width, size = D // dtype.bitwidth()]()

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

        # Calculate the effective shift amount (non-negative)
        var s: Int = k % D_val
        if s < 0:
            s += D_val

        if s == 0:
            return self  # No shift needed

        # Calculate shift in terms of storage elements and bits within elements
        var element_shift: Int = s // self._bits_per_element
        var bit_shift_within_element: Int = s % self._bits_per_element

        var result = Self()  # Initialize the result vector

        # Implement the element-wise shift logic here
        var B: Int = self._bits_per_element
        var N: Int = self._num_storage_elements

        if bit_shift_within_element == 0:
            # Simple case: shift only by whole elements
            for i in range(N):
                var src_idx: Int = (i + element_shift) % N
                result._storage.store(i, self._storage.load(src_idx))
        else:
            # Complex case: shift involves bits across element boundaries
            var right_shift: Int = bit_shift_within_element
            var left_shift: Int = B - right_shift
            for i in range(N):
                # Source indices in the original storage array
                var src_idx1: Int = (i + element_shift) % N
                var src_idx2: Int = (i + element_shift + 1) % N

                # Load the two source elements
                var val1 = self._storage.load(src_idx1)
                var val2 = self._storage.load(src_idx2)

                # Combine the bits
                var combined_val = (val1 >> right_shift) | (val2 << left_shift)

                result._storage.store(i, combined_val)

        return result

    fn __rshift__(self, other: Int) raises -> Self:
        """Performs circular right shift (rotate) on the HV's visual representation (LSB-first).
        Internally, this performs a circular *left* shift on the indices."""
        var D_val: Int = D
        var k: Int = other
        if D_val == 0:
            return Self()

        # Calculate the effective shift amount (non-negative)
        var s: Int = k % D_val
        if s < 0:
            s += D_val

        if s == 0:
            return self  # No shift needed

        var result = Self()  # Initialize the result vector
        var B: Int = self._bits_per_element
        var N: Int = self._num_storage_elements

        # Calculate shift in terms of storage elements and bits within elements
        # Note: internal shift is *left* for a visual right shift
        var element_shift: Int = s // B
        var bit_shift_within_element: Int = s % B

        # Implement the element-wise right shift logic here
        if bit_shift_within_element == 0:
            # Simple case: shift only by whole elements (internal left shift)
            for i in range(N):
                # Source index calculation for internal left shift
                var src_idx: Int = (i - element_shift + N) % N
                result._storage.store(i, self._storage.load(src_idx))
        else:
            # Complex case: shift involves bits across element boundaries
            var left_shift = bit_shift_within_element
            var right_shift = B - left_shift
            for i in range(N):
                # Source indices for internal left shift
                # src_idx1 provides upper bits (shifted left)
                # src_idx2 provides lower bits (shifted right)
                var src_idx1: Int = (i - element_shift + N) % N
                var src_idx2: Int = (
                    i - element_shift - 1 + N
                ) % N  # Previous element

                # Load the two source elements
                var val1 = self._storage.load(src_idx1)
                var val2 = self._storage.load(src_idx2)

                # Combine the bits for right shift (visual)
                # Upper bits come from val1 shifted left
                # Lower bits come from val2 shifted right
                var combined_val = (val1 << left_shift) | (val2 >> right_shift)

                result._storage.store(i, combined_val)

        return result

    fn bind(self, other: Self) raises -> Self:
        """Performs the binding operation (element-wise XOR) with another HV."""
        # Binding is typically implemented using XOR (^) for binary HVs.
        return self ^ other

    @staticmethod
    fn bundle_majority_naive[
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

    @staticmethod
    fn bundle_majority[
        D: Int, dtype: DType
    ](vectors: List[HV[D, dtype]]) raises -> HV[D, dtype]:
        """
        Bundles multiple Hypervectors using a bitwise majority vote, operating
        on storage elements for better performance. (Currently has compiler issues)

        Args:
            vectors: A List containing the HV objects to bundle.

        Returns:
            A new HV representing the majority vote bundle.

        Raises:
            Error: If the input vector list is empty.
        """
        var n: Int = len(vectors)
        if n == 0:
            raise Error("Cannot bundle an empty list of vectors.")

        # Assume all vectors have the same D and dtype as the first one.
        # A production environment might add checks here.
        var first_vec = vectors[0]
        var num_storage_elements = first_vec._num_storage_elements
        var bits_per_element = first_vec._bits_per_element

        # Initialize the result vector.
        var result = HV[D,dtype]()  # Uses __init__ which initializes storage

        # If only one vector, return a copy
        if n == 1:
            var vec: HV[D, dtype] = vectors[0]
            return vec

        # Iterate through each storage element index
        for k in range(num_storage_elements):
            var result_element = Scalar[dtype](
                0
            )  # Start with zero for this element

            # Iterate through each bit position within the current storage element
            for bit_pos in range(bits_per_element):
                var count: Int = 0
                var mask = Scalar[dtype](1) << bit_pos

                # Count how many vectors have a '1' at this bit position
                # within the k-th storage element
                for i in range(n):
                    # Load the k-th storage element from the i-th vector
                    # Explicitly type annotate to potentially help compiler
                    var current_element: Scalar[dtype] = Scalar[dtype](
                        vectors[i]._storage.load(k)
                    )
                    # Check if the specific bit is set
                    if (current_element & mask) != 0:
                        count += 1

                # Set the corresponding bit in the result_element if it's the majority
                # (count * 2 > n) handles ties by flooring (result bit is 0)
                if count * 2 > n:
                    result_element |= mask

            # Store the computed majority element into the result vector's storage
            result._storage.store(
                k, result_element
            )  # Original Error occurred here

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
