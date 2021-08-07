#!/bin/bash
echo "instruction-memory test bench run start!"
echo ""

# Navigate to reg-file module directory
cd ../instruction_memory_module

# if any error happens exit
set -e

# clean
rm -rf instruction_memory.vvp
rm -rf instruction_memory_waveinstruction.vcd

# compiling
iverilog -o instruction_memory_tb.vvp instruction_memory_tb.v

# run
vvp instruction_memory_tb.vvp

echo ""
echo "instruction-memory test bench run stopped!"