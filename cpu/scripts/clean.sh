#!/bin/bash

# Navigate to project root directory
cd ..

# if any error happens exit
set -e

# clean
echo "deleting all .vcd files"
rm -f **/*.vcd

echo "deleting all .vvp files"
rm -f **/*.vvp

echo "project folder cleaned!"
