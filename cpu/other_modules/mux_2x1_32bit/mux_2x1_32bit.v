module mux_2x1_32bit(IN0, IN1, OUT, SELECT);

    //declare the ports
    input [31:0] IN0, IN1;
    input SELECT;
    output reg [31:0] OUT;

    //connect the relevent input to the output depending depending on the select
    // TODO: Add delay to mux
    // assign OUT = (SELECT==1'b1) ? IN1 : IN0;
    
    always @ (*) begin
        case (SELECT)
            1'b1: OUT = IN1;
            default: OUT = IN0;
        endcase
    end

endmodule