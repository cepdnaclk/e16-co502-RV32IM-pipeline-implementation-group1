#!/bin/bash
echo "instruction-cache test bench run start!"
echo ""

# Navigate to reg-file module directory
cd ../instruction_cache_module

# if any error happens exit
set -e

# clean
rm -rf instruction_cache.vvp
rm -rf instruction_cache_waveinstruction.vcd

# compiling
iverilog -o instruction_cache_tb.vvp instruction_cache_tb.v

# run
vvp instruction_cache_tb.vvp

echo ""
echo "instruction-cache test bench run stopped!"