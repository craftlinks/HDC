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

    fn add_hv(self, hv: HV[D, dtype]) raises -> String:
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

    fn add_hvs(self, hvs: List[HV[D, dtype]]) raises -> List[String]:
        var keys = List[String]()
        for i in range(len(hvs)):
            var key = self.add_hv(hvs[i])
            keys.append(key)
        return keys

    fn hv_key(self, hv: HV, num_results: Int = 1) raises -> String:
        var key = self._vset_commands.vsim(self._set_name, hv.to_python_list_of_ints(), count=num_results)
        if len(key) == 0:
            raise Error("No key found for HV")
        return String(key[0])

    fn hv_from_key(self, key: String) raises -> HV[D, dtype]:
        var embedding_py: PythonObject = self._vset_commands.vemb(self._set_name, key)
        var attributes: String = self.hv_attribute(key)
        var embedding_mojo = List[Int]()
        var len_py: Int = len(embedding_py)
        for i in range(len_py):
            var item_py: PythonObject = embedding_py[i]
            embedding_mojo.append(Int(item_py))
        return HV[D, dtype](key, attributes, from_embedding=embedding_mojo)

    fn hv(self, hv: HV, num_results: Int = 1) raises -> HV[D, dtype]:
        var key = self.hv_key(hv, num_results)
        return self.hv_from_key(key)
    
    fn hv_attribute(self, key: String, num_results: Int = 1) raises -> String:
        attributes = self._vset_commands.vgetattr(self._set_name, key)
        return String(attributes)
