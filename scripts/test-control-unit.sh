#!/bin/bash
echo "control-unit test bench run start!"
echo ""

# Navigate to reg-file module directory
cd ../control_unit_module

# if any error happens exit
set -e

# clean
rm -rf control_unit.vvp
rm -rf control_unit_wavedata.vcd

# compiling
iverilog -o control_unit_tb.vvp control_unit_tb.v

# run
vvp control_unit_tb.vvp

echo ""
echo "control-unit test bench run stopped!"