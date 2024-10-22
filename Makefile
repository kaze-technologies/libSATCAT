

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
	c++ src/satcat.c src/satcat_code.c test/test.c -O3 -lm -ansi -Isrc -o bin/libsatcat-test-benchmark

hybrid-dynamic:
	mkdir -p bin
	mkdir -p lib
	cp test/test_data.txt bin
	
	c++ -mabi=aapcs -c -fPIC src/satcat.c -o lib/satcat_hybrid.o
	c++ -mabi=aapcs -shared -o lib/libsatcat_hybrid.so lib/satcat_hybrid.o
	
	c++ -mabi=aapcs -c -fPIC src/satcat_code.c -o lib/satcat_code_hybrid.o
	c++ -mabi=aapcs -shared -o lib/libsatcat_code_hybrid.so lib/satcat_code_hybrid.o
	
	c++ test/test.c -mabi=aapcs -O3 -lm -ansi -Isrc -o bin/libsatcat-test-hybridABI-dynamic-linked -lsatcat_hybrid -lsatcat_code_hybrid -Llib

purecap-dynamic:
	mkdir -p bin
	mkdir -p lib
	cp test/test_data.txt bin
	
	c++ -c -fPIC src/satcat.c -o lib/satcat.o
	c++ -shared -o lib/libsatcat.so lib/satcat.o
	
	c++ -c -fPIC src/satcat_code.c -o lib/satcat_code.o
	c++ -shared -o lib/libsatcat_code.so lib/satcat_code.o
	
	c++ test/test.c -O3 -lm -ansi -Isrc -o bin/libsatcat-test-purecap-dynamic-linked -lsatcat -lsatcat_code -Llib
	
purecap-compartmentalised:
	mkdir -p bin
	mkdir -p lib
	cp test/test_data.txt bin
	
	c++ -c -fPIC src/satcat.c -o lib/satcat_compartment.o
	c++ -shared -o lib/libsatcat_compartment.so lib/satcat_compartment.o
	
	c++ -c -fPIC src/satcat_code.c -o lib/satcat_code_compartment.o
	c++ -shared -o lib/libsatcat_code_compartment.so lib/satcat_code_compartment.o
	
	c++ test/test.c -Wl,-dynamic-linker=/libexec/ld-elf-c18n.so.1 -lm -ansi -Isrc -o bin/libsatcat-test-purecap-compartmentalised -lsatcat_compartment -lsatcat_code_compartment -Llib
