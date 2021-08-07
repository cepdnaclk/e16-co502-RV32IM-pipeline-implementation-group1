#!/bin/bash
echo "cpu-pipeline test bench run start!"
echo ""

# Navigate to reg-file module directory
cd ../cpu_pipeline

# if any error happens exit
set -e

# clean
rm -rf cpu_pipeline.vvp
rm -rf cpu_pipeline_wavedata.vcd

# compiling
iverilog -o cpu_pipeline_tb.vvp cpu_pipeline_tb.v

# run
vvp cpu_pipeline_tb.vvp

echo ""
echo "cpu-pipeline test bench run stopped!"