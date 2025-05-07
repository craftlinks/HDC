from python import Python, PythonObject
from HV.hv import HV
from collections import List

struct HVS[D: Int = 64*157, dtype: DType = DType.uint64]:
    var _redis: PythonObject
    var _vset_commands: PythonObject
    var _bin_quantization_option: PythonObject
    var _set_name: String

    fn __init__(out self, rc: PythonObject, set_name: String = "mojo_hv_set_binary") raises:
        self._redis = rc  # redis-cli
        self._set_name = set_name

        # Import QuantizationOptions for vector sets
        var VSC = Python.import_module("redis.commands.vectorset.commands")
        var QuantOptions = VSC.QuantizationOptions
        self._bin_quantization_option = QuantOptions.BIN
        
        # Get the vset commands
        self._vset_commands = self._redis.vset()

        # Delete the set if it already exists
        self._redis.delete(self._set_name)

    fn add_hv(self, hv: HV) raises -> String:
        # Check if the hv is of the correct type
        if hv.D != D or hv.dtype != dtype:
            raise Error("HV dimensions and data type must match the HVS dimensions and data type")
        
        var _attributes = Python.dict()
        _attributes["attribute"] = hv.attribute
        
        self._vset_commands.vadd(
            self._set_name,
            hv.to_python_list_of_ints(),
            hv.key,
            attributes=_attributes,
            quantization=self._bin_quantization_option,
        )
        return hv.key
    fn hv_key(self, hv: HV, num_results: Int = 1) raises -> String:
        var key = self._vset_commands.vsim(self._set_name, hv.to_python_list_of_ints(), count=num_results)
        return String(key)

    fn hv(self, key: String) raises -> HV[D, dtype]:
        var embedding_py: PythonObject = self._vset_commands.vemb(self._set_name, key)
        var attributes: String = self.hv_attribute(key)
        var embedding_mojo = List[Int]()
        var len_py: Int = len(embedding_py)
        for i in range(len_py):
            var item_py: PythonObject = embedding_py[i]
            embedding_mojo.append(Int(item_py))
        return HV[D, dtype](key, attributes, from_embedding=embedding_mojo)
    
    fn hv_attribute(self, key: String, num_results: Int = 1) raises -> String:
        attributes = self._vset_commands.vgetattr(self._set_name, key)
        return String(attributes)
    
    fn __exit__(self) raises:
        print("Deleting set:", self._set_name)
        self._redis.delete(self._set_name)
