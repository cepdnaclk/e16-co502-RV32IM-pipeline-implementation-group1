module adder_32bit(IN1, OUT);

    //declare ports
    input [31:0] IN1;
    output [31:0] OUT;

    //add the input values and assign to output
    //TODO: adding has a #1 delay
    assign #1 OUT = IN1 + 32'd4;

endmodule