from python import Python, PythonObject
from HV.hv import HV # Assuming HV.mojo is in src/HV/hv.mojo
from collections import List # Mojo's List for storing one of the Python lists

fn main() raises:
    var num_vectors: Int = 10
    var redis_set_name: String = "mojo_hv_set_binary"

    # Connect to Redis
    var redis_module = Python.import_module("redis")
    var r = redis_module.Redis(host="localhost", port=6379, db=0, decode_responses=True)

    print("Pinging Redis:", r.ping())

    # Ensure the set is clean before starting (optional, good for testing)
    print("Deleting old set (if any):", redis_set_name)
    r.delete(redis_set_name)

    var first_hv_py_list: PythonObject = Python.list()
    # Create and store HV vectors
    for i in range(num_vectors):
        var hv = HV[]()
        var bit_s: String = hv.bits()

        # Convert bit string to Python list of integers [0, 1, 0, 1, ...]
        var py_list_of_ints: PythonObject = Python.list()
        for char_idx in range(len(bit_s)):
            if bit_s[char_idx] == '1':
                py_list_of_ints.append(1)
            else:
                py_list_of_ints.append(0)
        
        if i == 0:
            first_hv_py_list = py_list_of_ints

        var element_name = "hv_" + String(i)
        print("Adding", element_name, "to Redis set '" + redis_set_name + "' (dim:", len(bit_s), ")")
        
        # Add to Redis vector set
        var vset_commands = r.vset()
        var add_result = vset_commands.vadd(redis_set_name, py_list_of_ints, element_name)
        # print("Result of VADD for", element_name, ":", add_result)


    print("Finished adding vectors.")
    var vset_commands = r.vset()
    print("Number of elements in set '" + redis_set_name + "':", vset_commands.vcard(redis_set_name))
    print("Dimension of vectors in set '" + redis_set_name + "':", vset_commands.vdim(redis_set_name))

    # Test retrieval
    if num_vectors > 0 and first_hv_py_list:
        var query_element_name: String = "hv_0"

        print("\nQuerying for vectors similar to", query_element_name, "using its vector data directly:")
        var similar_by_vector = vset_commands.vsim(redis_set_name, first_hv_py_list, count=num_vectors, with_scores=True)
        print("Similar (by vector query):", similar_by_vector)

        print("\nQuerying for vectors similar to", query_element_name, "using its element name:")
        var similar_by_name = vset_commands.vsim(redis_set_name, query_element_name, count=num_vectors, with_scores=True)
        print("Similar (by element name query):", similar_by_name)
    
    # Optional: cleanup by deleting the set
    print("\nDeleting set:", redis_set_name)
    r.delete(redis_set_name)
    print("Set deleted.")
