`include "../data_memory_module/data_memory.v"
`include "../instruction_memory_module/instruction_memory.v"
`include "cpu_single_cycle.v"

module cpu_single_cycle_tb;

reg RESET, CLK;
wire INST_MEM_READ, DATA_MEM_BUSYWAIT, DATA_MEM_READ, DATA_MEM_WRITE, INST_MEM_BUSYWAIT;
wire [127:0] INST_MEM_READDATA, DATA_MEM_READDATA, DATA_MEM_WRITEDATA;
wire [27:0] INST_MEM_ADDRESS, DATA_MEM_ADDRESS;
    
cpu_single_cycle cpu(RESET, CLK, INST_MEM_READDATA, DATA_MEM_READDATA, DATA_MEM_WRITEDATA, INST_MEM_READ, DATA_MEM_BUSYWAIT, DATA_MEM_READ, DATA_MEM_WRITE, INST_MEM_ADDRESS, DATA_MEM_ADDRESS);

data_memory d_mem(CLK, RESET, DATA_MEM_READ, DATA_MEM_WRITE, DATA_MEM_ADDRESS, DATA_MEM_WRITEDATA, DATA_MEM_READDATA, DATA_MEM_BUSYWAIT);

instruction_memory inst_mem(CLK, INST_MEM_READ, INST_MEM_ADDRESS, INST_MEM_READDATA, INST_MEM_BUSYWAIT);

initial begin
    
end

endmodule