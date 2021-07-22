
`include "../utils/macros.v" 
`include "immediate_generate.v"

module immediate_generate_tb;

    reg [24:0] IN;            // instruction[31:7] -> 24 bits
    reg [2:0] IMM_SEL;        // immediate select op
    wire [31:0] OUT;      // sign extended 32-bit val

   
    immediate_generate my_immediate_generate(IN, OUT, IMM_SEL);

    initial begin
        
        $dumpfile("immediate_generate.vcd");
        $dumpvars(0, immediate_generate_tb);

        #10
        // u type test
        IN = 25'b10110000001110001000_10100; 
        IMM_SEL = 3'b000;
        #1
        $display("U = %b", OUT);
        `assert(OUT, 32'b10110000001110001000_000000000000);
        // output : 10110000001110001000_000000000000

        #5
        // J type test
        IN = 25'b1_0001101110_1_01001110_01010;
        IMM_SEL = 3'b001;
        #1
        $display("J = %b", OUT);
        `assert(OUT, 32'b111111111111_01001110_1_0001101110);
        // output: 111111111111_01001110_1_00011011100

        #5
        // B type test
        IN = 25'b1_010000_11011_10101_110_0101_0;
        IMM_SEL = 3'b010;
        #1
        $display("B = %b", OUT);
        `assert(OUT, 32'b11111111111111111111_0_010000_0101_0);
        // output:11111111111111111111_0_010000_0101_0

        #5
        // I type test
        IN = 25'b101001001001_10100_010_00101;
        IMM_SEL = 3'b011;
        #1
        $display("I = %b", OUT);
        `assert(OUT, 32'b11111111111111111111_101001001001);
        //output : 11111111111111111111_101001001001

        #5
        // IU type test
        IN = 25'b101001001001_10100_010_00101;
        IMM_SEL = 3'b100;
        #1
        $display("IU = %b", OUT);
        `assert(OUT, 32'b00000000000000000000_101001001001);
        //output : 00000000000000000000_101001001001

        #5
        // S type test
        IN = 25'b1010010_01001_10100_010_00101;
        IMM_SEL = 3'b101;
        //output : 11111111111111111111_1010010_00101
        #1
        $display("S = %b", OUT);
        `assert(OUT, 32'b11111111111111111111_1010010_00101);

        #5
        // SFT type test
        IN = 25'b1010010_01001_10100_010_00101;
        IMM_SEL = 3'b110;
        #1
        $display("SFT = %b", OUT);
        // output: 0000000000000000000000000000_01001
        `assert(OUT, 32'b0000000000000000000000000000_01001);
  
        $display("TEST 1 Passed!");

        $finish;
    end

endmodule

// TODO: something wrong