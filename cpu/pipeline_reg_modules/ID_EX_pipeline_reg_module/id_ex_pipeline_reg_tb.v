
`include "../../utils/macros.v" 
`include "id_ex_pipeline_reg.v"

module id_ex_pipeline_reg_tb;

    reg [4:0] IN_INSTRUCTION, IN_ALU_OP;
    reg [2:0] IN_BRANCH_JUMP;
    reg [1:0] IN_WB_SEL, IN_DATA1ALUSEL, IN_DATA2ALUSEL, IN_DATA1BJSEL, IN_DATA2BJSEL;
    reg [3:0] IN_READ_WRITE;
    
    reg [31:0] IN_PC,
            IN_DATA1,
            IN_DATA2,
            IN_IMMEDIATE;   

    reg IN_DATAMEMSEL,
        IN_REG_WRITE_EN,
        CLK, 
        RESET, 
        BUSYWAIT;

    wire [4:0] OUT_ALU_OP, OUT_INSTRUCTION;
    wire [2:0] OUT_BRANCH_JUMP;
    wire [1:0] OUT_WB_SEL, OUT_DATA1ALUSEL, OUT_DATA2ALUSEL, OUT_DATA1BJSEL, OUT_DATA2BJSEL;
    wire [3:0] OUT_READ_WRITE;

    wire [31:0] OUT_PC,
                    OUT_DATA1,
                    OUT_DATA2,
                    OUT_IMMEDIATE; 

    wire OUT_DATAMEMSEL,
        OUT_REG_WRITE_EN;


    id_ex_pipeline_reg my_id_ex_pipeline_reg(   IN_INSTRUCTION,
                                                IN_PC,
                                                IN_DATA1, 
                                                IN_DATA2, 
                                                IN_IMMEDIATE,
                                                IN_DATA1ALUSEL,
                                                IN_DATA2ALUSEL,
                                                IN_DATA1BJSEL, 
                                                IN_DATA2BJSEL,
                                                IN_ALU_OP,
                                                IN_BRANCH_JUMP,
                                                IN_DATAMEMSEL,
                                                IN_READ_WRITE,
                                                IN_WB_SEL,
                                                IN_REG_WRITE_EN,
                                                OUT_INSTRUCTION,
                                                OUT_PC,
                                                OUT_DATA1,
                                                OUT_DATA2,
                                                OUT_IMMEDIATE, 
                                                OUT_DATA1ALUSEL,
                                                OUT_DATA2ALUSEL,
                                                OUT_DATA1BJSEL, 
                                                OUT_DATA2BJSEL,
                                                OUT_ALU_OP,
                                                OUT_BRANCH_JUMP,
                                                OUT_DATAMEMSEL,
                                                OUT_READ_WRITE,
                                                OUT_WB_SEL,
                                                OUT_REG_WRITE_EN,
                                                CLK, 
                                                RESET,
                                                BUSYWAIT);
    
    initial begin
        
        CLK = 1'b0;
        RESET = 1'b0;
        BUSYWAIT = 1'b0;

        // set arbitrary values to inputs
        IN_INSTRUCTION = 5'd15;
        IN_PC = 32'd23;
        IN_DATA1 = 32'd45;  
        IN_DATA2 = 32'd33;   
        IN_IMMEDIATE = 32'd56; 
        IN_DATA1ALUSEL = 2'd1;
        IN_DATA2ALUSEL = 2'd1;
        IN_DATA1BJSEL = 2'd1; 
        IN_DATA2BJSEL = 2'd1;
        IN_ALU_OP = 5'd15;
        IN_BRANCH_JUMP = 3'd2;
        IN_DATAMEMSEL = 1'd1;
        IN_READ_WRITE = 4'd1;
        IN_WB_SEL = 2'b01;
        IN_REG_WRITE_EN = 1'b0;

        $dumpfile("id_ex_pipeline_reg.vcd");
        $dumpvars(0, id_ex_pipeline_reg_tb);


        /*
            Test 01 : RESET TEST
        */

        #1
        RESET = 1'b1;

        #5
        RESET = 1'b0;

        `assert(OUT_INSTRUCTION, 5'd0);
        `assert(OUT_PC, 32'd0);
        `assert(OUT_DATA1, 32'd0);
        `assert(OUT_DATA2, 32'd0);
        `assert(OUT_IMMEDIATE, 32'd0);
        `assert(OUT_DATA1ALUSEL, 2'd0);
        `assert(OUT_DATA2ALUSEL, 2'd0);
        `assert(OUT_DATA1BJSEL, 2'd0);
        `assert(OUT_DATA2BJSEL, 2'd0);
        `assert(OUT_ALU_OP, 5'd0);
        `assert(OUT_BRANCH_JUMP, 3'd0);
        `assert(OUT_DATAMEMSEL, 1'd0);
        `assert(OUT_READ_WRITE, 4'd0);
        `assert(OUT_WB_SEL, 2'b0);
        `assert(OUT_REG_WRITE_EN, 1'b0);

        $display("TEST 01 : RESET TEST Passed!");

        /* Test 01 ends here! */

        /*
            Test 02 : BUSYWAIT TEST 0
            Module should be able to write to Pipeline register when BUSYWAIT is set to 0
        */
        #1
        BUSYWAIT = 1'b0;

        // set arbitrary values to inputs
        IN_INSTRUCTION = 5'd15;
        IN_PC = 32'd23;
        IN_DATA1 = 32'd45;  
        IN_DATA2 = 32'd33;   
        IN_IMMEDIATE = 32'd56; 
        IN_DATA1ALUSEL = 2'd1;
        IN_DATA2ALUSEL = 2'd1;
        IN_DATA1BJSEL = 2'd1; 
        IN_DATA2BJSEL = 2'd1;
        IN_ALU_OP = 5'd15;
        IN_BRANCH_JUMP = 3'd2;
        IN_DATAMEMSEL = 1'd1;
        IN_READ_WRITE = 4'd1; 
        IN_WB_SEL = 2'b01;
        IN_REG_WRITE_EN = 1'b0;


        @(posedge CLK) begin
            
            // wait for write to happen.
            #3

            `assert(OUT_INSTRUCTION, 5'd15);
            `assert(OUT_PC, 32'd23);
            `assert(OUT_DATA1, 32'd45);
            `assert(OUT_DATA2, 32'd33);
            `assert(OUT_IMMEDIATE, 32'd56);
            `assert(OUT_DATA1ALUSEL, 2'd1);
            `assert(OUT_DATA2ALUSEL, 2'd1);
            `assert(OUT_DATA1BJSEL, 2'd1);
            `assert(OUT_DATA2BJSEL, 2'd1);
            `assert(OUT_ALU_OP, 5'd15);
            `assert(OUT_BRANCH_JUMP, 3'd2);
            `assert(OUT_DATAMEMSEL, 1'd1);
            `assert(OUT_READ_WRITE, 4'd1);
            `assert(OUT_WB_SEL, 2'b01);
            `assert(OUT_REG_WRITE_EN, 1'b0);

            $display("TEST 02 : BUSYWAIT_0 TEST Passed!");

        end

        /* Test 02 ends here! */
        
        /*
            Test 03 : BUSYWAIT TEST 1
            Module should be not beable to write to Pipeline register when BUSYWAIT is set to 1
        */
        
        // set BUSYWAIT to 1
        #1
        BUSYWAIT = 1'b1;

        // set arbitrary values to inputs
        IN_INSTRUCTION = 5'd25;
        IN_PC = 32'd43;
        IN_DATA1  = 32'd55;  
        IN_DATA2  = 32'd63;   
        IN_IMMEDIATE  = 32'd56; 
        IN_DATA1ALUSEL = 2'd0;
        IN_DATA2ALUSEL = 2'd0;
        IN_DATA1BJSEL = 2'd0; 
        IN_DATA2BJSEL = 2'd0;
        IN_ALU_OP = 5'd30;
        IN_BRANCH_JUMP = 3'd3;
        IN_DATAMEMSEL = 1'd0;
        IN_READ_WRITE = 4'd2;
        IN_WB_SEL = 2'b0;
        IN_REG_WRITE_EN = 1'b0;


        @(posedge CLK) begin
            
            // wait for write to happen.
            #3

            `assert(OUT_INSTRUCTION, 5'd15);
            `assert(OUT_PC, 32'd23);
            `assert(OUT_DATA1, 32'd45);
            `assert(OUT_DATA2, 32'd33);
            `assert(OUT_IMMEDIATE, 32'd56);
            `assert(OUT_DATA1ALUSEL, 1'b1);
            `assert(OUT_DATA2ALUSEL, 1'b1);
            `assert(OUT_DATA1BJSEL, 2'd1);
            `assert(OUT_DATA2BJSEL, 2'd1);
            `assert(OUT_ALU_OP, 5'd15);
            `assert(OUT_BRANCH_JUMP, 3'd2);
            `assert(OUT_DATAMEMSEL, 1'd1);
            `assert(OUT_READ_WRITE, 4'd1);
            `assert(OUT_WB_SEL, 2'b01);
            `assert(OUT_REG_WRITE_EN, 1'b0);

            $display("Test 03 : BUSYWAIT_1 TEST Passed!");

        end

        /* Test 03 ends here! */

        #100
        $finish;
    end

    // clock genaration.
    always begin
        #4 CLK = ~CLK;
    end

endmodule