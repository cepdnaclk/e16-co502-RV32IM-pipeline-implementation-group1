
`include "../../utils/macros.v" 
`include "if_id_pipeline_reg.v"

module if_id_pipeline_reg_tb;
    
    reg [31:0] IN_INSTRUCTION, IN_PC;

    reg CLK, RESET, BUSYWAIT;

    wire [31:0] OUT_INSTRUCTION, OUT_PC;


    if_id_pipeline_reg my_if_id_pipeline_reg( IN_INSTRUCTION, IN_PC, OUT_INSTRUCTION, OUT_PC, CLK, RESET, BUSYWAIT);

    initial begin
        
        CLK = 1'b0;
        RESET = 1'b0;
        BUSYWAIT = 1'b0;

        // set arbitrary values to inputs
        IN_INSTRUCTION = 32'd10;
        IN_PC = 32'd20;

        $dumpfile("if_id_pipeline_reg.vcd");
        $dumpvars(0, if_id_pipeline_reg_tb);

        /*
            Test 01 : RESET TEST
        */

        #1
        RESET = 1'b1;

        #5
        RESET = 1'b0;

        `assert(OUT_INSTRUCTION, 32'd0);
        `assert(OUT_PC, 32'd0);

        $display("TEST 01 : RESET TEST Passed!");

        /* Test 01 ends here! */

        /*
            Test 02 : BUSYWAIT TEST 0
            Module should be able to write to Pipeline register when BUSYWAIT is set to 0
        */
        #1
        BUSYWAIT = 1'b0;

        IN_INSTRUCTION = 32'd10;
        IN_PC = 32'd20;
 
        @(posedge CLK) begin
            
            // wait for write to happen.
            #3

            `assert(OUT_INSTRUCTION, 32'd10);
            `assert(OUT_PC, 32'd20);

            $display("TEST 02 : BUSYWAIT_0 TEST Passed!");

        end

        /* Test 02 ends here! */
        
        /*
            Test 03 : BUSYWAIT TEST 1
            Module should be not be able to write to Pipeline register when BUSYWAIT is set to 1
        */
        
        // set BUSYWAIT to 1
        #1
        BUSYWAIT = 1'b1;

        IN_INSTRUCTION = 32'd60;
        IN_PC = 32'd70;

        @(posedge CLK) begin
            
            // wait for write to happen.
            #3

            `assert(OUT_INSTRUCTION, 32'd10);
            `assert(OUT_PC, 32'd20);

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