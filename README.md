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
Summary timings (seconds)
Generator            nonunity_cold nonunity_cached   unity_cold unity_cached
Unix Makefiles           0.942213     0.185985     0.912635     0.183829
Ninja                    0.867462     0.119942     0.832354     0.105707
```