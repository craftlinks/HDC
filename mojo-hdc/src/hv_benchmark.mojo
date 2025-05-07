from HV import HV
from builtin.dtype import DType
import benchmark
from collections import List  # Added for bundle_majority
from sys import argv  # Added for command-line arguments

alias DT = DType.uint64
alias unit = benchmark.Unit.ns


fn main() raises:
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

    # Third set for bundle_majority operation (c)
    var HV_8_uint8_c = HV[2**3, DType.uint8]()
    var HV_512_uint8_c = HV[2**9, DType.uint8]()
    var HV_1024_uint8_c = HV[2**10, DType.uint8]()
    var HV_16384_uint8_c = HV[2**14, DType.uint8]()

    var HV_512_uint16_c = HV[2**9, DType.uint16]()
    var HV_1024_uint16_c = HV[2**10, DType.uint16]()
    var HV_16384_uint16_c = HV[2**14, DType.uint16]()

    var HV_512_uint32_c = HV[2**9, DType.uint32]()
    var HV_1024_uint32_c = HV[2**10, DType.uint32]()
    var HV_16384_uint32_c = HV[2**14, DType.uint32]()

    var HV_512_uint64_c = HV[2**9, DType.uint64]()
    var HV_1024_uint64_c = HV[2**10, DType.uint64]()
    var HV_16384_uint64_c = HV[2**14, DType.uint64]()

    # Fourth set for bundle_majority operation (d)
    var HV_8_uint8_d = HV[2**3, DType.uint8]()
    var HV_512_uint8_d = HV[2**9, DType.uint8]()
    var HV_1024_uint8_d = HV[2**10, DType.uint8]()
    var HV_16384_uint8_d = HV[2**14, DType.uint8]()

    var HV_512_uint16_d = HV[2**9, DType.uint16]()
    var HV_1024_uint16_d = HV[2**10, DType.uint16]()
    var HV_16384_uint16_d = HV[2**14, DType.uint16]()

    var HV_512_uint32_d = HV[2**9, DType.uint32]()
    var HV_1024_uint32_d = HV[2**10, DType.uint32]()
    var HV_16384_uint32_d = HV[2**14, DType.uint32]()

    var HV_512_uint64_d = HV[2**9, DType.uint64]()
    var HV_1024_uint64_d = HV[2**10, DType.uint64]()
    var HV_16384_uint64_d = HV[2**14, DType.uint64]()

    # Fifth set for bundle_majority operation (e)
    var HV_8_uint8_e = HV[2**3, DType.uint8]()
    var HV_512_uint8_e = HV[2**9, DType.uint8]()
    var HV_1024_uint8_e = HV[2**10, DType.uint8]()
    var HV_16384_uint8_e = HV[2**14, DType.uint8]()

    var HV_512_uint16_e = HV[2**9, DType.uint16]()
    var HV_1024_uint16_e = HV[2**10, DType.uint16]()
    var HV_16384_uint16_e = HV[2**14, DType.uint16]()

    var HV_512_uint32_e = HV[2**9, DType.uint32]()
    var HV_1024_uint32_e = HV[2**10, DType.uint32]()
    var HV_16384_uint32_e = HV[2**14, DType.uint32]()

    var HV_512_uint64_e = HV[2**9, DType.uint64]()
    var HV_1024_uint64_e = HV[2**10, DType.uint64]()
    var HV_16384_uint64_e = HV[2**14, DType.uint64]()

    # Sixth set for bundle_majority operation (f)
    var HV_8_uint8_f = HV[2**3, DType.uint8]()
    var HV_512_uint8_f = HV[2**9, DType.uint8]()
    var HV_1024_uint8_f = HV[2**10, DType.uint8]()
    var HV_16384_uint8_f = HV[2**14, DType.uint8]()

    var HV_512_uint16_f = HV[2**9, DType.uint16]()
    var HV_1024_uint16_f = HV[2**10, DType.uint16]()
    var HV_16384_uint16_f = HV[2**14, DType.uint16]()

    var HV_512_uint32_f = HV[2**9, DType.uint32]()
    var HV_1024_uint32_f = HV[2**10, DType.uint32]()
    var HV_16384_uint32_f = HV[2**14, DType.uint32]()

    var HV_512_uint64_f = HV[2**9, DType.uint64]()
    var HV_1024_uint64_f = HV[2**10, DType.uint64]()
    var HV_16384_uint64_f = HV[2**14, DType.uint64]()

    # Seventh set for bundle_majority operation (g)
    var HV_8_uint8_g = HV[2**3, DType.uint8]()
    var HV_512_uint8_g = HV[2**9, DType.uint8]()
    var HV_1024_uint8_g = HV[2**10, DType.uint8]()
    var HV_16384_uint8_g = HV[2**14, DType.uint8]()

    var HV_512_uint16_g = HV[2**9, DType.uint16]()
    var HV_1024_uint16_g = HV[2**10, DType.uint16]()
    var HV_16384_uint16_g = HV[2**14, DType.uint16]()

    var HV_512_uint32_g = HV[2**9, DType.uint32]()
    var HV_1024_uint32_g = HV[2**10, DType.uint32]()
    var HV_16384_uint32_g = HV[2**14, DType.uint32]()

    var HV_512_uint64_g = HV[2**9, DType.uint64]()
    var HV_1024_uint64_g = HV[2**10, DType.uint64]()
    var HV_16384_uint64_g = HV[2**14, DType.uint64]()

    # Eighth set for bundle_majority operation (h)
    var HV_8_uint8_h = HV[2**3, DType.uint8]()
    var HV_512_uint8_h = HV[2**9, DType.uint8]()
    var HV_1024_uint8_h = HV[2**10, DType.uint8]()
    var HV_16384_uint8_h = HV[2**14, DType.uint8]()

    var HV_512_uint16_h = HV[2**9, DType.uint16]()
    var HV_1024_uint16_h = HV[2**10, DType.uint16]()
    var HV_16384_uint16_h = HV[2**14, DType.uint16]()

    var HV_512_uint32_h = HV[2**9, DType.uint32]()
    var HV_1024_uint32_h = HV[2**10, DType.uint32]()
    var HV_16384_uint32_h = HV[2**14, DType.uint32]()

    var HV_512_uint64_h = HV[2**9, DType.uint64]()
    var HV_1024_uint64_h = HV[2**10, DType.uint64]()
    var HV_16384_uint64_h = HV[2**14, DType.uint64]()

    # Ninth set for bundle_majority operation (i)
    var HV_8_uint8_i = HV[2**3, DType.uint8]()
    var HV_512_uint8_i = HV[2**9, DType.uint8]()
    var HV_1024_uint8_i = HV[2**10, DType.uint8]()
    var HV_16384_uint8_i = HV[2**14, DType.uint8]()

    var HV_512_uint16_i = HV[2**9, DType.uint16]()
    var HV_1024_uint16_i = HV[2**10, DType.uint16]()
    var HV_16384_uint16_i = HV[2**14, DType.uint16]()

    var HV_512_uint32_i = HV[2**9, DType.uint32]()
    var HV_1024_uint32_i = HV[2**10, DType.uint32]()
    var HV_16384_uint32_i = HV[2**14, DType.uint32]()

    var HV_512_uint64_i = HV[2**9, DType.uint64]()
    var HV_1024_uint64_i = HV[2**10, DType.uint64]()
    var HV_16384_uint64_i = HV[2**14, DType.uint64]()

    # Tenth set for bundle_majority operation (j)
    var HV_8_uint8_j = HV[2**3, DType.uint8]()
    var HV_512_uint8_j = HV[2**9, DType.uint8]()
    var HV_1024_uint8_j = HV[2**10, DType.uint8]()
    var HV_16384_uint8_j = HV[2**14, DType.uint8]()

    var HV_512_uint16_j = HV[2**9, DType.uint16]()
    var HV_1024_uint16_j = HV[2**10, DType.uint16]()
    var HV_16384_uint16_j = HV[2**14, DType.uint16]()

    var HV_512_uint32_j = HV[2**9, DType.uint32]()
    var HV_1024_uint32_j = HV[2**10, DType.uint32]()
    var HV_16384_uint32_j = HV[2**14, DType.uint32]()

    var HV_512_uint64_j = HV[2**9, DType.uint64]()
    var HV_1024_uint64_j = HV[2**10, DType.uint64]()
    var HV_16384_uint64_j = HV[2**14, DType.uint64]()

    fn benchmark_creation() raises:
        print("--- Benchmarking HV Creation ---")
        print("Dimension | DType | Mean Time (" + String(unit) + ")")
        print("----------|-------|-------------")

        # --- Benchmarking HV Creation ---
        # Dimension | DType | Mean Time (ns)
        # ----------|-------|-------------
        # 8 | uint8 | 27.018865598835806
        # 512 | uint8 | 243.84073848793255
        # 1024 | uint8 | 479.5606531824031
        # 16384 | uint8 | 7076.82025732662
        # 512 | uint16 | 141.12699269054687
        # 1024 | uint16 | 265.36346660502574
        # 16384 | uint16 | 3955.529341766707
        # 512 | uint32 | 273.55596133045935
        # 1024 | uint32 | 522.1371910834515
        # 16384 | uint32 | 8003.977495629895
        # 512 | uint64 | 150.82250099748822
        # 1024 | uint64 | 276.73295871551437
        # 16384 | uint64 | 4088.781991320749

        @parameter
        fn bench_creation_8_uint8() raises:
            var hv = HV[2**3, DType.uint8]()
            benchmark.keep(hv._storage)

        @parameter
        fn bench_creation_512_uint8() raises:
            var hv = HV[2**9, DType.uint8]()
            benchmark.keep(hv._storage)

        @parameter
        fn bench_creation_1024_uint8() raises:
            var hv = HV[2**10, DType.uint8]()
            benchmark.keep(hv._storage)

        @parameter
        fn bench_creation_16384_uint8() raises:
            var hv = HV[2**14, DType.uint8]()
            benchmark.keep(hv._storage)

        @parameter
        fn bench_creation_512_uint16() raises:
            var hv = HV[2**9, DType.uint16]()
            benchmark.keep(hv._storage)

        @parameter
        fn bench_creation_1024_uint16() raises:
            var hv = HV[2**10, DType.uint16]()
            benchmark.keep(hv._storage)

        @parameter
        fn bench_creation_16384_uint16() raises:
            var hv = HV[2**14, DType.uint16]()
            benchmark.keep(hv._storage)

        @parameter
        fn bench_creation_512_uint32() raises:
            var hv = HV[2**9, DType.uint32]()
            benchmark.keep(hv._storage)

        @parameter
        fn bench_creation_1024_uint32() raises:
            var hv = HV[2**10, DType.uint32]()
            benchmark.keep(hv._storage)

        @parameter
        fn bench_creation_16384_uint32() raises:
            var hv = HV[2**14, DType.uint32]()
            benchmark.keep(hv._storage)

        @parameter
        fn bench_creation_512_uint64() raises:
            var hv = HV[2**9, DType.uint64]()
            benchmark.keep(hv._storage)

        @parameter
        fn bench_creation_1024_uint64() raises:
            var hv = HV[2**10, DType.uint64]()
            benchmark.keep(hv._storage)

        @parameter
        fn bench_creation_16384_uint64() raises:
            var hv = HV[2**14, DType.uint64]()
            benchmark.keep(hv._storage)

        var creation_time_8_uint8 = benchmark.run[
            bench_creation_8_uint8
        ]().mean(unit)
        print(String(2**3) + " | uint8 | " + String(creation_time_8_uint8))
        var creation_time_512_uint8 = benchmark.run[
            bench_creation_512_uint8
        ]().mean(unit)
        print(String(2**9) + " | uint8 | " + String(creation_time_512_uint8))
        var creation_time_1024_uint8 = benchmark.run[
            bench_creation_1024_uint8
        ]().mean(unit)
        print(
            String(2**10) + " | uint8 | " + String(creation_time_1024_uint8)
        )
        var creation_time_16384_uint8 = benchmark.run[
            bench_creation_16384_uint8
        ]().mean(unit)
        print(
            String(2**14) + " | uint8 | " + String(creation_time_16384_uint8)
        )

        var creation_time_512_uint16 = benchmark.run[
            bench_creation_512_uint16
        ]().mean(unit)
        print(
            String(2**9) + " | uint16 | " + String(creation_time_512_uint16)
        )
        var creation_time_1024_uint16 = benchmark.run[
            bench_creation_1024_uint16
        ]().mean(unit)
        print(
            String(2**10) + " | uint16 | " + String(creation_time_1024_uint16)
        )
        var creation_time_16384_uint16 = benchmark.run[
            bench_creation_16384_uint16
        ]().mean(unit)
        print(
            String(2**14)
            + " | uint16 | "
            + String(creation_time_16384_uint16)
        )

        var creation_time_512_uint32 = benchmark.run[
            bench_creation_512_uint32
        ]().mean(unit)
        print(
            String(2**9) + " | uint32 | " + String(creation_time_512_uint32)
        )
        var creation_time_1024_uint32 = benchmark.run[
            bench_creation_1024_uint32
        ]().mean(unit)
        print(
            String(2**10) + " | uint32 | " + String(creation_time_1024_uint32)
        )
        var creation_time_16384_uint32 = benchmark.run[
            bench_creation_16384_uint32
        ]().mean(unit)
        print(
            String(2**14)
            + " | uint32 | "
            + String(creation_time_16384_uint32)
        )

        var creation_time_512_uint64 = benchmark.run[
            bench_creation_512_uint64
        ]().mean(unit)
        print(
            String(2**9) + " | uint64 | " + String(creation_time_512_uint64)
        )
        var creation_time_1024_uint64 = benchmark.run[
            bench_creation_1024_uint64
        ]().mean(unit)
        print(
            String(2**10) + " | uint64 | " + String(creation_time_1024_uint64)
        )
        var creation_time_16384_uint64 = benchmark.run[
            bench_creation_16384_uint64
        ]().mean(unit)
        print(
            String(2**14)
            + " | uint64 | "
            + String(creation_time_16384_uint64)
        )

    @parameter
    fn benchmark_pop_count() raises:
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

        # Run the pop_count benchmark
        var pop_count_time_8 = benchmark.run[bench_pop_count_8]().mean(unit)
        print(HV_8_uint8.D, "|", "uint8", "|", pop_count_time_8)
        var pop_count_time_512 = benchmark.run[bench_pop_count_512]().mean(unit)
        print(HV_512_uint8.D, "|", "uint8", "|", pop_count_time_512)
        var pop_count_time_1024 = benchmark.run[bench_pop_count_1024]().mean(
            unit
        )
        print(HV_1024_uint8.D, "|", "uint8", "|", pop_count_time_1024)
        var pop_count_time_16384 = benchmark.run[bench_pop_count_16384]().mean(
            unit
        )
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
        print(
            HV_16384_uint16.D, "|", "uint16", "|", pop_count_time_16384_uint16
        )
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
        print(
            HV_16384_uint32.D, "|", "uint32", "|", pop_count_time_16384_uint32
        )
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
        print(
            HV_16384_uint64.D, "|", "uint64", "|", pop_count_time_16384_uint64
        )

    fn benchmark_xor() raises:
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
        # 512 | uint64 | 151.08333001205345
        # 1024 | uint64 | 303.0889292844142
        # 16384 | uint64 | 4354.444316181701

        # --- Benchmarking __xor__ ---
        # Dimension | DType | Mean Time (ns)
        # ----------|-------|-------------
        # 8 | uint8 | 27.0750141431035
        # 512 | uint8 | 251.0505127052525
        # 1024 | uint8 | 479.44626829205436
        # 16384 | uint8 | 7297.32005210908
        # 512 | uint16 | 151.2165301604027
        # 1024 | uint16 | 266.295739177383
        # 16384 | uint16 | 3731.0073154520346
        # 512 | uint32 | 270.59313325747485
        # 1024 | uint32 | 518.6335545133985
        # 16384 | uint32 | 7968.210417889949
        # 512 | uint64 | 146.09206409269925
        # 1024 | uint64 | 274.43431551448714
        # 16384 | uint64 | 4094.199124580962

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

        # Run the __xor__ benchmark
        var xor_time_8 = benchmark.run[bench_xor_8]().mean(unit)
        print(HV_8_uint8.D, "|", "uint8", "|", xor_time_8)
        var xor_time_512 = benchmark.run[bench_xor_512]().mean(unit)
        print(HV_512_uint8.D, "|", "uint8", "|", xor_time_512)
        var xor_time_1024 = benchmark.run[bench_xor_1024]().mean(unit)
        print(HV_1024_uint8.D, "|", "uint8", "|", xor_time_1024)
        var xor_time_16384 = benchmark.run[bench_xor_16384]().mean(unit)
        print(HV_16384_uint8.D, "|", "uint8", "|", xor_time_16384)
        var xor_time_512_uint16 = benchmark.run[bench_xor_512_uint16]().mean(
            unit
        )
        print(HV_512_uint16.D, "|", "uint16", "|", xor_time_512_uint16)
        var xor_time_1024_uint16 = benchmark.run[bench_xor_1024_uint16]().mean(
            unit
        )
        print(HV_1024_uint16.D, "|", "uint16", "|", xor_time_1024_uint16)
        var xor_time_16384_uint16 = benchmark.run[
            bench_xor_16384_uint16
        ]().mean(unit)
        print(HV_16384_uint16.D, "|", "uint16", "|", xor_time_16384_uint16)
        var xor_time_512_uint32 = benchmark.run[bench_xor_512_uint32]().mean(
            unit
        )
        print(HV_512_uint32.D, "|", "uint32", "|", xor_time_512_uint32)
        var xor_time_1024_uint32 = benchmark.run[bench_xor_1024_uint32]().mean(
            unit
        )
        print(HV_1024_uint32.D, "|", "uint32", "|", xor_time_1024_uint32)
        var xor_time_16384_uint32 = benchmark.run[
            bench_xor_16384_uint32
        ]().mean(unit)
        print(HV_16384_uint32.D, "|", "uint32", "|", xor_time_16384_uint32)
        var xor_time_512_uint64 = benchmark.run[bench_xor_512_uint64]().mean(
            unit
        )
        print(HV_512_uint64.D, "|", "uint64", "|", xor_time_512_uint64)
        var xor_time_1024_uint64 = benchmark.run[bench_xor_1024_uint64]().mean(
            unit
        )
        print(HV_1024_uint64.D, "|", "uint64", "|", xor_time_1024_uint64)
        var xor_time_16384_uint64 = benchmark.run[
            bench_xor_16384_uint64
        ]().mean(unit)
        print(HV_16384_uint64.D, "|", "uint64", "|", xor_time_16384_uint64)

    fn benchmark_and() raises:
        # __and__
        @parameter
        fn bench_and_8() raises:
            var res = HV_8_uint8 & HV_8_uint8_b
            benchmark.keep(res._storage)

        @parameter
        fn bench_and_512() raises:
            var res = HV_512_uint8 & HV_512_uint8_b
            benchmark.keep(res._storage)

        @parameter
        fn bench_and_1024() raises:
            var res = HV_1024_uint8 & HV_1024_uint8_b
            benchmark.keep(res._storage)

        @parameter
        fn bench_and_16384() raises:
            var res = HV_16384_uint8 & HV_16384_uint8_b
            benchmark.keep(res._storage)

        @parameter
        fn bench_and_512_uint16() raises:
            var res = HV_512_uint16 & HV_512_uint16_b
            benchmark.keep(res._storage)

        @parameter
        fn bench_and_1024_uint16() raises:
            var res = HV_1024_uint16 & HV_1024_uint16_b
            benchmark.keep(res._storage)

        @parameter
        fn bench_and_16384_uint16() raises:
            var res = HV_16384_uint16 & HV_16384_uint16_b
            benchmark.keep(res._storage)

        @parameter
        fn bench_and_512_uint32() raises:
            var res = HV_512_uint32 & HV_512_uint32_b
            benchmark.keep(res._storage)

        @parameter
        fn bench_and_1024_uint32() raises:
            var res = HV_1024_uint32 & HV_1024_uint32_b
            benchmark.keep(res._storage)

        @parameter
        fn bench_and_16384_uint32() raises:
            var res = HV_16384_uint32 & HV_16384_uint32_b
            benchmark.keep(res._storage)

        @parameter
        fn bench_and_512_uint64() raises:
            var res = HV_512_uint64 & HV_512_uint64_b
            benchmark.keep(res._storage)

        @parameter
        fn bench_and_1024_uint64() raises:
            var res = HV_1024_uint64 & HV_1024_uint64_b
            benchmark.keep(res._storage)

        @parameter
        fn bench_and_16384_uint64() raises:
            var res = HV_16384_uint64 & HV_16384_uint64_b
            benchmark.keep(res._storage)

        print("--- Benchmarking __and__ ---")
        print("Dimension | DType | Mean Time (" + String(unit) + ")")
        print("----------|-------|-------------")

        # --- Benchmarking __and__ ---
        # Dimension | DType | Mean Time (ns)
        # ----------|-------|-------------
        # 8 | uint8 | 28.052603303611125
        # 512 | uint8 | 266.41710194940623
        # 1024 | uint8 | 503.1236090226195
        # 16384 | uint8 | 7427.634168222663
        # 512 | uint16 | 159.1262558435059
        # 1024 | uint16 | 283.3562839823779
        # 16384 | uint16 | 3941.0091280366037
        # 512 | uint32 | 276.70637559119524
        # 1024 | uint32 | 549.6418509704013
        # 16384 | uint32 | 8093.232318564369
        # 512 | uint64 | 151.4870837676613
        # 1024 | uint64 | 280.4044447558984
        # 16384 | uint64 | 4147.6478484502

        # --- Benchmarking __and__ ---
        # Run the __and__ benchmark
        var and_time_8 = benchmark.run[bench_and_8]().mean(unit)
        print(HV_8_uint8.D, "|", "uint8", "|", and_time_8)
        var and_time_512 = benchmark.run[bench_and_512]().mean(unit)
        print(HV_512_uint8.D, "|", "uint8", "|", and_time_512)
        var and_time_1024 = benchmark.run[bench_and_1024]().mean(unit)
        print(HV_1024_uint8.D, "|", "uint8", "|", and_time_1024)
        var and_time_16384 = benchmark.run[bench_and_16384]().mean(unit)
        print(HV_16384_uint8.D, "|", "uint8", "|", and_time_16384)
        var and_time_512_uint16 = benchmark.run[bench_and_512_uint16]().mean(
            unit
        )
        print(HV_512_uint16.D, "|", "uint16", "|", and_time_512_uint16)
        var and_time_1024_uint16 = benchmark.run[bench_and_1024_uint16]().mean(
            unit
        )
        print(HV_1024_uint16.D, "|", "uint16", "|", and_time_1024_uint16)
        var and_time_16384_uint16 = benchmark.run[
            bench_and_16384_uint16
        ]().mean(unit)
        print(HV_16384_uint16.D, "|", "uint16", "|", and_time_16384_uint16)
        var and_time_512_uint32 = benchmark.run[bench_and_512_uint32]().mean(
            unit
        )
        print(HV_512_uint32.D, "|", "uint32", "|", and_time_512_uint32)
        var and_time_1024_uint32 = benchmark.run[bench_and_1024_uint32]().mean(
            unit
        )
        print(HV_1024_uint32.D, "|", "uint32", "|", and_time_1024_uint32)
        var and_time_16384_uint32 = benchmark.run[
            bench_and_16384_uint32
        ]().mean(unit)
        print(HV_16384_uint32.D, "|", "uint32", "|", and_time_16384_uint32)
        var and_time_512_uint64 = benchmark.run[bench_and_512_uint64]().mean(
            unit
        )
        print(HV_512_uint64.D, "|", "uint64", "|", and_time_512_uint64)
        var and_time_1024_uint64 = benchmark.run[bench_and_1024_uint64]().mean(
            unit
        )
        print(HV_1024_uint64.D, "|", "uint64", "|", and_time_1024_uint64)
        var and_time_16384_uint64 = benchmark.run[
            bench_and_16384_uint64
        ]().mean(unit)
        print(HV_16384_uint64.D, "|", "uint64", "|", and_time_16384_uint64)

    fn benchmark_or() raises:
        # __or__
        @parameter
        fn bench_or_8() raises:
            var res = HV_8_uint8 | HV_8_uint8_b
            benchmark.keep(res._storage)

        @parameter
        fn bench_or_512() raises:
            var res = HV_512_uint8 | HV_512_uint8_b
            benchmark.keep(res._storage)

        @parameter
        fn bench_or_1024() raises:
            var res = HV_1024_uint8 | HV_1024_uint8_b
            benchmark.keep(res._storage)

        @parameter
        fn bench_or_16384() raises:
            var res = HV_16384_uint8 | HV_16384_uint8_b
            benchmark.keep(res._storage)

        @parameter
        fn bench_or_512_uint16() raises:
            var res = HV_512_uint16 | HV_512_uint16_b
            benchmark.keep(res._storage)

        @parameter
        fn bench_or_1024_uint16() raises:
            var res = HV_1024_uint16 | HV_1024_uint16_b
            benchmark.keep(res._storage)

        @parameter
        fn bench_or_16384_uint16() raises:
            var res = HV_16384_uint16 | HV_16384_uint16_b
            benchmark.keep(res._storage)

        @parameter
        fn bench_or_512_uint32() raises:
            var res = HV_512_uint32 | HV_512_uint32_b
            benchmark.keep(res._storage)

        @parameter
        fn bench_or_1024_uint32() raises:
            var res = HV_1024_uint32 | HV_1024_uint32_b
            benchmark.keep(res._storage)

        @parameter
        fn bench_or_16384_uint32() raises:
            var res = HV_16384_uint32 | HV_16384_uint32_b
            benchmark.keep(res._storage)

        @parameter
        fn bench_or_512_uint64() raises:
            var res = HV_512_uint64 | HV_512_uint64_b
            benchmark.keep(res._storage)

        @parameter
        fn bench_or_1024_uint64() raises:
            var res = HV_1024_uint64 | HV_1024_uint64_b
            benchmark.keep(res._storage)

        @parameter
        fn bench_or_16384_uint64() raises:
            var res = HV_16384_uint64 | HV_16384_uint64_b
            benchmark.keep(res._storage)

        print("--- Benchmarking __or__ ---")
        print("Dimension | DType | Mean Time (" + String(unit) + ")")
        print("----------|-------|-------------")

        # --- Benchmarking __or__ ---
        # Dimension | DType | Mean Time (ns)
        # ----------|-------|-------------
        # 8 | uint8 | 27.507917652827377
        # 512 | uint8 | 266.6727668955697
        # 1024 | uint8 | 505.0964140828212
        # 16384 | uint8 | 7376.405112868935
        # 512 | uint16 | 159.21062908719608
        # 1024 | uint16 | 280.68981829952327
        # 16384 | uint16 | 3931.679391924519
        # 512 | uint32 | 277.4507830327966
        # 1024 | uint32 | 522.9219358574023
        # 16384 | uint32 | 8071.639081782336
        # 512 | uint64 | 150.25221278656258
        # 1024 | uint64 | 281.6731860572332
        # 16384 | uint64 | 4148.061928371421

        # --- Benchmarking __or__ vectorized---
        # Dimension | DType | Mean Time (ns)
        # ----------|-------|-------------
        # 8 | uint8 | 27.09710374284146
        # 512 | uint8 | 250.81110282223014
        # 1024 | uint8 | 478.9922687377105
        # 16384 | uint8 | 7292.06395512573
        # 512 | uint16 | 141.25351577769928
        # 1024 | uint16 | 264.84758523301366
        # 16384 | uint16 | 3732.947133743113
        # 512 | uint32 | 269.8660797737837
        # 1024 | uint32 | 517.418981113664
        # 16384 | uint32 | 7966.982386670779
        # 512 | uint64 | 146.78633183999887
        # 1024 | uint64 | 274.34874862839774
        # 16384 | uint64 | 4122.367012597985

        # Run the __or__ benchmark
        var or_time_8 = benchmark.run[bench_or_8]().mean(unit)
        print(HV_8_uint8.D, "|", "uint8", "|", or_time_8)
        var or_time_512 = benchmark.run[bench_or_512]().mean(unit)
        print(HV_512_uint8.D, "|", "uint8", "|", or_time_512)
        var or_time_1024 = benchmark.run[bench_or_1024]().mean(unit)
        print(HV_1024_uint8.D, "|", "uint8", "|", or_time_1024)
        var or_time_16384 = benchmark.run[bench_or_16384]().mean(unit)
        print(HV_16384_uint8.D, "|", "uint8", "|", or_time_16384)
        var or_time_512_uint16 = benchmark.run[bench_or_512_uint16]().mean(unit)
        print(HV_512_uint16.D, "|", "uint16", "|", or_time_512_uint16)
        var or_time_1024_uint16 = benchmark.run[bench_or_1024_uint16]().mean(
            unit
        )
        print(HV_1024_uint16.D, "|", "uint16", "|", or_time_1024_uint16)
        var or_time_16384_uint16 = benchmark.run[bench_or_16384_uint16]().mean(
            unit
        )
        print(HV_16384_uint16.D, "|", "uint16", "|", or_time_16384_uint16)
        var or_time_512_uint32 = benchmark.run[bench_or_512_uint32]().mean(unit)
        print(HV_512_uint32.D, "|", "uint32", "|", or_time_512_uint32)
        var or_time_1024_uint32 = benchmark.run[bench_or_1024_uint32]().mean(
            unit
        )
        print(HV_1024_uint32.D, "|", "uint32", "|", or_time_1024_uint32)
        var or_time_16384_uint32 = benchmark.run[bench_or_16384_uint32]().mean(
            unit
        )
        print(HV_16384_uint32.D, "|", "uint32", "|", or_time_16384_uint32)
        var or_time_512_uint64 = benchmark.run[bench_or_512_uint64]().mean(unit)
        print(HV_512_uint64.D, "|", "uint64", "|", or_time_512_uint64)
        var or_time_1024_uint64 = benchmark.run[bench_or_1024_uint64]().mean(
            unit
        )
        print(HV_1024_uint64.D, "|", "uint64", "|", or_time_1024_uint64)
        var or_time_16384_uint64 = benchmark.run[bench_or_16384_uint64]().mean(
            unit
        )
        print(HV_16384_uint64.D, "|", "uint64", "|", or_time_16384_uint64)

    fn benchmark_invert() raises:
        # __invert__
        @parameter
        fn bench_invert_8() raises:
            var res = ~HV_8_uint8
            benchmark.keep(res._storage)

        @parameter
        fn bench_invert_512() raises:
            var res = ~HV_512_uint8
            benchmark.keep(res._storage)

        @parameter
        fn bench_invert_1024() raises:
            var res = ~HV_1024_uint8
            benchmark.keep(res._storage)

        @parameter
        fn bench_invert_16384() raises:
            var res = ~HV_16384_uint8
            benchmark.keep(res._storage)

        @parameter
        fn bench_invert_512_uint16() raises:
            var res = ~HV_512_uint16
            benchmark.keep(res._storage)

        @parameter
        fn bench_invert_1024_uint16() raises:
            var res = ~HV_1024_uint16
            benchmark.keep(res._storage)

        @parameter
        fn bench_invert_16384_uint16() raises:
            var res = ~HV_16384_uint16
            benchmark.keep(res._storage)

        @parameter
        fn bench_invert_512_uint32() raises:
            var res = ~HV_512_uint32
            benchmark.keep(res._storage)

        @parameter
        fn bench_invert_1024_uint32() raises:
            var res = ~HV_1024_uint32
            benchmark.keep(res._storage)

        @parameter
        fn bench_invert_16384_uint32() raises:
            var res = ~HV_16384_uint32
            benchmark.keep(res._storage)

        @parameter
        fn bench_invert_512_uint64() raises:
            var res = ~HV_512_uint64
            benchmark.keep(res._storage)

        @parameter
        fn bench_invert_1024_uint64() raises:
            var res = ~HV_1024_uint64
            benchmark.keep(res._storage)

        @parameter
        fn bench_invert_16384_uint64() raises:
            var res = ~HV_16384_uint64
            benchmark.keep(res._storage)

        print("--- Benchmarking __invert__ ---")
        print("Dimension | DType | Mean Time (" + String(unit) + ")")
        print("----------|-------|-------------")

        # --- Benchmarking __invert__ ---
        # Dimension | DType | Mean Time (ns)
        # ----------|-------|-------------
        # 8 | uint8 | 27.516008634101137
        # 512 | uint8 | 266.8264156730216
        # 1024 | uint8 | 505.045690811942
        # 16384 | uint8 | 7395.532334387384
        # 512 | uint16 | 150.16918351438983
        # 1024 | uint16 | 280.54539867641813
        # 16384 | uint16 | 4105.087933763585
        # 512 | uint32 | 277.74922722467767
        # 1024 | uint32 | 529.8711656749571
        # 16384 | uint32 | 8133.5170457430495
        # 512 | uint64 | 148.72311057590844
        # 1024 | uint64 | 278.35036965019646
        # 16384 | uint64 | 4157.102247303858

        # Run the __invert__ benchmark
        var invert_time_8 = benchmark.run[bench_invert_8]().mean(unit)
        print(HV_8_uint8.D, "|", "uint8", "|", invert_time_8)
        var invert_time_512 = benchmark.run[bench_invert_512]().mean(unit)
        print(HV_512_uint8.D, "|", "uint8", "|", invert_time_512)
        var invert_time_1024 = benchmark.run[bench_invert_1024]().mean(unit)
        print(HV_1024_uint8.D, "|", "uint8", "|", invert_time_1024)
        var invert_time_16384 = benchmark.run[bench_invert_16384]().mean(unit)
        print(HV_16384_uint8.D, "|", "uint8", "|", invert_time_16384)
        var invert_time_512_uint16 = benchmark.run[
            bench_invert_512_uint16
        ]().mean(unit)
        print(HV_512_uint16.D, "|", "uint16", "|", invert_time_512_uint16)
        var invert_time_1024_uint16 = benchmark.run[
            bench_invert_1024_uint16
        ]().mean(unit)
        print(HV_1024_uint16.D, "|", "uint16", "|", invert_time_1024_uint16)
        var invert_time_16384_uint16 = benchmark.run[
            bench_invert_16384_uint16
        ]().mean(unit)
        print(HV_16384_uint16.D, "|", "uint16", "|", invert_time_16384_uint16)
        var invert_time_512_uint32 = benchmark.run[
            bench_invert_512_uint32
        ]().mean(unit)
        print(HV_512_uint32.D, "|", "uint32", "|", invert_time_512_uint32)
        var invert_time_1024_uint32 = benchmark.run[
            bench_invert_1024_uint32
        ]().mean(unit)
        print(HV_1024_uint32.D, "|", "uint32", "|", invert_time_1024_uint32)
        var invert_time_16384_uint32 = benchmark.run[
            bench_invert_16384_uint32
        ]().mean(unit)
        print(HV_16384_uint32.D, "|", "uint32", "|", invert_time_16384_uint32)
        var invert_time_512_uint64 = benchmark.run[
            bench_invert_512_uint64
        ]().mean(unit)
        print(HV_512_uint64.D, "|", "uint64", "|", invert_time_512_uint64)
        var invert_time_1024_uint64 = benchmark.run[
            bench_invert_1024_uint64
        ]().mean(unit)
        print(HV_1024_uint64.D, "|", "uint64", "|", invert_time_1024_uint64)
        var invert_time_16384_uint64 = benchmark.run[
            bench_invert_16384_uint64
        ]().mean(unit)
        print(HV_16384_uint64.D, "|", "uint64", "|", invert_time_16384_uint64)

    fn benchmark_lshift() raises:
        # __lshift__ (using shift by 1)
        @parameter
        fn bench_lshift_8() raises:
            var res = HV_8_uint8 << 1
            benchmark.keep(res._storage)

        @parameter
        fn bench_lshift_512() raises:
            var res = HV_512_uint8 << 1
            benchmark.keep(res._storage)

        @parameter
        fn bench_lshift_1024() raises:
            var res = HV_1024_uint8 << 1
            benchmark.keep(res._storage)

        @parameter
        fn bench_lshift_16384() raises:
            var res = HV_16384_uint8 << 1
            benchmark.keep(res._storage)

        @parameter
        fn bench_lshift_512_uint16() raises:
            var res = HV_512_uint16 << 1
            benchmark.keep(res._storage)

        @parameter
        fn bench_lshift_1024_uint16() raises:
            var res = HV_1024_uint16 << 1
            benchmark.keep(res._storage)

        @parameter
        fn bench_lshift_16384_uint16() raises:
            var res = HV_16384_uint16 << 1
            benchmark.keep(res._storage)

        @parameter
        fn bench_lshift_512_uint32() raises:
            var res = HV_512_uint32 << 1
            benchmark.keep(res._storage)

        @parameter
        fn bench_lshift_1024_uint32() raises:
            var res = HV_1024_uint32 << 1
            benchmark.keep(res._storage)

        @parameter
        fn bench_lshift_16384_uint32() raises:
            var res = HV_16384_uint32 << 1
            benchmark.keep(res._storage)

        @parameter
        fn bench_lshift_512_uint64() raises:
            var res = HV_512_uint64 << 1
            benchmark.keep(res._storage)

        @parameter
        fn bench_lshift_1024_uint64() raises:
            var res = HV_1024_uint64 << 1
            benchmark.keep(res._storage)

        @parameter
        fn bench_lshift_16384_uint64() raises:
            var res = HV_16384_uint64 << 1
            benchmark.keep(res._storage)

        print("--- Benchmarking __lshift__ ---")
        print("Dimension | DType | Mean Time (" + String(unit) + ")")
        print("----------|-------|-------------")

        # --- Benchmarking __lshift__ naive ---
        # Dimension | DType | Mean Time (ns)
        # ----------|-------|-------------
        # 8 | uint8 | 38.4175914589825
        # 512 | uint8 | 1613.441421448173
        # 1024 | uint8 | 2586.6626017573676
        # 16384 | uint8 | 104185.04709548957
        # 512 | uint16 | 1129.6063916872572
        # 1024 | uint16 | 2282.802808
        # 16384 | uint16 | 101408.41577045874
        # 512 | uint32 | 1522.5102774324162
        # 1024 | uint32 | 3017.328690009416
        # 16384 | uint32 | 111362.3314970836
        # 512 | uint64 | 1378.6402806023011
        # 1024 | uint64 | 2763.708875675576
        # 16384 | uint64 | 106650.22085454948

        # --- Benchmarking __lshift__ element-wise ---
        # Dimension | DType | Mean Time (ns)
        # ----------|-------|-------------
        # 8 | uint8 | 31.724295546705886
        # 512 | uint8 | 440.3081632707844
        # 1024 | uint8 | 780.7696962559587
        # 16384 | uint8 | 11814.338130468383
        # 512 | uint16 | 231.1880561
        # 1024 | uint16 | 426.28916257845907
        # 16384 | uint16 | 6134.961315102402
        # 512 | uint32 | 317.9731707818071
        # 1024 | uint32 | 608.3030899161628
        # 16384 | uint32 | 9208.698351323774
        # 512 | uint64 | 165.39674302158522
        # 1024 | uint64 | 323.0028344304229
        # 16384 | uint64 | 4920.584097274031

        # Run the __lshift__ benchmark
        var lshift_time_8 = benchmark.run[bench_lshift_8]().mean(unit)
        print(HV_8_uint8.D, "|", "uint8", "|", lshift_time_8)
        var lshift_time_512 = benchmark.run[bench_lshift_512]().mean(unit)
        print(HV_512_uint8.D, "|", "uint8", "|", lshift_time_512)
        var lshift_time_1024 = benchmark.run[bench_lshift_1024]().mean(unit)
        print(HV_1024_uint8.D, "|", "uint8", "|", lshift_time_1024)
        var lshift_time_16384 = benchmark.run[bench_lshift_16384]().mean(unit)
        print(HV_16384_uint8.D, "|", "uint8", "|", lshift_time_16384)
        var lshift_time_512_uint16 = benchmark.run[
            bench_lshift_512_uint16
        ]().mean(unit)
        print(HV_512_uint16.D, "|", "uint16", "|", lshift_time_512_uint16)
        var lshift_time_1024_uint16 = benchmark.run[
            bench_lshift_1024_uint16
        ]().mean(unit)
        print(HV_1024_uint16.D, "|", "uint16", "|", lshift_time_1024_uint16)
        var lshift_time_16384_uint16 = benchmark.run[
            bench_lshift_16384_uint16
        ]().mean(unit)
        print(HV_16384_uint16.D, "|", "uint16", "|", lshift_time_16384_uint16)
        var lshift_time_512_uint32 = benchmark.run[
            bench_lshift_512_uint32
        ]().mean(unit)
        print(HV_512_uint32.D, "|", "uint32", "|", lshift_time_512_uint32)
        var lshift_time_1024_uint32 = benchmark.run[
            bench_lshift_1024_uint32
        ]().mean(unit)
        print(HV_1024_uint32.D, "|", "uint32", "|", lshift_time_1024_uint32)
        var lshift_time_16384_uint32 = benchmark.run[
            bench_lshift_16384_uint32
        ]().mean(unit)
        print(HV_16384_uint32.D, "|", "uint32", "|", lshift_time_16384_uint32)
        var lshift_time_512_uint64 = benchmark.run[
            bench_lshift_512_uint64
        ]().mean(unit)
        print(HV_512_uint64.D, "|", "uint64", "|", lshift_time_512_uint64)
        var lshift_time_1024_uint64 = benchmark.run[
            bench_lshift_1024_uint64
        ]().mean(unit)
        print(HV_1024_uint64.D, "|", "uint64", "|", lshift_time_1024_uint64)
        var lshift_time_16384_uint64 = benchmark.run[
            bench_lshift_16384_uint64
        ]().mean(unit)
        print(HV_16384_uint64.D, "|", "uint64", "|", lshift_time_16384_uint64)

    fn benchmark_rshift() raises:
        # __rshift__ (using shift by 1)

        @parameter
        fn bench_rshift_8() raises:
            var res = HV_8_uint8 >> 1
            benchmark.keep(res._storage)

        @parameter
        fn bench_rshift_512() raises:
            var res = HV_512_uint8 >> 1
            benchmark.keep(res._storage)

        @parameter
        fn bench_rshift_1024() raises:
            var res = HV_1024_uint8 >> 1
            benchmark.keep(res._storage)

        @parameter
        fn bench_rshift_16384() raises:
            var res = HV_16384_uint8 >> 1
            benchmark.keep(res._storage)

        @parameter
        fn bench_rshift_512_uint16() raises:
            var res = HV_512_uint16 >> 1
            benchmark.keep(res._storage)

        @parameter
        fn bench_rshift_1024_uint16() raises:
            var res = HV_1024_uint16 >> 1
            benchmark.keep(res._storage)

        @parameter
        fn bench_rshift_16384_uint16() raises:
            var res = HV_16384_uint16 >> 1
            benchmark.keep(res._storage)

        @parameter
        fn bench_rshift_512_uint32() raises:
            var res = HV_512_uint32 >> 1
            benchmark.keep(res._storage)

        @parameter
        fn bench_rshift_1024_uint32() raises:
            var res = HV_1024_uint32 >> 1
            benchmark.keep(res._storage)

        @parameter
        fn bench_rshift_16384_uint32() raises:
            var res = HV_16384_uint32 >> 1
            benchmark.keep(res._storage)

        @parameter
        fn bench_rshift_512_uint64() raises:
            var res = HV_512_uint64 >> 1
            benchmark.keep(res._storage)

        @parameter
        fn bench_rshift_1024_uint64() raises:
            var res = HV_1024_uint64 >> 1
            benchmark.keep(res._storage)

        @parameter
        fn bench_rshift_16384_uint64() raises:
            var res = HV_16384_uint64 >> 1
            benchmark.keep(res._storage)

        print("--- Benchmarking __rshift__ ---")
        print("Dimension | DType | Mean Time (" + String(unit) + ")")
        print("----------|-------|-------------")

        #     --- Benchmarking __rshift__ ---
        # Dimension | DType | Mean Time (ns)
        # ----------|-------|-------------
        # 8 | uint8 | 33.54944878120883
        # 512 | uint8 | 402.5197084301159
        # 1024 | uint8 | 782.980269446363
        # 16384 | uint8 | 11812.21329001772
        # 512 | uint16 | 221.4302007
        # 1024 | uint16 | 416.3406704088345
        # 16384 | uint16 | 6221.906933310788
        # 512 | uint32 | 311.04083694420154
        # 1024 | uint32 | 592.7248423248437
        # 16384 | uint32 | 9183.844290299996
        # 512 | uint64 | 174.5931485812969
        # 1024 | uint64 | 314.63576257190556
        # 16384 | uint64 | 4929.956900751977

        # Run the __rshift__ benchmark
        var rshift_time_8 = benchmark.run[bench_rshift_8]().mean(unit)
        print(HV_8_uint8.D, "|", "uint8", "|", rshift_time_8)
        var rshift_time_512 = benchmark.run[bench_rshift_512]().mean(unit)
        print(HV_512_uint8.D, "|", "uint8", "|", rshift_time_512)
        var rshift_time_1024 = benchmark.run[bench_rshift_1024]().mean(unit)
        print(HV_1024_uint8.D, "|", "uint8", "|", rshift_time_1024)
        var rshift_time_16384 = benchmark.run[bench_rshift_16384]().mean(unit)
        print(HV_16384_uint8.D, "|", "uint8", "|", rshift_time_16384)
        var rshift_time_512_uint16 = benchmark.run[
            bench_rshift_512_uint16
        ]().mean(unit)
        print(HV_512_uint16.D, "|", "uint16", "|", rshift_time_512_uint16)
        var rshift_time_1024_uint16 = benchmark.run[
            bench_rshift_1024_uint16
        ]().mean(unit)
        print(HV_1024_uint16.D, "|", "uint16", "|", rshift_time_1024_uint16)
        var rshift_time_16384_uint16 = benchmark.run[
            bench_rshift_16384_uint16
        ]().mean(unit)
        print(HV_16384_uint16.D, "|", "uint16", "|", rshift_time_16384_uint16)
        var rshift_time_512_uint32 = benchmark.run[
            bench_rshift_512_uint32
        ]().mean(unit)
        print(HV_512_uint32.D, "|", "uint32", "|", rshift_time_512_uint32)
        var rshift_time_1024_uint32 = benchmark.run[
            bench_rshift_1024_uint32
        ]().mean(unit)
        print(HV_1024_uint32.D, "|", "uint32", "|", rshift_time_1024_uint32)
        var rshift_time_16384_uint32 = benchmark.run[
            bench_rshift_16384_uint32
        ]().mean(unit)
        print(HV_16384_uint32.D, "|", "uint32", "|", rshift_time_16384_uint32)
        var rshift_time_512_uint64 = benchmark.run[
            bench_rshift_512_uint64
        ]().mean(unit)
        print(HV_512_uint64.D, "|", "uint64", "|", rshift_time_512_uint64)
        var rshift_time_1024_uint64 = benchmark.run[
            bench_rshift_1024_uint64
        ]().mean(unit)
        print(HV_1024_uint64.D, "|", "uint64", "|", rshift_time_1024_uint64)
        var rshift_time_16384_uint64 = benchmark.run[
            bench_rshift_16384_uint64
        ]().mean(unit)
        print(HV_16384_uint64.D, "|", "uint64", "|", rshift_time_16384_uint64)

    fn benchmark_bundle_majority() raises:
        # bundle_majority (using 3 vectors: a, b, c)

        var list_8_uint8 = List[HV[2**3, DType.uint8]]()
        list_8_uint8.append(HV_8_uint8)
        list_8_uint8.append(HV_8_uint8_b)

        var list_512_uint8 = List[HV[2**9, DType.uint8]]()
        list_512_uint8.append(HV_512_uint8)
        list_512_uint8.append(HV_512_uint8_b)

        var list_1024_uint8 = List[HV[2**10, DType.uint8]]()
        list_1024_uint8.append(HV_1024_uint8)
        list_1024_uint8.append(HV_1024_uint8_b)

        var list_16384_uint8 = List[HV[2**14, DType.uint8]]()
        list_16384_uint8.append(HV_16384_uint8)
        list_16384_uint8.append(HV_16384_uint8_b)

        var list_512_uint16 = List[HV[2**9, DType.uint16]]()
        list_512_uint16.append(HV_512_uint16)
        list_512_uint16.append(HV_512_uint16_b)

        var list_1024_uint16 = List[HV[2**10, DType.uint16]]()
        list_1024_uint16.append(HV_1024_uint16)
        list_1024_uint16.append(HV_1024_uint16_b)

        var list_16384_uint16 = List[HV[2**14, DType.uint16]]()
        list_16384_uint16.append(HV_16384_uint16)
        list_16384_uint16.append(HV_16384_uint16_b)

        var list_512_uint32 = List[HV[2**9, DType.uint32]]()
        list_512_uint32.append(HV_512_uint32)
        list_512_uint32.append(HV_512_uint32_b)

        var list_1024_uint32 = List[HV[2**10, DType.uint32]]()
        list_1024_uint32.append(HV_1024_uint32)
        list_1024_uint32.append(HV_1024_uint32_b)

        var list_16384_uint32 = List[HV[2**14, DType.uint32]]()
        list_16384_uint32.append(HV_16384_uint32)
        list_16384_uint32.append(HV_16384_uint32_b)

        var list_512_uint64 = List[HV[2**9, DType.uint64]]()
        list_512_uint64.append(HV_512_uint64)
        list_512_uint64.append(HV_512_uint64_b)

        var list_1024_uint64 = List[HV[2**10, DType.uint64]]()
        list_1024_uint64.append(HV_1024_uint64)
        list_1024_uint64.append(HV_1024_uint64_b)

        var list_16384_uint64 = List[HV[2**14, DType.uint64]]()
        list_16384_uint64.append(HV_16384_uint64)
        list_16384_uint64.append(HV_16384_uint64_b)

        @parameter
        fn bench_bundle_majority_8() raises:
            var res = HV.bundle_majority[2**3, DType.uint8](list_8_uint8)
            benchmark.keep(res._storage)

        @parameter
        fn bench_bundle_majority_512() raises:
            var res = HV.bundle_majority[2**9, DType.uint8](list_512_uint8)
            benchmark.keep(res._storage)

        @parameter
        fn bench_bundle_majority_1024() raises:
            var res = HV.bundle_majority[2**10, DType.uint8](list_1024_uint8)
            benchmark.keep(res._storage)

        @parameter
        fn bench_bundle_majority_16384() raises:
            var res = HV.bundle_majority[2**14, DType.uint8](list_16384_uint8)
            benchmark.keep(res._storage)

        @parameter
        fn bench_bundle_majority_512_uint16() raises:
            var res = HV.bundle_majority[2**9, DType.uint16](list_512_uint16)
            benchmark.keep(res._storage)

        @parameter
        fn bench_bundle_majority_1024_uint16() raises:
            var res = HV.bundle_majority[2**10, DType.uint16](
                list_1024_uint16
            )
            benchmark.keep(res._storage)

        @parameter
        fn bench_bundle_majority_16384_uint16() raises:
            var res = HV.bundle_majority[2**14, DType.uint16](
                list_16384_uint16
            )
            benchmark.keep(res._storage)

        @parameter
        fn bench_bundle_majority_512_uint32() raises:
            var res = HV.bundle_majority[2**9, DType.uint32](list_512_uint32)
            benchmark.keep(res._storage)

        @parameter
        fn bench_bundle_majority_1024_uint32() raises:
            var res = HV.bundle_majority[2**10, DType.uint32](
                list_1024_uint32
            )
            benchmark.keep(res._storage)

        @parameter
        fn bench_bundle_majority_16384_uint32() raises:
            var res = HV.bundle_majority[2**14, DType.uint32](
                list_16384_uint32
            )
            benchmark.keep(res._storage)

        @parameter
        fn bench_bundle_majority_512_uint64() raises:
            var res = HV.bundle_majority[2**9, DType.uint64](list_512_uint64)
            benchmark.keep(res._storage)

        @parameter
        fn bench_bundle_majority_1024_uint64() raises:
            var res = HV.bundle_majority[2**10, DType.uint64](
                list_1024_uint64
            )
            benchmark.keep(res._storage)

        @parameter
        fn bench_bundle_majority_16384_uint64() raises:
            var res = HV.bundle_majority[2**14, DType.uint64](
                list_16384_uint64
            )
            benchmark.keep(res._storage)

        print("--- Benchmarking bundle_majority ---")
        print("Dimension | DType | Mean Time (" + String(unit) + ")")
        print("----------|-------|-------------")

        # --- Benchmarking bundle_majority naive---
        # Dimension | DType | Mean Time (ns)
        # ----------|-------|-------------
        # 8 | uint8 | 118.3300035277922
        # 512 | uint8 | 2425.3802755041734
        # 1024 | uint8 | 5201.497677310952
        # 16384 | uint8 | 113165.231607758
        # 512 | uint16 | 2261.140353
        # 1024 | uint16 | 4789.191031586926
        # 16384 | uint16 | 110912.35533792211
        # 512 | uint32 | 2420.245488320572
        # 1024 | uint32 | 5065.75919982164
        # 16384 | uint32 | 124870.26639718974
        # 512 | uint64 | 2223.658479
        # 1024 | uint64 | 4455.596368331104
        # 16384 | uint64 | 113490.94153263954

        # --- Benchmarking bundle_majority optimized ---
        # Dimension | DType | Mean Time (ns)
        # ----------|-------|-------------
        # 8 | uint8 | 98.66347714181164
        # 512 | uint8 | 1255.7844551089281
        # 1024 | uint8 | 2241.122221
        # 16384 | uint8 | 33561.28601007275
        # 512 | uint16 | 1176.9171751295012
        # 1024 | uint16 | 2269.768118
        # 16384 | uint16 | 33260.86152420214
        # 512 | uint32 | 1158.2176089784166
        # 1024 | uint32 | 2232.567849
        # 16384 | uint32 | 34014.2553037711
        # 512 | uint64 | 991.5494265146629
        # 1024 | uint64 | 1906.402456
        # 16384 | uint64 | 28353.15744394301

        # --- Benchmarking bundle_majority parallel ---
        # Dimension | DType | Mean Time (ns)
        # ----------|-------|-------------
        # 8 | uint8 | 2474.959777683534
        # 512 | uint8 | 2878.7183460369315
        # 1024 | uint8 | 3288.2766268933774
        # 16384 | uint8 | 15451.977714501927
        # 512 | uint16 | 2740.176413781123
        # 1024 | uint16 | 3040.665973325106
        # 16384 | uint16 | 11558.729777931478
        # 512 | uint32 | 2833.9180682835145
        # 1024 | uint32 | 3294.0991356769023
        # 16384 | uint32 | 15663.990991638359
        # 512 | uint64 | 2773.604512862062
        # 1024 | uint64 | 3071.7500003156197
        # 16384 | uint64 | 11584.663176021146

        # Run the bundle_majority benchmark
        var bundle_majority_time_8 = benchmark.run[
            bench_bundle_majority_8
        ]().mean(unit)
        print(HV_8_uint8.D, "|", "uint8", "|", bundle_majority_time_8)
        var bundle_majority_time_512 = benchmark.run[
            bench_bundle_majority_512
        ]().mean(unit)
        print(HV_512_uint8.D, "|", "uint8", "|", bundle_majority_time_512)
        var bundle_majority_time_1024 = benchmark.run[
            bench_bundle_majority_1024
        ]().mean(unit)
        print(HV_1024_uint8.D, "|", "uint8", "|", bundle_majority_time_1024)
        var bundle_majority_time_16384 = benchmark.run[
            bench_bundle_majority_16384
        ]().mean(unit)
        print(HV_16384_uint8.D, "|", "uint8", "|", bundle_majority_time_16384)
        var bundle_majority_time_512_uint16 = benchmark.run[
            bench_bundle_majority_512_uint16
        ]().mean(unit)
        print(
            HV_512_uint16.D, "|", "uint16", "|", bundle_majority_time_512_uint16
        )
        var bundle_majority_time_1024_uint16 = benchmark.run[
            bench_bundle_majority_1024_uint16
        ]().mean(unit)
        print(
            HV_1024_uint16.D,
            "|",
            "uint16",
            "|",
            bundle_majority_time_1024_uint16,
        )
        var bundle_majority_time_16384_uint16 = benchmark.run[
            bench_bundle_majority_16384_uint16
        ]().mean(unit)
        print(
            HV_16384_uint16.D,
            "|",
            "uint16",
            "|",
            bundle_majority_time_16384_uint16,
        )
        var bundle_majority_time_512_uint32 = benchmark.run[
            bench_bundle_majority_512_uint32
        ]().mean(unit)
        print(
            HV_512_uint32.D, "|", "uint32", "|", bundle_majority_time_512_uint32
        )
        var bundle_majority_time_1024_uint32 = benchmark.run[
            bench_bundle_majority_1024_uint32
        ]().mean(unit)
        print(
            HV_1024_uint32.D,
            "|",
            "uint32",
            "|",
            bundle_majority_time_1024_uint32,
        )
        var bundle_majority_time_16384_uint32 = benchmark.run[
            bench_bundle_majority_16384_uint32
        ]().mean(unit)
        print(
            HV_16384_uint32.D,
            "|",
            "uint32",
            "|",
            bundle_majority_time_16384_uint32,
        )
        var bundle_majority_time_512_uint64 = benchmark.run[
            bench_bundle_majority_512_uint64
        ]().mean(unit)
        print(
            HV_512_uint64.D, "|", "uint64", "|", bundle_majority_time_512_uint64
        )
        var bundle_majority_time_1024_uint64 = benchmark.run[
            bench_bundle_majority_1024_uint64
        ]().mean(unit)
        print(
            HV_1024_uint64.D,
            "|",
            "uint64",
            "|",
            bundle_majority_time_1024_uint64,
        )
        var bundle_majority_time_16384_uint64 = benchmark.run[
            bench_bundle_majority_16384_uint64
        ]().mean(unit)
        print(
            HV_16384_uint64.D,
            "|",
            "uint64",
            "|",
            bundle_majority_time_16384_uint64,
        )

    fn benchmark_bundle_majority_10() raises:
        # bundle_majority (using 10 vectors: a, b, c, d, e, f, g, h, i, j)

        var list_10_8_uint8 = List[HV[2**3, DType.uint8]]()
        list_10_8_uint8.append(HV_8_uint8)
        list_10_8_uint8.append(HV_8_uint8_b)
        list_10_8_uint8.append(HV_8_uint8_c)
        list_10_8_uint8.append(HV_8_uint8_d)
        list_10_8_uint8.append(HV_8_uint8_e)
        list_10_8_uint8.append(HV_8_uint8_f)
        list_10_8_uint8.append(HV_8_uint8_g)
        list_10_8_uint8.append(HV_8_uint8_h)
        list_10_8_uint8.append(HV_8_uint8_i)
        list_10_8_uint8.append(HV_8_uint8_j)

        var list_10_512_uint8 = List[HV[2**9, DType.uint8]]()
        list_10_512_uint8.append(HV_512_uint8)
        list_10_512_uint8.append(HV_512_uint8_b)
        list_10_512_uint8.append(HV_512_uint8_c)
        list_10_512_uint8.append(HV_512_uint8_d)
        list_10_512_uint8.append(HV_512_uint8_e)
        list_10_512_uint8.append(HV_512_uint8_f)
        list_10_512_uint8.append(HV_512_uint8_g)
        list_10_512_uint8.append(HV_512_uint8_h)
        list_10_512_uint8.append(HV_512_uint8_i)
        list_10_512_uint8.append(HV_512_uint8_j)

        var list_10_1024_uint8 = List[HV[2**10, DType.uint8]]()
        list_10_1024_uint8.append(HV_1024_uint8)
        list_10_1024_uint8.append(HV_1024_uint8_b)
        list_10_1024_uint8.append(HV_1024_uint8_c)
        list_10_1024_uint8.append(HV_1024_uint8_d)
        list_10_1024_uint8.append(HV_1024_uint8_e)
        list_10_1024_uint8.append(HV_1024_uint8_f)
        list_10_1024_uint8.append(HV_1024_uint8_g)
        list_10_1024_uint8.append(HV_1024_uint8_h)
        list_10_1024_uint8.append(HV_1024_uint8_i)
        list_10_1024_uint8.append(HV_1024_uint8_j)

        var list_10_16384_uint8 = List[HV[2**14, DType.uint8]]()
        list_10_16384_uint8.append(HV_16384_uint8)
        list_10_16384_uint8.append(HV_16384_uint8_b)
        list_10_16384_uint8.append(HV_16384_uint8_c)
        list_10_16384_uint8.append(HV_16384_uint8_d)
        list_10_16384_uint8.append(HV_16384_uint8_e)
        list_10_16384_uint8.append(HV_16384_uint8_f)
        list_10_16384_uint8.append(HV_16384_uint8_g)
        list_10_16384_uint8.append(HV_16384_uint8_h)
        list_10_16384_uint8.append(HV_16384_uint8_i)
        list_10_16384_uint8.append(HV_16384_uint8_j)

        var list_10_512_uint16 = List[HV[2**9, DType.uint16]]()
        list_10_512_uint16.append(HV_512_uint16)
        list_10_512_uint16.append(HV_512_uint16_b)
        list_10_512_uint16.append(HV_512_uint16_c)
        list_10_512_uint16.append(HV_512_uint16_d)
        list_10_512_uint16.append(HV_512_uint16_e)
        list_10_512_uint16.append(HV_512_uint16_f)
        list_10_512_uint16.append(HV_512_uint16_g)
        list_10_512_uint16.append(HV_512_uint16_h)
        list_10_512_uint16.append(HV_512_uint16_i)
        list_10_512_uint16.append(HV_512_uint16_j)

        var list_10_1024_uint16 = List[HV[2**10, DType.uint16]]()
        list_10_1024_uint16.append(HV_1024_uint16)
        list_10_1024_uint16.append(HV_1024_uint16_b)
        list_10_1024_uint16.append(HV_1024_uint16_c)
        list_10_1024_uint16.append(HV_1024_uint16_d)
        list_10_1024_uint16.append(HV_1024_uint16_e)
        list_10_1024_uint16.append(HV_1024_uint16_f)
        list_10_1024_uint16.append(HV_1024_uint16_g)
        list_10_1024_uint16.append(HV_1024_uint16_h)
        list_10_1024_uint16.append(HV_1024_uint16_i)
        list_10_1024_uint16.append(HV_1024_uint16_j)

        var list_10_16384_uint16 = List[HV[2**14, DType.uint16]]()
        list_10_16384_uint16.append(HV_16384_uint16)
        list_10_16384_uint16.append(HV_16384_uint16_b)
        list_10_16384_uint16.append(HV_16384_uint16_c)
        list_10_16384_uint16.append(HV_16384_uint16_d)
        list_10_16384_uint16.append(HV_16384_uint16_e)
        list_10_16384_uint16.append(HV_16384_uint16_f)
        list_10_16384_uint16.append(HV_16384_uint16_g)
        list_10_16384_uint16.append(HV_16384_uint16_h)
        list_10_16384_uint16.append(HV_16384_uint16_i)
        list_10_16384_uint16.append(HV_16384_uint16_j)

        var list_10_512_uint32 = List[HV[2**9, DType.uint32]]()
        list_10_512_uint32.append(HV_512_uint32)
        list_10_512_uint32.append(HV_512_uint32_b)
        list_10_512_uint32.append(HV_512_uint32_c)
        list_10_512_uint32.append(HV_512_uint32_d)
        list_10_512_uint32.append(HV_512_uint32_e)
        list_10_512_uint32.append(HV_512_uint32_f)
        list_10_512_uint32.append(HV_512_uint32_g)
        list_10_512_uint32.append(HV_512_uint32_h)
        list_10_512_uint32.append(HV_512_uint32_i)
        list_10_512_uint32.append(HV_512_uint32_j)

        var list_10_1024_uint32 = List[HV[2**10, DType.uint32]]()
        list_10_1024_uint32.append(HV_1024_uint32)
        list_10_1024_uint32.append(HV_1024_uint32_b)
        list_10_1024_uint32.append(HV_1024_uint32_c)
        list_10_1024_uint32.append(HV_1024_uint32_d)
        list_10_1024_uint32.append(HV_1024_uint32_e)
        list_10_1024_uint32.append(HV_1024_uint32_f)
        list_10_1024_uint32.append(HV_1024_uint32_g)
        list_10_1024_uint32.append(HV_1024_uint32_h)
        list_10_1024_uint32.append(HV_1024_uint32_i)
        list_10_1024_uint32.append(HV_1024_uint32_j)

        var list_10_16384_uint32 = List[HV[2**14, DType.uint32]]()
        list_10_16384_uint32.append(HV_16384_uint32)
        list_10_16384_uint32.append(HV_16384_uint32_b)
        list_10_16384_uint32.append(HV_16384_uint32_c)
        list_10_16384_uint32.append(HV_16384_uint32_d)
        list_10_16384_uint32.append(HV_16384_uint32_e)
        list_10_16384_uint32.append(HV_16384_uint32_f)
        list_10_16384_uint32.append(HV_16384_uint32_g)
        list_10_16384_uint32.append(HV_16384_uint32_h)
        list_10_16384_uint32.append(HV_16384_uint32_i)
        list_10_16384_uint32.append(HV_16384_uint32_j)

        var list_10_512_uint64 = List[HV[2**9, DType.uint64]]()
        list_10_512_uint64.append(HV_512_uint64)
        list_10_512_uint64.append(HV_512_uint64_b)
        list_10_512_uint64.append(HV_512_uint64_c)
        list_10_512_uint64.append(HV_512_uint64_d)
        list_10_512_uint64.append(HV_512_uint64_e)
        list_10_512_uint64.append(HV_512_uint64_f)
        list_10_512_uint64.append(HV_512_uint64_g)
        list_10_512_uint64.append(HV_512_uint64_h)
        list_10_512_uint64.append(HV_512_uint64_i)
        list_10_512_uint64.append(HV_512_uint64_j)

        var list_10_1024_uint64 = List[HV[2**10, DType.uint64]]()
        list_10_1024_uint64.append(HV_1024_uint64)
        list_10_1024_uint64.append(HV_1024_uint64_b)
        list_10_1024_uint64.append(HV_1024_uint64_c)
        list_10_1024_uint64.append(HV_1024_uint64_d)
        list_10_1024_uint64.append(HV_1024_uint64_e)
        list_10_1024_uint64.append(HV_1024_uint64_f)
        list_10_1024_uint64.append(HV_1024_uint64_g)
        list_10_1024_uint64.append(HV_1024_uint64_h)
        list_10_1024_uint64.append(HV_1024_uint64_i)
        list_10_1024_uint64.append(HV_1024_uint64_j)

        var list_10_16384_uint64 = List[HV[2**14, DType.uint64]]()
        list_10_16384_uint64.append(HV_16384_uint64)
        list_10_16384_uint64.append(HV_16384_uint64_b)
        list_10_16384_uint64.append(HV_16384_uint64_c)
        list_10_16384_uint64.append(HV_16384_uint64_d)
        list_10_16384_uint64.append(HV_16384_uint64_e)
        list_10_16384_uint64.append(HV_16384_uint64_f)
        list_10_16384_uint64.append(HV_16384_uint64_g)
        list_10_16384_uint64.append(HV_16384_uint64_h)
        list_10_16384_uint64.append(HV_16384_uint64_i)
        list_10_16384_uint64.append(HV_16384_uint64_j)

        @parameter
        fn bench_bundle_majority_10_8() raises:
            var res = HV.bundle_majority[2**3, DType.uint8](list_10_8_uint8)
            benchmark.keep(res._storage)

        @parameter
        fn bench_bundle_majority_10_512() raises:
            var res = HV.bundle_majority[2**9, DType.uint8](list_10_512_uint8)
            benchmark.keep(res._storage)

        @parameter
        fn bench_bundle_majority_10_1024() raises:
            var res = HV.bundle_majority[2**10, DType.uint8](
                list_10_1024_uint8
            )
            benchmark.keep(res._storage)

        @parameter
        fn bench_bundle_majority_10_16384() raises:
            var res = HV.bundle_majority[2**14, DType.uint8](
                list_10_16384_uint8
            )
            benchmark.keep(res._storage)

        @parameter
        fn bench_bundle_majority_10_512_uint16() raises:
            var res = HV.bundle_majority[2**9, DType.uint16](
                list_10_512_uint16
            )
            benchmark.keep(res._storage)

        @parameter
        fn bench_bundle_majority_10_1024_uint16() raises:
            var res = HV.bundle_majority[2**10, DType.uint16](
                list_10_1024_uint16
            )
            benchmark.keep(res._storage)

        @parameter
        fn bench_bundle_majority_10_16384_uint16() raises:
            var res = HV.bundle_majority[2**14, DType.uint16](
                list_10_16384_uint16
            )
            benchmark.keep(res._storage)

        @parameter
        fn bench_bundle_majority_10_512_uint32() raises:
            var res = HV.bundle_majority[2**9, DType.uint32](
                list_10_512_uint32
            )
            benchmark.keep(res._storage)

        @parameter
        fn bench_bundle_majority_10_1024_uint32() raises:
            var res = HV.bundle_majority[2**10, DType.uint32](
                list_10_1024_uint32
            )
            benchmark.keep(res._storage)

        @parameter
        fn bench_bundle_majority_10_16384_uint32() raises:
            var res = HV.bundle_majority[2**14, DType.uint32](
                list_10_16384_uint32
            )
            benchmark.keep(res._storage)

        @parameter
        fn bench_bundle_majority_10_512_uint64() raises:
            var res = HV.bundle_majority[2**9, DType.uint64](
                list_10_512_uint64
            )
            benchmark.keep(res._storage)

        @parameter
        fn bench_bundle_majority_10_1024_uint64() raises:
            var res = HV.bundle_majority[2**10, DType.uint64](
                list_10_1024_uint64
            )
            benchmark.keep(res._storage)

        @parameter
        fn bench_bundle_majority_10_16384_uint64() raises:
            var res = HV.bundle_majority[2**14, DType.uint64](
                list_10_16384_uint64
            )
            benchmark.keep(res._storage)

        print("--- Benchmarking bundle_majority (10 vectors) ---")
        print("Dimension | DType | Mean Time (" + String(unit) + ")")
        print("----------|-------|-------------")

        # --- Benchmarking bundle_majority (10 vectors) ---
        # Dimension | DType | Mean Time (ns)
        # ----------|-------|-------------
        # 8 | uint8 | 2407.646713
        # 512 | uint8 | 3017.0305893089308
        # 1024 | uint8 | 3620.541425320801
        # 16384 | uint8 | 23959.1159258252
        # 512 | uint16 | 2886.369510558415
        # 1024 | uint16 | 3415.8838291927595
        # 16384 | uint16 | 21456.24353
        # 512 | uint32 | 3042.2436265261354
        # 1024 | uint32 | 3732.0632043108494
        # 16384 | uint32 | 23029.75721
        # 512 | uint64 | 3082.532537030636
        # 1024 | uint64 | 3503.802237333902
        # 16384 | uint64 | 18409.93035

        # Run the bundle_majority_10 benchmark
        var bundle_majority_10_time_8 = benchmark.run[
            bench_bundle_majority_10_8
        ]().mean(unit)
        print(HV_8_uint8.D, "|", "uint8", "|", bundle_majority_10_time_8)
        var bundle_majority_10_time_512 = benchmark.run[
            bench_bundle_majority_10_512
        ]().mean(unit)
        print(HV_512_uint8.D, "|", "uint8", "|", bundle_majority_10_time_512)
        var bundle_majority_10_time_1024 = benchmark.run[
            bench_bundle_majority_10_1024
        ]().mean(unit)
        print(HV_1024_uint8.D, "|", "uint8", "|", bundle_majority_10_time_1024)
        var bundle_majority_10_time_16384 = benchmark.run[
            bench_bundle_majority_10_16384
        ]().mean(unit)
        print(
            HV_16384_uint8.D, "|", "uint8", "|", bundle_majority_10_time_16384
        )
        var bundle_majority_10_time_512_uint16 = benchmark.run[
            bench_bundle_majority_10_512_uint16
        ]().mean(unit)
        print(
            HV_512_uint16.D,
            "|",
            "uint16",
            "|",
            bundle_majority_10_time_512_uint16,
        )
        var bundle_majority_10_time_1024_uint16 = benchmark.run[
            bench_bundle_majority_10_1024_uint16
        ]().mean(unit)
        print(
            HV_1024_uint16.D,
            "|",
            "uint16",
            "|",
            bundle_majority_10_time_1024_uint16,
        )
        var bundle_majority_10_time_16384_uint16 = benchmark.run[
            bench_bundle_majority_10_16384_uint16
        ]().mean(unit)
        print(
            HV_16384_uint16.D,
            "|",
            "uint16",
            "|",
            bundle_majority_10_time_16384_uint16,
        )
        var bundle_majority_10_time_512_uint32 = benchmark.run[
            bench_bundle_majority_10_512_uint32
        ]().mean(unit)
        print(
            HV_512_uint32.D,
            "|",
            "uint32",
            "|",
            bundle_majority_10_time_512_uint32,
        )
        var bundle_majority_10_time_1024_uint32 = benchmark.run[
            bench_bundle_majority_10_1024_uint32
        ]().mean(unit)
        print(
            HV_1024_uint32.D,
            "|",
            "uint32",
            "|",
            bundle_majority_10_time_1024_uint32,
        )
        var bundle_majority_10_time_16384_uint32 = benchmark.run[
            bench_bundle_majority_10_16384_uint32
        ]().mean(unit)
        print(
            HV_16384_uint32.D,
            "|",
            "uint32",
            "|",
            bundle_majority_10_time_16384_uint32,
        )
        var bundle_majority_10_time_512_uint64 = benchmark.run[
            bench_bundle_majority_10_512_uint64
        ]().mean(unit)
        print(
            HV_512_uint64.D,
            "|",
            "uint64",
            "|",
            bundle_majority_10_time_512_uint64,
        )
        var bundle_majority_10_time_1024_uint64 = benchmark.run[
            bench_bundle_majority_10_1024_uint64
        ]().mean(unit)
        print(
            HV_1024_uint64.D,
            "|",
            "uint64",
            "|",
            bundle_majority_10_time_1024_uint64,
        )
        var bundle_majority_10_time_16384_uint64 = benchmark.run[
            bench_bundle_majority_10_16384_uint64
        ]().mean(unit)
        print(
            HV_16384_uint64.D,
            "|",
            "uint64",
            "|",
            bundle_majority_10_time_16384_uint64,
        )

    arguments = argv()
    if len(arguments) > 1:
        for arg in arguments:
            if arg == "pop_count":
                benchmark_pop_count()
            elif arg == "xor":
                benchmark_xor()
            elif arg == "and":
                benchmark_and()
            elif arg == "or":
                benchmark_or()
            elif arg == "invert":
                benchmark_invert()
            elif arg == "lshift":
                benchmark_lshift()
            elif arg == "rshift":
                benchmark_rshift()
            elif arg == "bundle_majority":
                benchmark_bundle_majority()
            elif arg == "bundle_majority_10":
                benchmark_bundle_majority_10()
            elif arg == "creation":
                benchmark_creation()
            else:
                continue
    else:
        benchmark_creation()
        benchmark_pop_count()
        benchmark_xor()
        benchmark_and()
        benchmark_or()
        benchmark_invert()
        benchmark_lshift()
        benchmark_rshift()
        benchmark_bundle_majority()
        benchmark_bundle_majority_10()
