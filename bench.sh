#!/usr/bin/env bash
set -euo pipefail

echo "Benchmarking build: non-unity then unity"

NUM=${1:-20}
GEN_MODE=${2:-both} # options: ninja, make, both
echo "Workers: ${NUM}"

rm -rf build build-* || true

export CC=gcc-16
export CXX=g++-16

CCACHE_PROG=$(command -v ccache || true)
NINJA_PROG=$(command -v ninja || true)

# Build generator selection
gens=()
if [ "${GEN_MODE}" = "ninja" ]; then
	if [ -n "${NINJA_PROG}" ]; then
		gens+=("Ninja")
	else
		echo "Ninja not found; falling back to Unix Makefiles"
		gens+=("Unix Makefiles")
	fi
elif [ "${GEN_MODE}" = "make" ]; then
	gens+=("Unix Makefiles")
else
	# both: prefer to run Makefiles and Ninja (if present)
	gens+=("Unix Makefiles")
	if [ -n "${NINJA_PROG}" ]; then
		gens+=("Ninja")
	fi
fi

declare -A COLD_TIMES
declare -A CACHED_TIMES

function do_run() {
	local mode=$1
	local unityflag=$2
	local gen=$3
	# sanitize gen label for directory name
	local genlabel=$(echo "${gen}" | tr ' ' '-' | tr -s '-')
	local builddir=build-${mode}-${genlabel}

	echo
	echo "=== Mode: ${mode} (UNITY_BUILD=${unityflag}) Generator=${gen} ==="
	rm -rf "${builddir}"

	if [ -n "${CCACHE_PROG}" ]; then
		echo "Clearing ccache and zeroing stats (ensures true cold run)"
		ccache -C || true
		ccache -z || true
	fi

	echo "Configure"
	cmake -S . -B "${builddir}" -G "${gen}" -DNUM_WORKERS=${NUM} -DUNITY_BUILD=${unityflag}

	echo
	echo "First build (cold cache)"
	start=$(python3 -c 'import time; print(time.monotonic())')
	cmake --build "${builddir}" --parallel
	end=$(python3 -c 'import time; print(time.monotonic())')
	cold_elapsed=$(awk "BEGIN{print ${end} - ${start}}")
	COLD_TIMES["${genlabel}_${mode}"]=${cold_elapsed}
	printf "  elapsed: %s s\n" "${cold_elapsed}"

	if [ -n "${CCACHE_PROG}" ]; then
		echo
		echo "ccache stats after first build"
		ccache -s || true
	fi

	echo
	echo "Clean objects and rebuild (should hit cache)"
	cmake --build "${builddir}" --target clean
	start=$(python3 -c 'import time; print(time.monotonic())')
	cmake --build "${builddir}" --parallel
	end=$(python3 -c 'import time; print(time.monotonic())')
	cached_elapsed=$(awk "BEGIN{print ${end} - ${start}}")
	CACHED_TIMES["${genlabel}_${mode}"]=${cached_elapsed}
	printf "  elapsed (cached): %s s\n" "${cached_elapsed}"

	if [ -n "${CCACHE_PROG}" ]; then
		echo
		echo "ccache stats after second build"
		ccache -s || true
	fi
}

for gen in "${gens[@]}"; do
	do_run nonunity OFF "${gen}"
	do_run unity ON "${gen}"
done

echo
echo "Summary timings (seconds)"
printf "%-20s %12s %12s %12s %12s\n" "Generator" "nonunity_cold" "nonunity_cached" "unity_cold" "unity_cached"
for gen in "${gens[@]}"; do
	genlabel=$(echo "${gen}" | tr ' ' '-' | tr -s '-')
	key_nu=${genlabel}_nonunity
	key_u=${genlabel}_unity
	nu_c=${COLD_TIMES["${key_nu}"]:-N/A}
	nu_h=${CACHED_TIMES["${key_nu}"]:-N/A}
	u_c=${COLD_TIMES["${key_u}"]:-N/A}
	u_h=${CACHED_TIMES["${key_u}"]:-N/A}
	printf "%-20s %12s %12s %12s %12s\n" "${gen}" "${nu_c}" "${nu_h}" "${u_c}" "${u_h}"
done

echo
echo "All done"
