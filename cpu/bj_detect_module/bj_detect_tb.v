`include "../utils/macros.v"
`include "../utils/encodings.v"
`include "bj_detect.v"

`define DECODE_DELAY #3

module bj_detect_tb;
    
    reg [2:0] BRANCH_JUMP;
    reg [31:0] DATA1,DATA2;

    wire PC_SEL;
    wire debugLt, debugEq;
    
    bj_detect_module my_bj_detect_module(BRANCH_JUMP, DATA1, DATA2, PC_SEL);

    initial begin

        // ------- BEQ Test 01 ----------
        // DATA1 = DATA2 (Branch Taken)

        BRANCH_JUMP = `BEQ;
        DATA1 = 32'd10;
        DATA2 = 32'd10;

        `DECODE_DELAY
        `assert(PC_SEL,1);

        $display("BEQ Test 01   - Branch taken test passed!");

        
        // ------- BEQ Test 02 ----------
        // DATA1 != DATA2 (Branch not Taken)

        BRANCH_JUMP = `BEQ;
        DATA1 = 32'd15;
        DATA2 = 32'd10;

        `DECODE_DELAY
        `assert(PC_SEL,0);

        $display("BEQ Test 02   - Branch not taken test passed!");
        
        
        // ------- BNE Test 01 ----------
        // DATA1 != DATA2 (Branch Taken)

        BRANCH_JUMP = `BNE;
        DATA1 = 32'd10;
        DATA2 = 32'd11;

        `DECODE_DELAY
        `assert(PC_SEL,1);

        $display("BNE Test 01   - Branch taken test passed!");
        

        // ------- BNE Test 02 ----------
        // DATA1 = DATA2 (Branch not Taken)
        
        BRANCH_JUMP = `BNE;
        DATA1 = 32'd10;
        DATA2 = 32'd10;

        `DECODE_DELAY
        `assert(PC_SEL,0);

        $display("BNE Test 02   - Branch not taken test passed!");


        // ------- NO BRANCH/JUMP Test  ----------
        
        BRANCH_JUMP = `NO;
        DATA1 = 32'dx;
        DATA2 = 32'dx;

        `DECODE_DELAY
        `assert(PC_SEL,0);

        $display("NO branch/jump test passed!");

        // ------- J Test  ----------
        
        BRANCH_JUMP = `J;
        DATA1 = 32'dx;
        DATA2 = 32'dx;

        `DECODE_DELAY
        `assert(PC_SEL,1);

        $display("J test passed!");


        // ------- BLT Test 01  ----------
        // DATA1 < DATA2 (Branch Taken)
        
        BRANCH_JUMP = `BLT;
        DATA1 = 32'd10;
        DATA2 = 32'd15;

        `DECODE_DELAY
        `assert(PC_SEL,1);

        $display("BLT Test 01   - Branch taken passed!");

        // ------- BLT Test 02  ----------
        // DATA1 > DATA2 (Branch not Taken)
        
        BRANCH_JUMP = `BLT;
        DATA1 = 32'd15;
        DATA2 = 32'd10;

        `DECODE_DELAY 
        `assert(PC_SEL,0);

        $display("BLT Test 02   - Branch not taken passed!");


        // ------- BLT Test 03  ----------
        // DATA1 = DATA2 (Branch Taken)
        
        BRANCH_JUMP = `BLT;
        DATA1 = 32'd10;
        DATA2 = 32'd10;

        `DECODE_DELAY
        `assert(PC_SEL,0);

        $display("BLT Test 03   - Branch not taken passed!");

        
        // ------- BGE Test 01  ----------
        // DATA1 > DATA2 (Branch Taken)
        
        BRANCH_JUMP = `BGE;
        DATA1 = 32'd15;
        DATA2 = 32'd10;

        `DECODE_DELAY
        `assert(PC_SEL,1);

        $display("BGE Test 01   - Branch taken passed!");

        
        // ------- BGE Test 02  ----------
        // DATA1 = DATA2 (Branch Taken)
        
        BRANCH_JUMP = `BGE;
        DATA1 = 32'd10;
        DATA2 = 32'd10;

        `DECODE_DELAY
        `assert(PC_SEL,1);

        $display("BGE Test 02   - Branch taken passed!");

        // ------- BGE Test 03  ----------
        // DATA1 < DATA2 (Branch not Taken)
        
        BRANCH_JUMP = `BGE;
        DATA1 = 32'd10;
        DATA2 = 32'd15;

        `DECODE_DELAY
        `assert(PC_SEL,0);

        $display("BGE Test 03   - Branch not taken passed!");


        // ------- BLTU Test 01  ----------
        // DATA1 < DATA2 (Branch Taken)
        
        BRANCH_JUMP = `BLTU;
        DATA1 = 32'h0003;
        DATA2 = 32'h8004;

        `DECODE_DELAY
        `assert(PC_SEL,1);

        $display("BLTU Test 01   - Branch taken passed!");


        // ------- BLTU Test 02  ----------
        // DATA1 > DATA2 (Branch not Taken)
        
        BRANCH_JUMP = `BLTU;
        DATA1 = 32'h8004;
        DATA2 = 32'h0003;

        `DECODE_DELAY
        `assert(PC_SEL,0);

        $display("BLTU Test 02   - Branch not taken passed!");


        // ------- BLTU Test 03  ----------
        // DATA1 = DATA2 (Branch not Taken)
        
        BRANCH_JUMP = `BLTU;
        DATA1 = 32'h8004;
        DATA2 = 32'h8004;

        `DECODE_DELAY
        `assert(PC_SEL,0);

        $display("BLTU Test 03   - Branch not taken passed!");


        // ------- BGEU Test 01  ----------
        // DATA1 > DATA2 (Branch Taken)
        
        BRANCH_JUMP = `BGEU;
        DATA1 = 32'h8005;
        DATA2 = 32'h8004;

        `DECODE_DELAY
        `assert(PC_SEL,1);

        $display("BGEU Test 01   - Branch taken passed!");

        
        // ------- BGEU Test 02  ----------
        // DATA1 = DATA2 (Branch Taken)
        
        BRANCH_JUMP = `BGEU;
        DATA1 = 32'h8005;
        DATA2 = 32'h8005;

        `DECODE_DELAY
        `assert(PC_SEL,1);

        $display("BGEU Test 02   - Branch taken passed!");


        // ------- BGEU Test 03  ----------
        // DATA1 < DATA2 (Branch not Taken)
        
        BRANCH_JUMP = `BGEU;
        DATA1 = 32'h8004;
        DATA2 = 32'h8005;

        `DECODE_DELAY
        `assert(PC_SEL,0);

        $display("BGEU Test 03   - Branch not taken passed!");


        $display("All Tests Passed !!!");

    
    end

endmodule