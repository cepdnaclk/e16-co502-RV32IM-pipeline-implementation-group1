---
RV32IM pipeline implementation
---

# RV32IM pipeline implementation

## How to run a simple program in pipeline CPU

1. Add the assembly program to code `/cpu` directory.
2. Run the script `test-program.sh` with the program file as the arguemnt
   `./test-program.sh program.s`

   Now `cpu_pipeline_wavedata.vcd` will be created in `/cpu/cpu_pipeline` directory.

3. Open `cpu_pipeline_wavedata.vcd` with gtkwave to observe the signal changes.

### IMPORTANT!

iverilog version 11 is required, Lower version of iverilog other than 11 will cause unexpected outputs.
