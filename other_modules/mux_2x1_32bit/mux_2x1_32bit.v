module mux_2x1_32bit(IN0, IN1, OUT, SELECT);

    //declare the ports
    input [31:0] IN0, IN1;
    input SELECT;
    output [31:0] OUT;

    //connect the relevent input to the output depending depending on the select
    // TODO: Add delay to mux
    assign OUT = SELECT ? IN1 : IN0;
    
    // always @ (IN0, IN1, SELECT) begin
    //     if (SELECT)
    //         OUT = IN1;
    //     else 
    //         OUT = IN0;
    // end

endmodule