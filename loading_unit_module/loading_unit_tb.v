`include "loading_unit.v"
`include "../utils/encodings.v"
`include "../utils/macros.v"

`define LOADING_DELAY #1

module loading_unit_tb;

reg [31:0] DATA_IN;
wire [31:0] DATA_OUT;
reg [2:0] LOAD_SEL;

loading_unit my_loading_unit(DATA_IN, DATA_OUT, LOAD_SEL);

initial begin
    $dumpfile("loading_file_wavedata.vcd");
    $dumpvars(0, loading_unit_tb);
    $display();

    // Test 1
    DATA_IN = 32'hABCD1234;
    LOAD_SEL = `LB;
    `LOADING_DELAY;
    #0;
    `assert(DATA_OUT, 32'hFFFFFFAB);
    $display("Test 1    : Test for LB    : Test Passed!");

    // Test 2
    DATA_IN = 32'hABCD1234;
    LOAD_SEL = `LH;
    `LOADING_DELAY;
    #0;
    `assert(DATA_OUT, 32'hFFFFABCD);
    $display("Test 2    : Test for LH    : Test Passed!");

    // Test 3
    DATA_IN = 32'hABCD1234;
    LOAD_SEL = `LW;
    `LOADING_DELAY;
    #0;
    `assert(DATA_OUT, 32'hABCD1234);
    $display("Test 3    : Test for LW    : Test Passed!");

    // Test 4
    DATA_IN = 32'hABCD1234;
    LOAD_SEL = `LBU;
    `LOADING_DELAY;
    #0;
    `assert(DATA_OUT, 32'h000000AB);
    $display("Test 4    : Test for LBU    : Test Passed!");

    // Test 5
    DATA_IN = 32'hABCD1234;
    LOAD_SEL = `LHU;
    `LOADING_DELAY;
    #0;
    `assert(DATA_OUT, 32'h0000ABCD);
    $display("Test 5    : Test for LHU    : Test Passed!");

    $display();
    $display("All tests passed!");

    $finish;
end
    
endmodule