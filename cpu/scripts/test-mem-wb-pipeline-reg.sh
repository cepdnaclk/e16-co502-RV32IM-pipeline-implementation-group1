#!/bin/bash
echo "MEM/WB pipeline test bench run start!"
echo ""

# Navigate to reg-file module directory
cd ../pipeline_reg_modules/MEM_WB_pipeline_reg_module

# if any error happens exit
set -e

# clean
rm -rf mem_wb_pipeline_vvp.vvp
rm -rf mem_wb_pipeline_reg.vcd

# compiling
iverilog -o mem_wb_pipeline_vvp.vvp mem_wb_pipeline_reg_tb.v

# run
vvp mem_wb_pipeline_vvp.vvp

echo ""
echo "MEM/WB pipeline test bench run stopped!"
