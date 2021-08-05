#!/bin/bash
echo "ID/EX pipeline test bench run start!"
echo ""

# Navigate to reg-file module directory
cd ../pipeline_reg_modules/ID_EX_pipeline_reg_module

# if any error happens exit
set -e

# clean
rm -rf id_ex_pipeline_vvp.vvp
rm -rf id_ex_pipeline_reg.vcd

# compiling
iverilog -o id_ex_pipeline_vvp.vvp id_ex_pipeline_reg_tb.v

# run
vvp id_ex_pipeline_vvp.vvp

echo ""
echo "ID/EX pipeline test bench run stopped!"
