#!/bin/bash
echo "alu test bench run start!"
echo ""

# Navigate to reg-file module directory
cd ../alu_module

# if any error happens exit
set -e

# clean
rm -rf alu_vvp.vvp
rm -rf alu_wavedata.vcd

# compiling
iverilog -o alu_vvp.vvp alu_tb.v

# run
vvp alu_vvp.vvp

echo ""
echo "alu test bench run stopped!"
