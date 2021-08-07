`include "instruction_cache.v"
`include "../instruction_memory_module/instruction_memory.v"

module instruction_cache_tb;

reg CLK, RESET;
reg [31:0] ADDRESS;
wire BUSYWAIT, MEM_BUSYWAIT, MEM_READ;
wire [127:0] MEM_READDATA;
wire [27:0] MEM_ADDRESS;
wire [31:0] READDATA;

instruction_cache my_instruction_cache(CLK, RESET, ADDRESS, READDATA, BUSYWAIT, MEM_ADDRESS, MEM_READ, MEM_READDATA, MEM_BUSYWAIT);

instruction_memory my_instruction_memory(CLK, MEM_READ, MEM_ADDRESS, MEM_READDATA, MEM_BUSYWAIT);

integer j;

initial begin
    $dumpfile("instruction_cache_wavedata.vcd");
    $dumpvars(0, instruction_cache_tb);
    for(j = 0; j < 8; j = j + 1) $dumpvars(0, my_instruction_cache.DATA[j]);
    for(j = 0; j < 8; j = j + 1) $dumpvars(0, my_instruction_cache.TAG[j]);
    for(j = 0; j < 8; j = j + 1) $dumpvars(0, my_instruction_cache.VALID[j]);
    for(j = 0; j < 32; j = j + 1) $dumpvars(0, my_instruction_memory.MEM_ARRAY[j]);

    CLK = 1'b1;
    #1;
    RESET = 1'b0;
    #1;
    RESET = 1'b1;
    #1;
    RESET = 1'b0;

    ADDRESS = 32'h00000000;
    #500;
    $finish;

    end

    // clock genaration.
    always begin
        #4 CLK = ~CLK;
    end
    
endmodule