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
