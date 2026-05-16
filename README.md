# ccache_example

Minimal C++ project using CMake. Prefers `g++-16` and sets C++ standard to C++23 by default.

Build (recommended):

```bash
# configure (explicitly select compilers if desired)
cmake -S . -B build \
  -DCMAKE_C_COMPILER=gcc-16 -DCMAKE_CXX_COMPILER=g++-16

# build
cmake --build build --parallel

# run
./build/main
```

If `ccache` is installed, CMake will use it automatically to speed repeated builds.


## RESULTS
```
crich@Recursion:~/CODE/c++/ccache$ ./bench.sh
Benchmarking build with ccache
Generating 20 worker units
Clearing ccache and zeroing stats (ensures true cold run)
Clearing... 100.0% [===================================================================================================]
Statistics zeroed
Configure
-- The CXX compiler identification is GNU 16.0.1
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: /usr/bin/g++-16 - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Found ccache: /usr/bin/ccache; enabling compiler launcher
-- Configuring done (0.5s)
-- Generating done (0.0s)
-- Build files have been written to: /home/crich/CODE/c++/ccache/build

First build (cold cache)
[  9%] Building CXX object CMakeFiles/main.dir/generated/worker1.cpp.o
[  9%] Building CXX object CMakeFiles/main.dir/src/main.cpp.o
[ 13%] Building CXX object CMakeFiles/main.dir/generated/worker5.cpp.o
[ 36%] Building CXX object CMakeFiles/main.dir/generated/worker4.cpp.o
[ 36%] Building CXX object CMakeFiles/main.dir/generated/worker6.cpp.o
[ 36%] Building CXX object CMakeFiles/main.dir/generated/worker7.cpp.o
[ 36%] Building CXX object CMakeFiles/main.dir/generated/worker2.cpp.o
[ 36%] Building CXX object CMakeFiles/main.dir/generated/worker8.cpp.o
[ 45%] Building CXX object CMakeFiles/main.dir/generated/worker10.cpp.o
[ 45%] Building CXX object CMakeFiles/main.dir/generated/worker3.cpp.o
[ 54%] Building CXX object CMakeFiles/main.dir/generated/worker15.cpp.o
[ 54%] Building CXX object CMakeFiles/main.dir/generated/worker9.cpp.o
[ 63%] Building CXX object CMakeFiles/main.dir/generated/worker11.cpp.o
[ 63%] Building CXX object CMakeFiles/main.dir/generated/worker17.cpp.o
[ 68%] Building CXX object CMakeFiles/main.dir/generated/worker19.cpp.o
[ 77%] Building CXX object CMakeFiles/main.dir/generated/worker13.cpp.o
[ 81%] Building CXX object CMakeFiles/main.dir/generated/worker14.cpp.o
[ 81%] Building CXX object CMakeFiles/main.dir/generated/worker12.cpp.o
[ 90%] Building CXX object CMakeFiles/main.dir/generated/worker16.cpp.o
[ 90%] Building CXX object CMakeFiles/main.dir/generated/worker18.cpp.o
[ 95%] Building CXX object CMakeFiles/main.dir/generated/worker20.cpp.o
[100%] Linking CXX executable main
[100%] Built target main

real    0m0.924s
user    0m1.436s
sys     0m0.899s

ccache stats after first build
Cacheable calls:     21 /  21 (100.0%)
  Hits:               0 /  21 ( 0.00%)
    Direct:           0
    Preprocessed:     0
  Misses:            21 /  21 (100.0%)
Local storage:
  Cache size (GiB): 0.0 / 5.0 ( 0.00%)
  Hits:               0 /  21 ( 0.00%)
  Misses:            21 /  21 (100.0%)

Clean objects and rebuild (should hit cache)
[  4%] Building CXX object CMakeFiles/main.dir/generated/worker1.cpp.o
[ 18%] Building CXX object CMakeFiles/main.dir/generated/worker7.cpp.o
[ 22%] Building CXX object CMakeFiles/main.dir/src/main.cpp.o
[ 18%] Building CXX object CMakeFiles/main.dir/generated/worker5.cpp.o
[ 22%] Building CXX object CMakeFiles/main.dir/generated/worker4.cpp.o
[ 27%] Building CXX object CMakeFiles/main.dir/generated/worker3.cpp.o
[ 31%] Building CXX object CMakeFiles/main.dir/generated/worker2.cpp.o
[ 36%] Building CXX object CMakeFiles/main.dir/generated/worker11.cpp.o
[ 40%] Building CXX object CMakeFiles/main.dir/generated/worker6.cpp.o
[ 45%] Building CXX object CMakeFiles/main.dir/generated/worker10.cpp.o
[ 50%] Building CXX object CMakeFiles/main.dir/generated/worker12.cpp.o
[ 59%] Building CXX object CMakeFiles/main.dir/generated/worker8.cpp.o
[ 59%] Building CXX object CMakeFiles/main.dir/generated/worker9.cpp.o
[ 63%] Building CXX object CMakeFiles/main.dir/generated/worker13.cpp.o
[ 68%] Building CXX object CMakeFiles/main.dir/generated/worker14.cpp.o
[ 77%] Building CXX object CMakeFiles/main.dir/generated/worker17.cpp.o
[ 77%] Building CXX object CMakeFiles/main.dir/generated/worker15.cpp.o
[ 81%] Building CXX object CMakeFiles/main.dir/generated/worker16.cpp.o
[ 90%] Building CXX object CMakeFiles/main.dir/generated/worker18.cpp.o
[ 90%] Building CXX object CMakeFiles/main.dir/generated/worker20.cpp.o
[ 95%] Building CXX object CMakeFiles/main.dir/generated/worker19.cpp.o
[100%] Linking CXX executable main
[100%] Built target main

real    0m0.170s
user    0m0.147s
sys     0m0.206s

ccache stats after second build
Cacheable calls:     42 /  42 (100.0%)
  Hits:              21 /  42 (50.00%)
    Direct:          21 /  21 (100.0%)
    Preprocessed:     0 /  21 ( 0.00%)
  Misses:            21 /  42 (50.00%)
Local storage:
  Cache size (GiB): 0.0 / 5.0 ( 0.00%)
  Hits:              21 /  42 (50.00%)
  Misses:            21 /  42 (50.00%)

Done
```