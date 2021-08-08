module mux_4x1_32bit(IN0, IN1, IN2, IN3, OUT, SELECT);

    //declare the ports
    input [31:0] IN0, IN1, IN2, IN3;
    input [1:0] SELECT;
    output reg [31:0] OUT;

    //connect the relevent input to the output depending depending on the select
    // TODO: Add delay to mux
    // assign OUT = (SELECT == 2'b11) ? IN3 : (SELECT == 2'b10) ? IN2 : (SELECT == 2'b01) ? IN1 : IN0;

    always @ (*) begin
        case (SELECT)
            2'b11: OUT = IN3;
            2'b10: OUT = IN2;
            2'b01: OUT = IN1;
            default: OUT = IN0;
        endcase
    end

endmodule