from python import Python, PythonObject
from HV import HV, HVS
from collections import List


fn main() raises:
    var redis_set_name: String = "mojo_hv_set_binary"

    # Connect to Redis
    var redis_module = Python.import_module("redis")
    var r = redis_module.Redis(
        host="localhost", port=6379, db=0, decode_responses=True
    )

    # Import QuantizationOptions for vector sets
    var VSC = Python.import_module("redis.commands.vectorset.commands")
    var QuantOptions = VSC.QuantizationOptions
    var bin_quantization_option = QuantOptions.BIN

    print("Pinging Redis:", r.ping())

    # Ensure the set is clean before starting (optional, good for testing)
    print("Deleting old set (if any):", redis_set_name)
    r.delete(redis_set_name)

    alias D = 64 * 157
    alias DT = DType.uint64

    var hvs = HVS[D, DT](r, redis_set_name)

    # Create and store HV vectors
    var A = HV[D, DT]("A", "A")
    var B = HV[D, DT]("B", "B")
    var C = HV[D, DT]("C", "C")

    var X = HV[D, DT]("X", "X")
    var Y = HV[D, DT]("Y", "Y")
    var Z = HV[D, DT]("Z", "Z")

    var HV_LIST = List[HV[D, DT]](A, B, C, X, Y, Z)

    var BINDING_LIST = List[HV[D, DT]](A * X, B * Y, C * Z)

    var BUNDLE= HV.bundle_majority[D, DT](BINDING_LIST)

    _ = hvs.add_hvs(HV_LIST)

    for i in range(len(HV_LIST)):
        original = HV_LIST[i]
        var key = hvs.hv_key(BUNDLE * original)
        print(original.key, "-->", key)
