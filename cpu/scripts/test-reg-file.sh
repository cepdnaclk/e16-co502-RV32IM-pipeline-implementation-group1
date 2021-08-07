#!/bin/bash
echo "reg-file test bench run start!"
echo ""

# Navigate to reg-file module directory
cd ../reg_file_module

# if any error happens exit
set -e

# clean
rm -rf reg_file_vvp.vvp
rm -rf reg_file_wavedata.vcd

# compiling
iverilog -o reg_file_vvp.vvp reg_file_tb.v

# run
vvp reg_file_vvp.vvp

echo ""
echo "reg-file test bench run stopped!"
