
`include "../utils/macros.v" 
`include "alu.v"

module reg_file_tb;

    reg CLK, RESET;
    wire [31:0] RESULT;
    reg [31:0] DATA1, DATA2;
    reg [4:0] SELECT;

    alu myalu(DATA1, DATA2, RESULT, SELECT);
    
    initial begin
        CLK = 1'b0;
        #1
        RESET = 1'b1;

        #5
        RESET = 1'b0;

        /* 
            TEST 1 starts here!

            Should able to perfome add operation.
            SELECT = 00000 ,DATA1 = 5, DATA2=10, RESULT should be 15
        */
            SELECT = 5'b0;
            DATA1 = 32'd5;
            DATA2 = 32'd10;

            // wait for add to happen
            #3
            `assert(RESULT, 32'd15);
            
            $display("TEST 1 Passed!");
        /* TEST 1 ends here! */

        #500
        $finish;
    end

    // clock genaration.
    always begin
        #4 CLK = ~CLK;
    end

endmodule