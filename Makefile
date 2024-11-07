all: native-static hybrid-static purecap-static benchmark-static native-dynamic hybrid-dynamic purecap-dynamic benchmark-dynamic purecap-compartmentalised benchmark-compartmentalised

native-static:
	mkdir -p bin
	cp test/test_data.txt bin
	clang++ src/satcat.c src/satcat_code.c test/test.c -O3 -lm -ansi -Isrc -o bin/libsatcat-test-native

hybrid-static:
	mkdir -p bin
	cp test/test_data.txt bin
	c++ src/satcat.c src/satcat_code.c test/test.c -mabi=aapcs -O3 -lm -ansi -Isrc -o bin/libsatcat-test-hybridABI
	
purecap-static:
	mkdir -p bin
	cp test/test_data.txt bin
	c++ src/satcat.c src/satcat_code.c test/test.c -O3 -lm -ansi -Isrc -o bin/libsatcat-test-purecap
	
benchmark-static:
	mkdir -p bin
	cp test/test_data.txt bin
	c++ src/satcat.c src/satcat_code.c test/test.c -mabi=purecap-benchmark -O3 -lm -ansi -Isrc -o bin/libsatcat-test-benchmark

native-dynamic:
	mkdir -p bin
	mkdir -p lib
	cp test/test_data.txt bin
	
	clang++ -c -fPIC src/satcat.c -O3 -o lib/satcat_native.o
	clang++ -shared -O3 -o lib/libsatcat_native.so lib/satcat_native.o
	
	clang++ -c -fPIC src/satcat_code.c -O3 -o lib/satcat_code_native.o
	clang++ -shared -O3 -o lib/libsatcat_code_native.so lib/satcat_code_native.o
	
	clang++ test/test.c -O3 -lm -ansi -Isrc -o bin/libsatcat-test-native-dynamic-linked -lsatcat_native -lsatcat_code_native -Llib

hybrid-dynamic:
	mkdir -p bin
	mkdir -p lib
	cp test/test_data.txt bin
	
	c++ -mabi=aapcs -c -fPIC src/satcat.c -O3 -o lib/satcat_hybrid.o
	c++ -mabi=aapcs -shared -O3 -o lib/libsatcat_hybrid.so lib/satcat_hybrid.o
	
	c++ -mabi=aapcs -c -fPIC src/satcat_code.c -O3 -o lib/satcat_code_hybrid.o
	c++ -mabi=aapcs -shared -O3 -o lib/libsatcat_code_hybrid.so lib/satcat_code_hybrid.o
	
	c++ test/test.c -mabi=aapcs -O3 -lm -ansi -Isrc -o bin/libsatcat-test-hybridABI-dynamic-linked -lsatcat_hybrid -lsatcat_code_hybrid -Llib

purecap-dynamic:
	mkdir -p bin
	mkdir -p lib
	cp test/test_data.txt bin
	
	c++ -c -fPIC src/satcat.c -O3 -o lib/satcat.o
	c++ -shared -O3 -o lib/libsatcat.so lib/satcat.o
	
	c++ -c -fPIC src/satcat_code.c -O3 -o lib/satcat_code.o
	c++ -shared -O3 -o lib/libsatcat_code.so lib/satcat_code.o
	
	c++ test/test.c -O3 -lm -ansi -Isrc -o bin/libsatcat-test-purecap-dynamic-linked -lsatcat -lsatcat_code -Llib
	
benchmark-dynamic:
	mkdir -p bin
	mkdir -p lib
	cp test/test_data.txt bin
	
	c++ -mabi=purecap-benchmark -c -fPIC src/satcat.c -O3 -o lib/satcat_benchmark.o
	c++ -mabi=purecap-benchmark -shared -O3 -o lib/libsatcat_benchmark.so lib/satcat_benchmark.o
	
	c++ -mabi=purecap-benchmark -c -fPIC src/satcat_code.c -O3 -o lib/satcat_code_benchmark.o
	c++ -mabi=purecap-benchmark -shared -O3 -o lib/libsatcat_code_benchmark.so lib/satcat_code_benchmark.o
	
	c++ test/test.c -mabi=purecap-benchmark -O3 -lm -ansi -Isrc -o bin/libsatcat-test-benchmark-dynamic-linked -lsatcat_benchmark -lsatcat_code_benchmark -Llib
	
purecap-compartmentalised:
	mkdir -p bin
	mkdir -p lib
	cp test/test_data.txt bin
	
	c++ -c -fPIC src/satcat.c -O3 -o lib/satcat_compartment.o
	c++ -shared -O3 -o lib/libsatcat_compartment.so lib/satcat_compartment.o
	
	c++ -c -fPIC src/satcat_code.c -O3 -o lib/satcat_code_compartment.o
	c++ -shared -O3 -o lib/libsatcat_code_compartment.so lib/satcat_code_compartment.o
	
	c++ test/test.c -Wl,-dynamic-linker=/libexec/ld-elf-c18n.so.1 -lm -ansi -Isrc -o bin/libsatcat-test-purecap-compartmentalised -lsatcat_compartment -lsatcat_code_compartment -Llib
	
benchmark-compartmentalised:
	mkdir -p bin
	mkdir -p lib
	cp test/test_data.txt bin
	
	c++ -mabi=purecap-benchmark -c -fPIC src/satcat.c -O3 -o lib/satcat_benchmark_compartment.o
	c++ -mabi=purecap-benchmark -shared -O3 -o lib/libsatcat_benchmark_compartment.so lib/satcat_benchmark_compartment.o
	
	c++ -mabi=purecap-benchmark -c -fPIC src/satcat_code.c -O3 -o lib/satcat_code_benchmark_compartment.o
	c++ -mabi=purecap-benchmark -shared -O3 -o lib/libsatcat_code_benchmark_compartment.so lib/satcat_code_benchmark_compartment.o
	
	c++ test/test.c -mabi=purecap-benchmark -Wl,-dynamic-linker=/libexec/ld-elf64cb-c18n.so.1 -lm -ansi -Isrc -o bin/libsatcat-test-benchmark-compartmentalised -lsatcat_benchmark_compartment -lsatcat_code_benchmark_compartment -Llib
