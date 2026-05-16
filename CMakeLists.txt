cmake_minimum_required(VERSION 3.20)

# If the user hasn't specified a compiler, prefer g++-16 when available
if(NOT DEFINED CMAKE_CXX_COMPILER)
  find_program(GCC16 g++-16)
  if(GCC16)
    set(CMAKE_CXX_COMPILER ${GCC16} CACHE STRING "C++ compiler" FORCE)
  endif()
endif()

project(ccache_example LANGUAGES CXX)

# Allow choosing the C++ standard via cache; default to latest widely-available (23)
set(CMAKE_CXX_STANDARD 23 CACHE STRING "C++ standard to use")
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# If ccache is installed, use it as a compiler launcher (speeds repeated builds)
find_program(CCACHE_PROGRAM ccache)
if(CCACHE_PROGRAM)
  message(STATUS "Found ccache: ${CCACHE_PROGRAM}; enabling compiler launcher")
  #set(CMAKE_C_COMPILER_LAUNCHER ${CCACHE_PROGRAM})
  set(CMAKE_CXX_COMPILER_LAUNCHER ${CCACHE_PROGRAM})
endif()

add_executable(main src/main.cpp)
target_compile_features(main PRIVATE cxx_std_23)

# Generate a number of simple translation units that include a heavy header
option(NUM_WORKERS "Number of worker translation units to generate" "20")

include_directories(${CMAKE_SOURCE_DIR}/src)

set(GEN_DIR ${CMAKE_BINARY_DIR}/generated)
file(MAKE_DIRECTORY ${GEN_DIR})

math(EXPR NUM_WORKERS_INT "${NUM_WORKERS}")
set(GEN_SRCS "")
foreach(i RANGE 1 ${NUM_WORKERS_INT})
  set(f ${GEN_DIR}/worker${i}.cpp)
  file(WRITE ${f} "#include \"heavy.hpp\"\nint worker_use_${i} = heavy_value();\n")
  list(APPEND GEN_SRCS ${f})
endforeach()

target_sources(main PRIVATE ${GEN_SRCS})

# Add a convenience target to print ccache stats if available
find_program(CCACHE_PROGRAM ccache)
if(CCACHE_PROGRAM)
  add_custom_target(ccache-stats COMMAND ${CCACHE_PROGRAM} -s WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
endif()
