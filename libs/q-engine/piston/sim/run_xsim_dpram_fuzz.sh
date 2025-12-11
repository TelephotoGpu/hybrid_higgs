#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
build_dir="$script_dir/xsim_dpram_fuzz"
amd_root="$(cd "$(dirname "$(command -v vivado)")/../.." && pwd)"
xpm_memory="$amd_root/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv"
mkdir -p "$build_dir"
cd "$build_dir"

xvlog -sv -d HIGGS_FPGA_XILINX \
    "$xpm_memory" \
    "$script_dir/../hdl/memory_slice.v" \
    "$script_dir/xpm_dpram_fuzz_tb.sv"
xelab xpm_dpram_fuzz_tb -s xpm_dpram_fuzz
xsim xpm_dpram_fuzz -runall "$@"
