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

echo "deleteing all .out files"
rm -f **/*.out

echo "deleteing all .machine files"
rm -f *.machine

echo "deleteing all .mem files"
rm -f **/*.mem

echo "project folder cleaned!"
