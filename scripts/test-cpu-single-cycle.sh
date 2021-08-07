#!/bin/bash
echo "cpu-single-cycle test bench run start!"
echo ""

# Navigate to reg-file module directory
cd ../cpu_single_cycle

# if any error happens exit
set -e

# clean
rm -rf cpu_single_cycle.vvp
rm -rf cpu_single_cycle_wavedata.vcd

# compiling
iverilog -o cpu_single_cycle_tb.vvp cpu_single_cycle_tb.v

# run
vvp cpu_single_cycle_tb.vvp

echo ""
echo "cpu-single-cycle test bench run stopped!"