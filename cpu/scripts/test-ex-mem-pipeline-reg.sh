#!/bin/bash
echo "EX/MEM pipeline test bench run start!"
echo ""

# Navigate to reg-file module directory
cd ../pipeline_reg_modules/EX_MEM_pipeline_reg_module

# if any error happens exit
set -e

# clean
rm -rf ex_mem_pipeline_vvp.vvp
rm -rf ex_mem_pipeline_reg.vcd

# compiling
iverilog -o ex_mem_pipeline_vvp.vvp ex_mem_pipeline_reg_tb.v

# run
vvp ex_mem_pipeline_vvp.vvp

echo ""
echo "EX/MEM pipeline test bench run stopped!"
