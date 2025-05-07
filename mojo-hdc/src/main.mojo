from HV import HV, HVS
from collections import List
import benchmark
from python import Python, PythonObject


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
    print("hv1_rshift: ", hv1 >> 1)

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

    # Test the new bits() method
    print("hv_bundle.bits(): ", hv_bundle.bits())

    # Test the new hvs.mojo

    # Connect to Redis
    var redis_module = Python.import_module("redis")
    var r = redis_module.Redis(
        host="localhost", port=6379, db=0, decode_responses=True
    )
    print("r: ", r)

    var hvs = HVS[D, DT](r)
    print("hvs initialized")
    var hv = HV[D, DT](key="test_hv", attribute="REDIS_TEST")
    print("hv: ", hv)
    key = hvs.add_hv(hv)
    print("key: ", key)
    retrieved_hv = hvs.hv(key)
    print("retrieved_hv: ", retrieved_hv)
    var attributes = hvs.hv_attribute(key)
    print("attributes: ", attributes)


    # TODO: fix this
    # with HVS[D, DT](r) as new_hvs:
    #     new_hvs.add_hv(hv)
    #     print("new_hvs: ", new_hvs)
