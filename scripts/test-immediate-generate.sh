#!/bin/bash
echo "immediate-generate test bench run start!"
echo ""

# Navigate to reg-file module directory
cd ../immediate_gen_module

# if any error happens exit
set -e

# clean
rm -rf immediate_generate.vvp
rm -rf immediate_generate_wavedata.vcd

# compiling
iverilog -o immediate_generate_tb.vvp immediate_generate_tb.v

# run
vvp immediate_generate_tb.vvp

echo ""
echo "immediate-generate test bench run stopped!"