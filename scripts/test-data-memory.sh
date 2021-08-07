#!/bin/bash
echo "data-memory test bench run start!"
echo ""

# Navigate to reg-file module directory
cd ../data_memory_module

# if any error happens exit
set -e

# clean
rm -rf data_memory.vvp
rm -rf data_memory_wavedata.vcd

# compiling
iverilog -o data_memory_tb.vvp data_memory_tb.v

# run
vvp data_memory_tb.vvp

echo ""
echo "data-memory test bench run stopped!"