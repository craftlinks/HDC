from HV import HV
from collections import List
import benchmark


def main():
    alias D = 64
    alias DT = DType.uint64
    var hv1 = HV[D, DT]()
    var hv2 = HV[D, DT]()

    for i in range(D):
        hv1[i] = i % 2 == 0  # 1010101...
        hv2[i] = i % 3 == 0  # 1001001...

    print("hv1: ", hv1)
    print("hv2: ", hv2)

    var hv_mul = hv1 * hv2
    print("hv_mul: ", hv_mul)

    # AND (&)
    print("hv_and: ", hv1 & hv2)

    # OR (|)
    print("hv_or: ", hv1 | hv2)

    # XOR (^)
    print("hv_xor: ", hv1 ^ hv2)

    # INVERT (~)
    print("hv1_inv: ", ~hv1)

    # bind (should be same as XOR)
    print("hv_bind: ", hv1.bind(hv2))

    # lshift
    print("hv1_lshift: ", hv1 << 1)

    # rshift
    print("hv1_rshift: ", hv1 >> 2)

    # pop_count
    print("hv1_pop_count: ", hv1.pop_count())

    var hv3 = HV[D, DT]()

    # Create a pattern: 1111000000000000
    for i in range(D):
        hv3[i] = i < 4

    print("hv3: ", hv3)

    # Left shift by 2: 1100000000000011
    var hv_lshift = hv3 << 2
    print("hv_lshift: ", hv_lshift)
    var hv_rshift = hv3 >> 2
    print("hv_rshift: ", hv_rshift)

    # bundle
    # Explicitly create List and pass params directly to method
    var vector_list = List[HV[D, DT]]()
    vector_list.append(hv1)
    vector_list.append(hv2)
    vector_list.append(hv3)
    var hv_bundle = HV.bundle_majority[D, DT](vector_list)
    print("hv_bundle: ", hv_bundle)
