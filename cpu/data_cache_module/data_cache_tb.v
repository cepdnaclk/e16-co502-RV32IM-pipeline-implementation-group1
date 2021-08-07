`include "data_cache.v"
`include "../data_memory_module/data_memory.v"

module data_cache_tb;

reg CLK, RESET;
reg[3:0] READ_WRITE;
reg [31:0] WRITEDATA, ADDRESS;
wire BUSYWAIT, MEM_BUSYWAIT, MEM_READ, MEM_WRITE;
wire [127:0] MEM_READDATA, MEM_WRITEDATA;
wire [27:0] MEM_ADDRESS;
wire [31:0] READDATA;

data_cache my_data_cache(CLK, RESET, BUSYWAIT, READ_WRITE, WRITEDATA, READDATA, ADDRESS, MEM_BUSYWAIT,MEM_READ, MEM_WRITE, MEM_READDATA, MEM_WRITEDATA, MEM_ADDRESS);

data_memory my_data_memory(CLK, RESET, MEM_READ, MEM_WRITE, MEM_ADDRESS, MEM_WRITEDATA, MEM_READDATA, MEM_BUSYWAIT);

integer j;

initial begin
    $dumpfile("data_cache_wavedata.vcd");
    $dumpvars(0, data_cache_tb);
    for(j = 0; j < 16; j = j + 1) $dumpvars(0, my_data_cache.DATA[j]);
    for(j = 0; j < 16; j = j + 1) $dumpvars(0, my_data_cache.TAG[j]);
    for(j = 0; j < 16; j = j + 1) $dumpvars(0, my_data_cache.DIRTY[j]);
    for(j = 0; j < 16; j = j + 1) $dumpvars(0, my_data_cache.VALID[j]);
    for(j = 0; j < 32; j = j + 1) $dumpvars(0, my_data_memory.MEM_ARRAY[j]);

    CLK = 1'b1;
    #1;
    RESET = 1'b0;
    #1;
    RESET = 1'b1;
    #1;
    RESET = 1'b0;

    READ_WRITE = 4'b1010; 
    ADDRESS = 32'h00000000;
    #183
    READ_WRITE = 4'b1011; 
    ADDRESS = 32'h00000000;
    WRITEDATA = 32'hABCD1234;
    #10
    READ_WRITE = 4'b1000; 
    ADDRESS = 32'h00000000;
    #500;
    $finish;

    end

    // clock genaration.
    always begin
        #4 CLK = ~CLK;
    end
    
endmodule