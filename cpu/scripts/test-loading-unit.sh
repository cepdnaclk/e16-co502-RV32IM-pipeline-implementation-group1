#!/bin/bash
echo "loading unit test bench run start!"
echo ""

# Navigate to reg-file module directory
cd ../loading_unit_module

# if any error happens exit
set -e

# clean
rm -rf loading_unit.vvp
rm -rf loading_unit_wavedata.vcd

# compiling
iverilog -o loading_unit_tb.vvp loading_unit_tb.v

# run
vvp loading_unit_tb.vvp

echo ""
echo "loading unit test bench run stopped!"
