`include "../data_memory_module/data_memory.v"
`include "../instruction_memory_module/instruction_memory.v"
`include "cpu_single_cycle.v"

module cpu_single_cycle_tb;

reg RESET, CLK;
wire INST_MEM_READ, DATA_MEM_BUSYWAIT, DATA_MEM_READ, DATA_MEM_WRITE, INST_MEM_BUSYWAIT;
wire [127:0] INST_MEM_READDATA, DATA_MEM_READDATA, DATA_MEM_WRITEDATA;
wire [27:0] INST_MEM_ADDRESS, DATA_MEM_ADDRESS;
    
cpu_single_cycle cpu(RESET, CLK, INST_MEM_READDATA, DATA_MEM_READDATA, DATA_MEM_WRITEDATA, INST_MEM_READ, DATA_MEM_BUSYWAIT, DATA_MEM_READ, DATA_MEM_WRITE, INST_MEM_ADDRESS, DATA_MEM_ADDRESS, INST_MEM_BUSYWAIT);

data_memory d_mem(CLK, RESET, DATA_MEM_READ, DATA_MEM_WRITE, DATA_MEM_ADDRESS, DATA_MEM_WRITEDATA, DATA_MEM_READDATA, DATA_MEM_BUSYWAIT);

instruction_memory inst_mem(CLK, INST_MEM_READ, INST_MEM_ADDRESS, INST_MEM_READDATA, INST_MEM_BUSYWAIT);

integer j;

initial begin
    $readmemb("../instruction_memory_module/instr_mem.mem", inst_mem.MEM_ARRAY);
    $dumpfile("cpu_single_cycle_wavedata.vcd");
    $dumpvars(0, cpu_single_cycle_tb);
    for(j = 0; j < 16; j = j + 1) $dumpvars(0, inst_mem.MEM_ARRAY[j]);
    for(j = 0; j < 8; j = j + 1) $dumpvars(0, cpu.inst_cache.DATA[j]);
    for(j = 0; j < 32; j = j + 1) $dumpvars(0, cpu.register_file.REGISTER[j]);
    for(j = 0; j < 8; j = j + 1) $dumpvars(0, cpu.d_cache.DATA[j]);
    for(j = 0; j < 8; j = j + 1) $dumpvars(0, cpu.d_cache.VALID[j]);
    for(j = 0; j < 8; j = j + 1) $dumpvars(0, cpu.d_cache.TAG[j]);
    for(j = 0; j < 8; j = j + 1) $dumpvars(0, cpu.d_cache.DIRTY[j]);

    CLK = 1'b0;
    RESET = 1'b1;
    #1;
    RESET = 1'b1;
    #1;
    RESET = 1'b0;
    
    #500;
    $finish;    
end

// clock genaration.
always begin
    #6 CLK = ~CLK;
end

endmodule