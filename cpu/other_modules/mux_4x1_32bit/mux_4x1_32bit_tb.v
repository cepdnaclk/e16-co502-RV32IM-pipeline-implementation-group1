`include "mux_4x1_32bit.v"
module mux_4x1_32bit_tb;

reg [31:0] IN0, IN1, IN2, IN3;
reg [1:0] SELECT;

wire [31:0] OUT;

mux_4x1_32bit mux(IN0, IN1, IN2, IN3, OUT, SELECT);

initial begin
    $monitor("Time :%t\tIN0 : %h\tIN1 : %h\tIN2 : %h\tIN3 : %h\tSELECT : %b\tOUT : %h", $time,IN0, IN1, IN2, IN3, SELECT, OUT);

    IN0 = 32'h00000000;
    IN1 = 32'h00000001;
    IN2 = 32'h00000010;
    IN3 = 32'h00000011;
    SELECT = 2'b00;
    #1;
    SELECT = 2'b01;
    #1;
    SELECT = 2'b10;
    #1;
    SELECT = 2'b11;
    #1;
    SELECT = 2'bxx;
    #1;
    SELECT = 2'bx0;
end

endmodule