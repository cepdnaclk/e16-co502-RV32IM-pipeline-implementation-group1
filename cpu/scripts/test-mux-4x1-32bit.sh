#!/bin/bash
echo "test-mux-4x1-32bit test bench run start!"
echo ""

# Navigate to reg-file module directory
cd ../other_modules/mux_4x1_32bit

# if any error happens exit
set -e

# clean
rm -rf mux_4x1_32bit.vvp
rm -rf mux_4x1_32bit_wavedata.vcd

# compiling
iverilog -o mux_4x1_32bit_tb.vvp mux_4x1_32bit_tb.v

# run
vvp mux_4x1_32bit_tb.vvp

echo ""
echo "test-mux-4x1-32bit test bench run stopped!"