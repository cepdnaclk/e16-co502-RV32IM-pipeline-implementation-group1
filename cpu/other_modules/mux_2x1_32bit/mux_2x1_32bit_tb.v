`include "mux_2x1_32bit.v"
module mux_2x1_32bit_tb;

reg [31:0] IN0, IN1;
reg SELECT;

wire [31:0] OUT;

mux_2x1_32bit mux(IN0, IN1, OUT, SELECT);

initial begin
    $monitor("Time :%t\tIN0 : %h\tIN1 : %h\tSELECT : %b\tOUT : %h", $time,IN0, IN1, SELECT, OUT);

    IN0 = 32'h00000000;
    IN1 = 32'h00000001;
    SELECT = 1'b0;
    #1;
    SELECT = 1'b1;
    #1;
    SELECT = 1'bx;
end

endmodule