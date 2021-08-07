`include "data_memory.v"
module data_memory_tb;

    reg CLK, RESET, READ, WRITE;
    reg [27:0] ADDRESS;
    reg [127:0] WRITEDATA;
    wire [127:0] READDATA;
    wire BUSYWAIT;

    integer j;
    
    data_memory my_data_memory(CLK, RESET, READ, WRITE, ADDRESS, WRITEDATA, READDATA, BUSYWAIT);

    initial begin
        $dumpfile("data_memory_wavedata.vcd");
        $dumpvars(0, data_memory_tb);
        for(j = 0; j < 100; j = j + 1) $dumpvars(0, my_data_memory.MEM_ARRAY[j]);


        CLK = 1'b0;
        RESET = 1'b0;
        #5;
        RESET = 1'b1;
        #1;
        RESET = 1'b0;
        
        WRITE = 1'b1;
        READ = 1'b0;
        ADDRESS = 15'b0000_0000_0000_0000_0000_0000_0000;
        WRITEDATA = 128'hABCD1234_ABCD1234_ABCD1234_ABCD1234;
        #200;


        WRITE = 1'b0;
        READ = 1'b1;
        ADDRESS = 15'b0000_0000_0000_0000_0000_0000_0000;





        #500;
        $finish;

    end

    // clock genaration.
    always begin
        #4 CLK = ~CLK;
    end

    

endmodule