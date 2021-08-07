
`include "../utils/macros.v" 
`include "reg_file.v"

module reg_file_tb;

    reg CLK, RESET, WRITE_ENABLE;
    reg [31:0] WRITE_DATA;
    wire [31:0] DATA1,DATA2;
    reg [4:0] DATA1_ADDRESS, DATA2_ADDRESS, WRITE_ADDRESS;

    integer j;

    reg_file my_reg_file(WRITE_DATA, DATA1, DATA2, WRITE_ADDRESS, DATA1_ADDRESS, DATA2_ADDRESS, WRITE_ENABLE, CLK, RESET);

    initial begin
        CLK = 1'b0;
        RESET = 1'b0;
        WRITE_DATA = 32'd0;
        DATA1_ADDRESS = 5'd0;
        DATA2_ADDRESS = 5'd0;
        WRITE_ADDRESS = 5'd0;
        WRITE_ENABLE = 0;

        $dumpfile("reg_file_wavedata.vcd");
        $dumpvars(0, reg_file_tb);
        // for(j = 0; j < 32; j = j + 1) $dumpvars(0, my_reg_file.REGISTER[j]);


        #1
        RESET = 1'b1;

        #5
        RESET = 1'b0;

        /* 
            TEST 1 starts here!

            Regfile module should able to write to specific register. 
            WRITE 10 to reg 1
        */
            WRITE_ADDRESS = 5'd1;
            WRITE_DATA = 32'd10;
            WRITE_ENABLE = 1'b1;

            @(posedge CLK) begin
                // wait for write to happen.
                #3;
                // read value of the address
                DATA1_ADDRESS = 5'd1;
                // wait for read to happen and check value
                #3;
                `assert(DATA1, 32'd10);
                $display("TEST 1 Passed!");

            end
        /* TEST 1 ends here! */

        /* 
            TEST 2 starts here!

            Regfile module should not be able to write to R0. 
            WRITE 10 to reg 1
        */
            WRITE_ADDRESS = 5'd0;
            WRITE_DATA = 32'd10;
            WRITE_ENABLE = 1'b1;

            @(posedge CLK) begin
                // wait for write to happen.
                #3;
                // read value of the address
                DATA1_ADDRESS = 5'd0;
                // wait for read to happen and check value
                #3;
                `assert(DATA1, 32'd0);
                $display("TEST 2 Passed!");

            end
        /* TEST 1 ends here! */

        #500
        $finish;
    end

    // clock genaration.
    always begin
        #4 CLK = ~CLK;
    end

endmodule