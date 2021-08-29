
`include "../../utils/macros.v" 
`include "ex_mem_pipeline_reg.v"

module ex_mem_pipeline_reg_tb;

    reg [4:0] IN_INSTRUCTION;
    reg [1:0] IN_WB_SEL;
    reg [3:0] IN_READ_WRITE;
    
    reg [31:0] IN_PC,
            IN_ALU_RESULT,
            IN_DATA2,
            IN_IMMEDIATE;   

    reg IN_REG_WRITE_EN,
        IN_DATAMEMSEL,
        CLK, 
        RESET, 
        BUSYWAIT;

    wire [4:0] OUT_INSTRUCTION;
    wire [1:0] OUT_WB_SEL;
    wire [3:0] OUT_READ_WRITE;

    wire [31:0] OUT_PC,
            OUT_ALU_RESULT,
            OUT_DATA2,
            OUT_IMMEDIATE;
    
    wire OUT_REG_WRITE_EN, OUT_DATAMEMSEL;


    ex_mem_pipeline_reg my_ex_mem_pipeline_reg( IN_INSTRUCTION,
                                                IN_PC,
                                                IN_ALU_RESULT, 
                                                IN_DATA2, 
                                                IN_IMMEDIATE,
                                                IN_DATAMEMSEL,
                                                IN_READ_WRITE,
                                                IN_WB_SEL,
                                                IN_REG_WRITE_EN,
                                                OUT_INSTRUCTION,
                                                OUT_PC,
                                                OUT_ALU_RESULT,
                                                OUT_DATA2,
                                                OUT_IMMEDIATE, 
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
        IN_ALU_RESULT = 32'd45; 
        IN_DATA2 = 32'd33;  
        IN_IMMEDIATE = 32'd56; 
        IN_DATAMEMSEL = 1'b1;
        IN_READ_WRITE  = 4'd1;
        IN_WB_SEL = 2'b11;
        IN_REG_WRITE_EN = 1'b1;

        $dumpfile("ex_mem_pipeline_reg.vcd");
        $dumpvars(0, ex_mem_pipeline_reg_tb);


        /*
            Test 01 : RESET TEST
        */

        #1
        RESET = 1'b1;

        #5
        RESET = 1'b0;

        `assert(OUT_INSTRUCTION, 5'd0);
        `assert(OUT_PC, 32'd0);
        `assert(OUT_ALU_RESULT, 32'd0);
        `assert(OUT_DATA2, 32'd0);
        `assert(OUT_IMMEDIATE, 32'd0);
        `assert(OUT_DATAMEMSEL, 32'd0);
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

        IN_INSTRUCTION = 5'd10;
        IN_PC = 32'd20;
        IN_ALU_RESULT = 32'd30; 
        IN_DATA2 = 32'd40;  
        IN_IMMEDIATE = 32'd50; 
        IN_DATAMEMSEL = 1'b1;
        IN_READ_WRITE = 4'd1;
        IN_WB_SEL = 2'b01;
        IN_REG_WRITE_EN = 1'b1;


        @(posedge CLK) begin
            
            // wait for write to happen.
            #3

            `assert(OUT_INSTRUCTION, 5'd10);
            `assert(OUT_PC, 32'd20);
            `assert(OUT_ALU_RESULT, 32'd30);
            `assert(OUT_DATA2, 32'd40);
            `assert(OUT_IMMEDIATE, 32'd50);
            `assert(OUT_DATAMEMSEL, 1'b1);
            `assert(OUT_READ_WRITE, 4'd1);
            `assert(OUT_WB_SEL, 2'b01);
            `assert(OUT_REG_WRITE_EN, 1'b1);

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

        IN_INSTRUCTION = 5'd30;
        IN_PC = 32'd70;
        IN_ALU_RESULT = 32'd80; 
        IN_DATA2 = 32'd50;  
        IN_IMMEDIATE = 32'd90; 
        IN_DATAMEMSEL = 1'b0;
        IN_READ_WRITE  = 4'd3;
        IN_WB_SEL = 2'b11;
        IN_REG_WRITE_EN = 1'b0;


        @(posedge CLK) begin
            
            // wait for write to happen.
            #3

            `assert(OUT_INSTRUCTION, 5'd10);
            `assert(OUT_PC, 32'd20);
            `assert(OUT_ALU_RESULT, 32'd30);
            `assert(OUT_DATA2, 32'd40);
            `assert(OUT_IMMEDIATE, 32'd50);
            `assert(OUT_DATAMEMSEL, 1'b1);
            `assert(OUT_READ_WRITE, 4'd1);
            `assert(OUT_WB_SEL, 2'b01);
            `assert(OUT_REG_WRITE_EN, 1'b1);

            $display("Test 03 : BUSYWAIT_1 TEST 1 Passed!");

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