from testing import assert_equal, assert_false, assert_raises, assert_true
from HV import HV, HVS
from collections import List
from python import Python, PythonObject

fn test_valid_initialization() raises:
    """Tests HV initialization with valid D and dtype combinations."""

    # Test case 1: D=64, dtype=uint8
    var hv_u8_64 = HV[64, DType.uint8]()
    assert_equal(hv_u8_64._bits_per_element, 8)
    assert_equal(hv_u8_64._num_storage_elements, 64 // 8)

    # Test case 2: D=128, dtype=uint16
    var hv_u16_128 = HV[128, DType.uint16]()
    assert_equal(hv_u16_128._bits_per_element, 16)
    assert_equal(hv_u16_128._num_storage_elements, 128 // 16)

    # Test case 3: D=256, dtype=uint32
    var hv_u32_256 = HV[256, DType.uint32]()
    assert_equal(hv_u32_256._bits_per_element, 32)
    assert_equal(hv_u32_256._num_storage_elements, 256 // 32)

    # Test case 4: D=512, dtype=uint64 (default)
    var hv_u64_512 = HV[512, DType.uint64]()
    assert_equal(hv_u64_512._bits_per_element, 64)
    assert_equal(hv_u64_512._num_storage_elements, 512 // 64)

    # Test case 5: Larger D, default dtype
    var hv_large_d = HV[2048]()  # Default is uint64
    assert_equal(hv_large_d._bits_per_element, 64)
    assert_equal(hv_large_d._num_storage_elements, 2048 // 64)


fn test_invalid_initialization_raises() raises:
    """Tests that HV initialization raises an error if D is not a multiple of dtype bitwidth.
    """
    # D=100 is not divisible by 16 (uint16)
    with assert_raises():
        var hv_invalid = HV[100, DType.uint16]()

    # D=50 is not divisible by 64 (uint64)
    with assert_raises():
        var hv_invalid_2 = HV[50, DType.uint64]()


fn test_getitem_setitem() raises:
    """Tests getting and setting individual bits."""
    var hv = HV[128, DType.uint8]()  # D=128, dtype=uint8

    # Check initial random state (difficult to assert specific value)
    _ = hv[0]
    _ = hv[64]
    _ = hv[127]

    # Set specific bits
    hv[0] = True
    hv[1] = False
    hv[127] = True

    assert_true(hv[0])
    assert_false(hv[1])
    assert_true(hv[127])

    # Test out of bounds
    with assert_raises():
        _ = hv[128]
    with assert_raises():
        hv[128] = False
    with assert_raises():
        _ = hv[-1]


fn test_bitwise_ops() raises:
    """Tests bitwise AND, OR, XOR, INVERT, and bind."""
    alias D = 64
    alias DT = DType.uint64
    var hv1 = HV[D, DT]()
    var hv2 = HV[D, DT]()

    # Create known patterns for easier verification
    for i in range(D):
        hv1[i] = i % 2 == 0  # 101010...
        hv2[i] = i % 3 == 0  # 100100...

    # AND (&)
    var hv_and = hv1 & hv2
    for i in range(D):
        expected = (i % 2 == 0) and (i % 3 == 0)
        assert_equal(
            hv_and[i], expected, "AND failed at index " + String(i) + ": " + String(hv_and)
        )

    # OR (|)
    var hv_or = hv1 | hv2
    for i in range(D):
        expected = (i % 2 == 0) or (i % 3 == 0)
        assert_equal(hv_or[i], expected, "OR failed at index " + String(i))

    # XOR (^)
    var hv_xor = hv1 ^ hv2
    for i in range(D):
        expected = (i % 2 == 0) ^ (i % 3 == 0)
        assert_equal(hv_xor[i], expected, "XOR failed at index " + String(i))

    # INVERT (~)
    var hv_inv = ~hv1
    for i in range(D):
        expected = not (i % 2 == 0)
        assert_equal(hv_inv[i], expected, "INVERT failed at index " + String(i))

    # bind (should be same as XOR)
    var hv_bind = hv1.bind(hv2)
    for i in range(D):
        expected = (i % 2 == 0) ^ (i % 3 == 0)
        assert_equal(hv_bind[i], expected, "bind failed at index " + String(i))


fn test_arithmetic_ops_disabled() raises:
    """Tests that +, -, * (as XOR) work as expected."""
    var hv1 = HV[64, DType.uint64]()
    var hv2 = HV[64, DType.uint64]()

    with assert_raises():  # Addition should raise
        _ = hv1 + hv2

    with assert_raises():  # Subtraction should raise
        _ = hv1 - hv2

    # Multiplication should be XOR
    var hv_mul = hv1 * hv2
    var hv_xor = hv1 ^ hv2
    for i in range(64):
        assert_equal(hv_mul[i], hv_xor[i], "Multiplication (*) is not XOR")


fn test_shift_ops() raises:
    """Tests circular left and right shifts."""
    alias D = 16
    alias DT = DType.uint8  # D is multiple of 8
    var hv = HV[D, DT]()

    # Create a pattern: 1111000000000000
    for i in range(D):
        hv[i] = i < 4

    # Left shift by 2: 1100000000000011
    var hv_lshift = hv << 2
    for i in range(D):
        var idx = (i + 2) % D  # original index after lshift 2
        expected = idx < 4
        assert_equal(
            hv_lshift[i], expected, "LSHIFT failed at index " + String(i)
        )

    # Right shift by 3: 0001111000000000
    var hv_rshift = hv >> 3
    for i in range(D):
        var idx = (i - 3 + D) % D  # original index after rshift 3
        expected = idx < 4
        assert_equal(
            hv_rshift[i], expected, "RSHIFT failed at index " + String(i)
        )

    # Shift by 0
    var hv_lshift0 = hv << 0
    var hv_rshift0 = hv >> 0
    for i in range(D):
        assert_equal(hv_lshift0[i], hv[i], "LSHIFT 0 failed")
        assert_equal(hv_rshift0[i], hv[i], "RSHIFT 0 failed")

    # Shift by D
    var hv_lshiftD = hv << D
    var hv_rshiftD = hv >> D
    for i in range(D):
        assert_equal(hv_lshiftD[i], hv[i], "LSHIFT D failed")
        assert_equal(hv_rshiftD[i], hv[i], "RSHIFT D failed")

    # Shift by negative (should wrap around)
    var hv_lshift_neg = hv << -2  # Same as rshift 2
    var hv_rshift_neg = hv >> -3  # Same as lshift 3
    var hv_rshift2 = hv >> 2
    var hv_lshift3 = hv << 3
    for i in range(D):
        assert_equal(hv_lshift_neg[i], hv_rshift2[i], "LSHIFT negative failed")
        assert_equal(hv_rshift_neg[i], hv_lshift3[i], "RSHIFT negative failed")


fn test_pop_count() raises:
    """Tests the pop_count method."""
    alias D = 64
    alias DT = DType.uint16  # D=64, dtype=uint16
    var hv = HV[D, DT]()

    # Test with all zeros
    for i in range(D):
        hv[i] = False
    assert_equal(hv.pop_count(), 0, "Popcount failed for all zeros")

    # Test with all ones
    for i in range(D):
        hv[i] = True
    assert_equal(hv.pop_count(), D, "Popcount failed for all ones")

    # Test with alternating pattern
    count = 0
    for i in range(D):
        is_set = i % 2 == 0
        hv[i] = is_set
        if is_set:
            count += 1
    assert_equal(
        hv.pop_count(), count, "Popcount failed for alternating pattern"
    )

    # Test with a few specific bits set
    for i in range(D):
        hv[i] = False  # Clear first
    hv[0] = True
    hv[D // 2] = True
    hv[D - 1] = True
    assert_equal(hv.pop_count(), 3, "Popcount failed for specific bits")


fn test_bundle_majority() raises:
    """Tests bundling multiple HVs using majority vote."""
    alias D = 32
    alias DT = DType.uint8  # D=32, dtype=uint8

    # --- Test Case 1: Odd number of vectors ---
    var hv1 = HV[D, DT]()
    var hv2 = HV[D, DT]()
    var hv3 = HV[D, DT]()

    # Create patterns:
    # hv1: 1010...
    # hv2: 1100...
    # hv3: 1110...
    for i in range(D):
        hv1[i] = i % 2 == 0  # 1010
        hv2[i] = i % 4 < 2  # 1100
        hv3[i] = i % 4 < 3  # 1110

    var vectors1 = List[HV[D, DT]]()
    vectors1.append(hv1)
    vectors1.append(hv2)
    vectors1.append(hv3)

    var bundled1 = HV.bundle_majority[D, DT](vectors1)

    # Calculate expected majority manually for first few bits
    # i=0: 1, 1, 1 -> 1 (majority)
    # i=1: 0, 1, 1 -> 1 (majority)
    # i=2: 1, 0, 1 -> 1 (majority)
    # i=3: 0, 0, 0 -> 0 (majority)
    # General: majority is 1 if at least 2 vectors have 1
    for i in range(D):
        count = 0
        if hv1[i]:
            count += 1
        if hv2[i]:
            count += 1
        if hv3[i]:
            count += 1
        expected = count > 1  # Majority for n=3

        assert_equal(
            bundled1[i], expected, "Bundle (n=3) failed at index " + String(i)
        )


    # --- Test Case 2: Even number of vectors (tie-break to 0) ---
    var hv4 = HV[D, DT]()
    # hv4: 0000...
    for i in range(D):
        hv4[i] = False

    var vectors2 = List[HV[D, DT]]()
    vectors2.append(hv1)  # 1010...
    vectors2.append(hv2)  # 1100...
    vectors2.append(hv3)  # 1110...
    vectors2.append(hv4)  # 0000...

    var bundled2 = HV.bundle_majority[D, DT](vectors2)

    # Calculate expected majority manually for first few bits
    # i=0: 1, 1, 1, 0 -> 1 (majority, 3 > 4/2)
    # i=1: 0, 1, 1, 0 -> 0 (tie, 2 == 4/2 -> 0)
    # i=2: 1, 0, 1, 0 -> 0 (tie, 2 == 4/2 -> 0)
    # i=3: 0, 0, 0, 0 -> 0 (majority, 0 < 4/2)
    # General: majority is 1 if count > n/2 (n=4, count > 2)
    for i in range(D):
        count = 0
        if hv1[i]:
            count += 1
        if hv2[i]:
            count += 1
        if hv3[i]:
            count += 1
        if hv4[i]:
            count += 1
        expected = count > 2  # Majority for n=4
        assert_equal(
            bundled2[i], expected, "Bundle (n=4) failed at index " + String(i)
        )

    # --- Test Case 3: Single vector ---
    var vectors3 = List[HV[D, DT]]()
    vectors3.append(hv1)
    var bundled3 = HV.bundle_majority[D, DT](vectors3)
    for i in range(D):
        assert_equal(bundled3[i], hv1[i], "Bundle (n=1) failed")

    # --- Test Case 4: Empty list ---
    var vectors_empty = List[HV[D, DT]]()
    with assert_raises():
        var bundled_empty = HV.bundle_majority[D, DT](vectors_empty)


fn test_hvs_operations() raises:
    """Tests HVS functionality including adding, retrieving HVs, and attribute handling."""
    alias D_hvs = 64 * 157  # Default D for HVS
    alias DT_hvs = DType.uint64  # Default dtype for HVS

    var redis_module = Python.import_module("redis")
    var rc: PythonObject
    try:
        rc = redis_module.Redis(host="localhost", port=6379, db=0, decode_responses=True)
        rc.ping()  # Check connection
    except e:
        print("Critical: Failed to connect to Redis for HVS tests: " + String(e))
        raise Error("Redis connection failed, HVS tests cannot proceed.")

    var test_set_name = "mojo_hvs_test_fixture_set_unique123"
    # HVS __init__ already deletes the set, but good practice for robustness
    rc.delete(test_set_name)

    var hvs = HVS[D_hvs, DT_hvs](rc, test_set_name)

    try:
        var hv1 = HV[D_hvs, DT_hvs](key="hv_key_1", attribute="attr_val_1")
        var added_key1 = hvs.add_hv(hv1)
        assert_equal(added_key1, "hv_key_1", "add_hv returned incorrect key")

        var retrieved_hv1 = hvs.hv_from_key("hv_key_1")
        assert_equal(retrieved_hv1.key, "hv_key_1", "Retrieved HV has incorrect key")
        # Attributes are stored as Python dict {'attribute': value}, then stringified
        assert_equal(retrieved_hv1.attribute, "{\'attribute\': \'attr_val_1\'}", "Retrieved HV has incorrect attribute string")
        assert_equal(retrieved_hv1.D, D_hvs, "Retrieved HV has incorrect D")
        assert_equal(retrieved_hv1.dtype, DT_hvs, "Retrieved HV has incorrect dtype")
        for i in range(D_hvs):
            assert_equal(retrieved_hv1[i], hv1[i], "Vector data mismatch for hv1 at index " + String(i))

        var hv2 = HV[D_hvs, DT_hvs](key="hv_key_2", attribute="attr_val_2")
        var hv3 = HV[D_hvs, DT_hvs](key="hv_key_3", attribute="attr_val_3")

        var hvs_to_add_list = List[HV[D_hvs, DT_hvs]]()
        hvs_to_add_list.append(hv2)
        hvs_to_add_list.append(hv3)
        
        var added_keys_list = hvs.add_hvs(hvs_to_add_list)
        assert_equal(len(added_keys_list), 2, "add_hvs returned incorrect number of keys")
        assert_equal(added_keys_list[0], "hv_key_2", "First key from add_hvs mismatch")
        assert_equal(added_keys_list[1], "hv_key_3", "Second key from add_hvs mismatch")

        var retrieved_hv2 = hvs.hv_from_key("hv_key_2")
        assert_equal(retrieved_hv2.key, "hv_key_2")
        assert_equal(retrieved_hv2.attribute, "{\'attribute\': \'attr_val_2\'}")
        for i in range(D_hvs):
            assert_equal(retrieved_hv2[i], hv2[i], "Vector data mismatch for hv2 at index " + String(i))

        var attr_val_from_hvs = hvs.hv_attribute("hv_key_1")
        assert_equal(attr_val_from_hvs, "{\'attribute\': \'attr_val_1\'}", "hv_attribute returned incorrect string")

        var hv_key = hvs.hv_key(retrieved_hv1)
        assert_equal(hv_key, "hv_key_1", "hv_key returned incorrect key")

        var retrieved_hv_from_key = hvs.hv_from_key(hv_key)
        assert_equal(retrieved_hv_from_key.key, "hv_key_1", "Retrieved HV from key has incorrect key")

        var hv = hvs.hv(retrieved_hv1)
        assert_equal(hv.key, "hv_key_1", "hv returned incorrect key")
        
        

    except e:
        print("Critical: Failed to run HVS operations tests: " + String(e))
        raise Error("HVS operations tests failed.")

fn main() raises:
    test_valid_initialization()
    test_invalid_initialization_raises()
    test_getitem_setitem()
    test_bitwise_ops()
    test_arithmetic_ops_disabled()
    test_shift_ops()
    test_pop_count()
    test_bundle_majority()
    test_hvs_operations()

    print("--------------------------------------")
    print("All HV and HVS baseline tests passed!")
    print("--------------------------------------")

