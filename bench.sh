#!/usr/bin/env bash
set -euo pipefail

echo "Benchmarking build with ccache"

NUM=${1:-20}
echo "Generating ${NUM} worker units"

rm -rf build

export CC=gcc-16
export CXX=g++-16

echo "Clearing ccache and zeroing stats (ensures true cold run)"
ccache -C || true
ccache -z || true

echo "Configure"
cmake -S . -B build -DNUM_WORKERS=${NUM}

echo
echo "First build (cold cache)"
time cmake --build build --parallel

echo
echo "ccache stats after first build"
ccache -s || true

echo
echo "Clean objects and rebuild (should hit cache)"
cmake --build build --target clean
time cmake --build build --parallel

echo
echo "ccache stats after second build"
ccache -s || true

echo
echo "Done"
