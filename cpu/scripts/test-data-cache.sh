#!/bin/bash
echo "data-cache test bench run start!"
echo ""

# Navigate to reg-file module directory
cd ../data_cache_module

# if any error happens exit
set -e

# clean
rm -rf data_cache.vvp
rm -rf data_cache_wavedata.vcd

# compiling
iverilog -o data_cache_tb.vvp data_cache_tb.v

# run
vvp data_cache_tb.vvp

echo ""
echo "data-cache test bench run stopped!"