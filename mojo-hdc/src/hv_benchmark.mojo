from HV import HV
from builtin.dtype import DType
import benchmark


fn main() raises:
    alias DT = DType.uint64
    alias unit = benchmark.Unit.ns

    print("--- Benchmarking pop_count ---")
    print("Dimension | DType | Mean Time (" + String(unit) + ")")
    print("----------|-------|-------------")

    # --- Benchmarking pop_count for dimensions 2^1 to 2^16 ---
    # Dimension | DType | Mean Time (ns)
    # ----------|-------|-------------
    # 8 | uint8 | 0.393744017
    # 512 | uint8 | 14.33394629235008
    # 1024 | uint8 | 33.09925805654395
    # 16384 | uint8 | 428.7804259197212
    # 512 | uint16 | 7.285890189313022
    # 1024 | uint16 | 14.637118105938756
    # 16384 | uint16 | 249.68040996143648
    # 512 | uint32 | 5.480400165297026
    # 1024 | uint32 | 12.059375823486247
    # 16384 | uint32 | 162.50392996634355
    # 512 | uint64 | 3.3303058981640477
    # 1024 | uint64 | 6.280068170967351
    # 16384 | uint64 | 69.88876883225929

    var HV_8_uint8 = HV[2**3, DType.uint8]()
    var HV_512_uint8 = HV[2**9, DType.uint8]()
    var HV_1024_uint8 = HV[2**10, DType.uint8]()
    var HV_16384_uint8 = HV[2**14, DType.uint8]()

    var HV_512_uint16 = HV[2**9, DType.uint16]()
    var HV_1024_uint16 = HV[2**10, DType.uint16]()
    var HV_16384_uint16 = HV[2**14, DType.uint16]()

    var HV_512_uint32 = HV[2**9, DType.uint32]()
    var HV_1024_uint32 = HV[2**10, DType.uint32]()
    var HV_16384_uint32 = HV[2**14, DType.uint32]()

    var HV_512_uint64 = HV[2**9, DType.uint64]()
    var HV_1024_uint64 = HV[2**10, DType.uint64]()
    var HV_16384_uint64 = HV[2**14, DType.uint64]()

    # Second set for XOR operation
    var HV_8_uint8_b = HV[2**3, DType.uint8]()
    var HV_512_uint8_b = HV[2**9, DType.uint8]()
    var HV_1024_uint8_b = HV[2**10, DType.uint8]()
    var HV_16384_uint8_b = HV[2**14, DType.uint8]()

    var HV_512_uint16_b = HV[2**9, DType.uint16]()
    var HV_1024_uint16_b = HV[2**10, DType.uint16]()
    var HV_16384_uint16_b = HV[2**14, DType.uint16]()

    var HV_512_uint32_b = HV[2**9, DType.uint32]()
    var HV_1024_uint32_b = HV[2**10, DType.uint32]()
    var HV_16384_uint32_b = HV[2**14, DType.uint32]()

    var HV_512_uint64_b = HV[2**9, DType.uint64]()
    var HV_1024_uint64_b = HV[2**10, DType.uint64]()
    var HV_16384_uint64_b = HV[2**14, DType.uint64]()

    # Define the benchmark function for pop_count
    @parameter
    fn bench_pop_count_8():
        var pop_count_time = HV_8_uint8.pop_count()
        benchmark.keep(pop_count_time)

    @parameter
    fn bench_pop_count_512():
        var pop_count_time = HV_512_uint8.pop_count()
        benchmark.keep(pop_count_time)

    @parameter
    fn bench_pop_count_1024():
        var pop_count_time = HV_1024_uint8.pop_count()
        benchmark.keep(pop_count_time)

    @parameter
    fn bench_pop_count_16384():
        var pop_count_time = HV_16384_uint8.pop_count()
        benchmark.keep(pop_count_time)

    @parameter
    fn bench_pop_count_512_uint16():
        var pop_count_time = HV_512_uint16.pop_count()
        benchmark.keep(pop_count_time)

    @parameter
    fn bench_pop_count_1024_uint16():
        var pop_count_time = HV_1024_uint16.pop_count()
        benchmark.keep(pop_count_time)

    @parameter
    fn bench_pop_count_16384_uint16():
        var pop_count_time = HV_16384_uint16.pop_count()
        benchmark.keep(pop_count_time)

    @parameter
    fn bench_pop_count_512_uint32():
        var pop_count_time = HV_512_uint32.pop_count()
        benchmark.keep(pop_count_time)

    @parameter
    fn bench_pop_count_1024_uint32():
        var pop_count_time = HV_1024_uint32.pop_count()
        benchmark.keep(pop_count_time)

    @parameter
    fn bench_pop_count_16384_uint32():
        var pop_count_time = HV_16384_uint32.pop_count()
        benchmark.keep(pop_count_time)

    @parameter
    fn bench_pop_count_512_uint64():
        var pop_count_time = HV_512_uint64.pop_count()
        benchmark.keep(pop_count_time)

    @parameter
    fn bench_pop_count_1024_uint64():
        var pop_count_time = HV_1024_uint64.pop_count()
        benchmark.keep(pop_count_time)

    @parameter
    fn bench_pop_count_16384_uint64():
        var pop_count_time = HV_16384_uint64.pop_count()
        benchmark.keep(pop_count_time)

    # Define the benchmark function for __xor__
    @parameter
    fn bench_xor_8() raises:
        var xor_res = HV_8_uint8 ^ HV_8_uint8_b
        benchmark.keep(xor_res._storage)

    @parameter
    fn bench_xor_512() raises:
        var xor_res = HV_512_uint8 ^ HV_512_uint8_b
        benchmark.keep(xor_res._storage)

    @parameter
    fn bench_xor_1024() raises:
        var xor_res = HV_1024_uint8 ^ HV_1024_uint8_b
        benchmark.keep(xor_res._storage)

    @parameter
    fn bench_xor_16384() raises:
        var xor_res = HV_16384_uint8 ^ HV_16384_uint8_b
        benchmark.keep(xor_res._storage)

    @parameter
    fn bench_xor_512_uint16() raises:
        var xor_res = HV_512_uint16 ^ HV_512_uint16_b
        benchmark.keep(xor_res._storage)

    @parameter
    fn bench_xor_1024_uint16() raises:
        var xor_res = HV_1024_uint16 ^ HV_1024_uint16_b
        benchmark.keep(xor_res._storage)

    @parameter
    fn bench_xor_16384_uint16() raises:
        var xor_res = HV_16384_uint16 ^ HV_16384_uint16_b
        benchmark.keep(xor_res._storage)

    @parameter
    fn bench_xor_512_uint32() raises:
        var xor_res = HV_512_uint32 ^ HV_512_uint32_b
        benchmark.keep(xor_res._storage)

    @parameter
    fn bench_xor_1024_uint32() raises:
        var xor_res = HV_1024_uint32 ^ HV_1024_uint32_b
        benchmark.keep(xor_res._storage)

    @parameter
    fn bench_xor_16384_uint32() raises:
        var xor_res = HV_16384_uint32 ^ HV_16384_uint32_b
        benchmark.keep(xor_res._storage)

    @parameter
    fn bench_xor_512_uint64() raises:
        var xor_res = HV_512_uint64 ^ HV_512_uint64_b
        benchmark.keep(xor_res._storage)

    @parameter
    fn bench_xor_1024_uint64() raises:
        var xor_res = HV_1024_uint64 ^ HV_1024_uint64_b
        benchmark.keep(xor_res._storage)

    @parameter
    fn bench_xor_16384_uint64() raises:
        var xor_res = HV_16384_uint64 ^ HV_16384_uint64_b
        benchmark.keep(xor_res._storage)

    # Run the pop_count benchmark
    var pop_count_time_8 = benchmark.run[bench_pop_count_8]().mean(unit)
    print(HV_8_uint8.D, "|", "uint8", "|", pop_count_time_8)
    var pop_count_time_512 = benchmark.run[bench_pop_count_512]().mean(unit)
    print(HV_512_uint8.D, "|", "uint8", "|", pop_count_time_512)
    var pop_count_time_1024 = benchmark.run[bench_pop_count_1024]().mean(unit)
    print(HV_1024_uint8.D, "|", "uint8", "|", pop_count_time_1024)
    var pop_count_time_16384 = benchmark.run[bench_pop_count_16384]().mean(unit)
    print(HV_16384_uint8.D, "|", "uint8", "|", pop_count_time_16384)
    var pop_count_time_512_uint16 = benchmark.run[
        bench_pop_count_512_uint16
    ]().mean(unit)
    print(HV_512_uint16.D, "|", "uint16", "|", pop_count_time_512_uint16)
    var pop_count_time_1024_uint16 = benchmark.run[
        bench_pop_count_1024_uint16
    ]().mean(unit)
    print(HV_1024_uint16.D, "|", "uint16", "|", pop_count_time_1024_uint16)
    var pop_count_time_16384_uint16 = benchmark.run[
        bench_pop_count_16384_uint16
    ]().mean(unit)
    print(HV_16384_uint16.D, "|", "uint16", "|", pop_count_time_16384_uint16)
    var pop_count_time_512_uint32 = benchmark.run[
        bench_pop_count_512_uint32
    ]().mean(unit)
    print(HV_512_uint32.D, "|", "uint32", "|", pop_count_time_512_uint32)
    var pop_count_time_1024_uint32 = benchmark.run[
        bench_pop_count_1024_uint32
    ]().mean(unit)
    print(HV_1024_uint32.D, "|", "uint32", "|", pop_count_time_1024_uint32)
    var pop_count_time_16384_uint32 = benchmark.run[
        bench_pop_count_16384_uint32
    ]().mean(unit)
    print(HV_16384_uint32.D, "|", "uint32", "|", pop_count_time_16384_uint32)
    var pop_count_time_512_uint64 = benchmark.run[
        bench_pop_count_512_uint64
    ]().mean(unit)
    print(HV_512_uint64.D, "|", "uint64", "|", pop_count_time_512_uint64)
    var pop_count_time_1024_uint64 = benchmark.run[
        bench_pop_count_1024_uint64
    ]().mean(unit)
    print(HV_1024_uint64.D, "|", "uint64", "|", pop_count_time_1024_uint64)
    var pop_count_time_16384_uint64 = benchmark.run[
        bench_pop_count_16384_uint64
    ]().mean(unit)
    print(HV_16384_uint64.D, "|", "uint64", "|", pop_count_time_16384_uint64)

    print("--- Benchmarking __xor__ ---")
    print("Dimension | DType | Mean Time (" + String(unit) + ")")
    print("----------|-------|-------------")
    # --- Benchmarking __xor__
    # Dimension | DType | Mean Time (ns)
    # ----------|-------|-------------
    # 8 | uint8 | 31.955487437508935
    # 512 | uint8 | 310.899627772558
    # 1024 | uint8 | 508.3974779900403
    # 16384 | uint8 | 7377.897763028515
    # 512 | uint16 | 150.54923737055552
    # 1024 | uint16 | 285.758220781942
    # 16384 | uint16 | 3931.4772626635795
    # 512 | uint32 | 288.87093500504136
    # 1024 | uint32 | 535.0500618117169
    # 16384 | uint32 | 8086.784779390203
    # 512 | uint64 | 151.0833300120534
    # 1024 | uint64 | 303.0889292844142
    # 16384 | uint64 | 4354.444316181701

    # Run the __xor__ benchmark
    var xor_time_8 = benchmark.run[bench_xor_8]().mean(unit)
    print(HV_8_uint8.D, "|", "uint8", "|", xor_time_8)
    var xor_time_512 = benchmark.run[bench_xor_512]().mean(unit)
    print(HV_512_uint8.D, "|", "uint8", "|", xor_time_512)
    var xor_time_1024 = benchmark.run[bench_xor_1024]().mean(unit)
    print(HV_1024_uint8.D, "|", "uint8", "|", xor_time_1024)
    var xor_time_16384 = benchmark.run[bench_xor_16384]().mean(unit)
    print(HV_16384_uint8.D, "|", "uint8", "|", xor_time_16384)
    var xor_time_512_uint16 = benchmark.run[bench_xor_512_uint16]().mean(unit)
    print(HV_512_uint16.D, "|", "uint16", "|", xor_time_512_uint16)
    var xor_time_1024_uint16 = benchmark.run[bench_xor_1024_uint16]().mean(unit)
    print(HV_1024_uint16.D, "|", "uint16", "|", xor_time_1024_uint16)
    var xor_time_16384_uint16 = benchmark.run[bench_xor_16384_uint16]().mean(
        unit
    )
    print(HV_16384_uint16.D, "|", "uint16", "|", xor_time_16384_uint16)
    var xor_time_512_uint32 = benchmark.run[bench_xor_512_uint32]().mean(unit)
    print(HV_512_uint32.D, "|", "uint32", "|", xor_time_512_uint32)
    var xor_time_1024_uint32 = benchmark.run[bench_xor_1024_uint32]().mean(unit)
    print(HV_1024_uint32.D, "|", "uint32", "|", xor_time_1024_uint32)
    var xor_time_16384_uint32 = benchmark.run[bench_xor_16384_uint32]().mean(
        unit
    )
    print(HV_16384_uint32.D, "|", "uint32", "|", xor_time_16384_uint32)
    var xor_time_512_uint64 = benchmark.run[bench_xor_512_uint64]().mean(unit)
    print(HV_512_uint64.D, "|", "uint64", "|", xor_time_512_uint64)
    var xor_time_1024_uint64 = benchmark.run[bench_xor_1024_uint64]().mean(unit)
    print(HV_1024_uint64.D, "|", "uint64", "|", xor_time_1024_uint64)
    var xor_time_16384_uint64 = benchmark.run[bench_xor_16384_uint64]().mean(
        unit
    )
    print(HV_16384_uint64.D, "|", "uint64", "|", xor_time_16384_uint64)
