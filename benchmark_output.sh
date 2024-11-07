#! /bin/bash

printf "\n\e[34mSTATIC NATIVE BENCHMARK OUTPUT\n"
printf "\e[35m"
file bin/libsatcat-test-native
printf "\e[37m"
pmcstat -p CPU_CYCLES bin/libsatcat-test-native "test/test_data.txt"
printf "\e[34m_______________________________\n"

printf "\n\e[34mSTATIC HYBRID_ABI BENCHMARK OUTPUT\n"
printf "\e[35m"
file bin/libsatcat-test-hybridABI
printf "\e[37m"
pmcstat -p CPU_CYCLES bin/libsatcat-test-hybridABI "test/test_data.txt"
printf "\e[34m_______________________________\n"

printf "\n\e[34mSTATIC PURECAP BENCHMARK OUTPUT\n"
printf "\e[35m"
file bin/libsatcat-test-purecap
printf "\e[37m"
pmcstat -p CPU_CYCLES bin/libsatcat-test-purecap "test/test_data.txt"
printf "\e[34m_______________________________\n"

printf "\n\e[34mSTATIC BENCHMARK_ABI BENCHMARK OUTPUT\n"
printf "\e[35m"
file bin/libsatcat-test-benchmark
printf "\e[37m"
pmcstat -p CPU_CYCLES bin/libsatcat-test-benchmark "test/test_data.txt"
printf "\e[34m_______________________________\n"

printf "\n\e[34mSHARED LIBRARY NATIVE BENCHMARK OUTPUT\n"
printf "\e[35m"
file bin/libsatcat-test-native-dynamic-linked
printf "\e[37m"
LD_64_LIBRARY_PATH=lib pmcstat -p CPU_CYCLES bin/libsatcat-test-native-dynamic-linked "test/test_data.txt"
printf "\e[34m_______________________________\n"

printf "\n\e[34mSHARED LIBRARY HybridABI BENCHMARK OUTPUT\n"
printf "\e[35m"
file bin/libsatcat-test-hybridABI-dynamic-linked
printf "\e[37m"
LD_64_LIBRARY_PATH=lib pmcstat -p CPU_CYCLES bin/libsatcat-test-hybridABI-dynamic-linked "test/test_data.txt"
printf "\e[34m_______________________________\n"

printf "\n\e[34mSHARED LIBRARY PURECAP BENCHMARK OUTPUT\n"
printf "\e[35m"
file bin/libsatcat-test-purecap-dynamic-linked
printf "\e[37m"
LD_LIBRARY_PATH=lib pmcstat -p CPU_CYCLES bin/libsatcat-test-purecap-dynamic-linked "test/test_data.txt"
printf "\e[34m_______________________________\n"

printf "\n\e[34mSHARED LIBRARY BENCHMARK_ABI BENCHMARK OUTPUT\n"
printf "\e[35m"
file bin/libsatcat-test-hybridABI-dynamic-linked
printf "\e[37m"
LD_64CB_LIBRARY_PATH=lib pmcstat -p CPU_CYCLES bin/libsatcat-test-benchmark-dynamic-linked "test/test_data.txt"
printf "\e[34m_______________________________\n"

printf "\n\e[34mCOMPARTMENTALISED LIBRARY PURECAP BENCHMARK OUTPUT\n"
printf "\e[35m"
file bin/libsatcat-test-purecap-compartmentalised
printf "\e[37m"
LD_C18N_LIBRARY_PATH=lib pmcstat -p CPU_CYCLES bin/libsatcat-test-purecap-compartmentalised "test/test_data.txt"
printf "\e[34m_______________________________\n"

printf "\n\e[34mCOMPARTMENTALISED LIBRARY BENCHMARKABI BENCHMARK OUTPUT\n"
printf "\e[35m"
file bin/libsatcat-test-benchmark-compartmentalised
printf "\e[37m"
LD_64CB_C18N_LIBRARY_PATH=lib pmcstat -p CPU_CYCLES bin/libsatcat-test-benchmark-compartmentalised "test/test_data.txt"
printf "\e[34m_______________________________\n"

printf "\e[37m"
