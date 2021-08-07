#!/bin/bash
echo "IF/ID pipeline test bench run start!"
echo ""

# Navigate to reg-file module directory
cd ../pipeline_reg_modules/IF_ID_pipeline_reg_module

# if any error happens exit
set -e

# clean
rm -rf if_id_pipeline_vvp.vvp
rm -rf if_id_pipeline_reg.vcd

# compiling
iverilog -o if_id_pipeline_vvp.vvp if_id_pipeline_reg_tb.v

# run
vvp if_id_pipeline_vvp.vvp

echo ""
echo "IF/ID pipeline test bench run stopped!"
