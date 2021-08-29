#!/bin/bash
echo "forwarding unit test bench run start!"
echo ""

# Navigate to reg-file module directory
cd ../forwarding_unit_module

# if any error happens exit
set -e

# clean
rm -rf forwarding_unit.vvp
rm -rf forwarding_unit_wavedata.vcd

# compiling
iverilog -o forwarding_unit.vvp forwarding_unit_tb.v

# run
vvp forwarding_unit.vvp

echo ""
echo "forwarding unit test bench run stopped!"