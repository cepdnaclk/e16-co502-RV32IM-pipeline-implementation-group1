`include "instruction_memory.v"
module instruction_memory_tb;

    reg CLK, RESET, READ;
    reg [27:0] ADDRESS;
    wire [127:0] READDATA;
    wire BUSYWAIT;

    integer j;
    
    instruction_memory my_instruction_memory(CLK, READ, ADDRESS, READDATA, BUSYWAIT);

    initial begin
        $dumpfile("instruction_memory_wavedata.vcd");
        $dumpvars(0, instruction_memory_tb);
        for(j = 0; j < 8; j = j + 1) $dumpvars(0, my_instruction_memory.MEM_ARRAY[j]);


        CLK = 1'b0;




        #500;
        $finish;

    end

    // clock genaration.
    always begin
        #4 CLK = ~CLK;
    end

    

endmodule