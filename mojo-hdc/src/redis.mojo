from python import Python, PythonObject
from HV import HV, HVS
from collections import List 


fn main() raises:
    var num_vectors: Int = 10
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

    
    alias D = 128
    alias DT = DType.uint64

    var hvs = HVS[D, DT](r, redis_set_name)

    # Create and store HV vectors
    for i in range(num_vectors):
        var hv = HV[D, DT](key="hv_" + String(i), attribute="attr_" + String(i) )

        var py_list_of_ints = hv.to_python_list_of_ints()

        var element_name = "hv_" + String(i)
        print(
            "Adding",
            element_name,
            "to Redis set '" + redis_set_name + "' (dim:",
            D,
            ", quantization: BIN)",
        )

        _ = hvs.add_hv(hv)

    var retrieved_hv = hvs.hv_from_key("hv_0")
    print("Retrieved HV:", retrieved_hv)

    var attributes = hvs.hv_attribute("hv_0")
    print("Attributes:", attributes)

    var hv_key = hvs.hv_key(retrieved_hv)
    print("HV Key:", hv_key)

    var retrieved_hv_from_key = hvs.hv_from_key(hv_key)
    print("Retrieved HV from key:", retrieved_hv_from_key)

    var hv= hvs.hv(retrieved_hv)
    print("HV:", hv)
    

