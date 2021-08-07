
`include "../utils/macros.v" 
`include "../utils/encodings.v"
`include "alu.v"

module alu_tb;

    reg CLK, RESET;
    wire [31:0] RESULT;
    reg [31:0] DATA1, DATA2;
    reg [4:0] SELECT;

    alu myalu(DATA1, DATA2, RESULT, SELECT);
    
    initial begin
        $dumpfile("alu_wavedata.vcd");
        $dumpvars(0, alu_tb);
        #1;
        /* 
            TEST 1 starts here!

            Should able to perfome add operation.
            SELECT = 00000 ,DATA1 = 5, DATA2=10, RESULT should be 15
        */
            SELECT = `ADD;
            DATA1 = 32'd5;
            DATA2 = 32'd10;

            // wait for add to happen
            #3
            `assert(RESULT, 32'd15);
            
            $display("ALU-OP ADD Passed!");
        /* TEST 1 ends here! */

        /* 
            TEST 2 starts here!

            Should able to perfome sub operation.
            DATA1 = 15, DATA2=10, RESULT should be 5
        */
            SELECT = `SUB;
            DATA1 = 32'd15;
            DATA2 = 32'd10;

            // wait for add to happen
            #3
            `assert(RESULT, 32'd5);
            
            $display("ALU-OP SUB Passed!");
        /* TEST 2 ends here! */

        /* 
            TEST 3 starts here!

            Should able to perfome SLL operation.
            DATA1 = 25, DATA2=2, RESULT should be 100
        */
            SELECT = `SLL;
            DATA1 = 32'd25;
            DATA2 = 32'd2;

            // wait for add to happen
            #5
            `assert(RESULT, 32'd100);
            
            $display("ALU-OP SLL Passed!");
        /* TEST 3 ends here! */

        /* 
            TEST 4 starts here!

            Should able to perfome XOR operation.
            DATA1 = 25, DATA2=2, RESULT should be 15
        */
            SELECT = `XOR;
            DATA1 = 32'd10;
            DATA2 = 32'd5;

            // wait for add to happen
            #5
            `assert(RESULT, 32'd15);
            
            $display("ALU-OP XOR Passed!");
        /* TEST 4 ends here! */

        /* 
            TEST 5 starts here!

            Should able to perfome SRL operation.
            DATA1 = 25, DATA2=2, RESULT should be 15
        */
            SELECT = `SRL;
            DATA1 = 32'd32;
            DATA2 = 32'd2;

            // wait for add to happen
            #5
            `assert(RESULT, 32'd8);
            
            $display("ALU-OP SRL Passed!");
        /* TEST 5 ends here! */

        /* 
            TEST 6 starts here!

            Should able to perfome SRA operation.
            DATA1 = -32, DATA2=2, RESULT should be -4
        */
            SELECT = `SRA;
            DATA1 = 32'sd32;
            DATA2 = 32'd2;

            // wait for add to happen
            #5
            `assert(RESULT, 32'sd8);
            
            $display("ALU-OP SRA Passed!");
        /* TEST 6 ends here! */

        /* 
            TEST 7 starts here!

            Should able to perfome OR operation.
            DATA1 = 12, DATA2=5, RESULT should be 13
        */
            SELECT = `OR;
            DATA1 = 32'd12;
            DATA2 = 32'd5;

            // wait for add to happen
            #5
            `assert(RESULT, 32'd13);
            
            $display("ALU-OP OR Passed!");
        /* TEST 7 ends here! */

        /* 
            TEST 8 starts here!

            Should able to perfome MUL operation.
            DATA1 = 12, DATA2=5, RESULT should be 4
        */
            SELECT = `MUL;
            DATA1 = 32'd4;
            DATA2 = 32'd5;

            // wait for add to happen
            #5
            `assert(RESULT, 32'd20);
            
            $display("ALU-OP MUL Passed!");
        /* TEST 8 ends here! */

        /* 
            TEST 9 starts here!

            Should able to perfome MULH operation.
            DATA1 = 131073, DATA2=131073, RESULT should be 4
            // 100000000000000001 × 100000000000000001 = 0100_00000000000001000000000000000001 (UPPER_LOWER32)
        */
            SELECT = `MULH;
            DATA1 = 32'd131073;
            DATA2 = 32'd131073;
            // wait for add to happen
            #5
            `assert(RESULT, 32'd4);
            
            $display("ALU-OP MULH Passed!");
        /* TEST 9 ends here! */

        /* 
            TEST 10 starts here!

            Should able to perfome DIV operation.
            DATA1 = 32, DATA2=2, RESULT should be 16
        */
            SELECT = `DIV;
            DATA1 = 32'd32;
            DATA2 = 32'd2;
            // wait for add to happen
            #5
            `assert(RESULT, 32'd16);
            
            $display("ALU-OP DIV Passed!");
        /* TEST 10 ends here! */

        /* 
            TEST 11 starts here!

            Should able to perfome REM operation.
            DATA1 = 32, DATA2=2, RESULT should be 16
        */
            SELECT = `REM;
            DATA1 = 32'd31;
            DATA2 = 32'd2;
            // wait for add to happen
            #5
            `assert(RESULT, 32'd1);
            
            $display("ALU-OP REM Passed!");
        /* TEST 11 ends here! */

        //TODO: Add MULHU, MULSHU, DIVU and REMU 

        #500
        $finish;
    end

endmodule