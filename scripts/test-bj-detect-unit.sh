#!/bin/bash
echo "branch detect unit test bench run start!"
echo ""

# Navigate to reg-file module directory
cd ../bj_detect_module

# if any error happens exit
set -e

# clean
rm -rf bj_detect_vvp.vvp
rm -rf bj_detect_wavedata.vcd

# compiling
iverilog -o bj_detect_vvp.vvp bj_detect_tb.v

# run
vvp bj_detect_vvp.vvp

echo ""
echo "branch detect unit test bench run stopped!"