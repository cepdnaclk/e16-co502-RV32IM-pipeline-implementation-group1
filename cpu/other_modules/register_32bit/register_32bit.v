module register_32bit (IN, OUT, RESET, CLK, BUSYWAIT);

    //declare the ports
    input [31:0] IN;
    input RESET, CLK, BUSYWAIT;
    output reg [31:0] OUT;

    //reset the register to -4 whenever the reset signal changes from low to high
    //resetting has a #1 delay
    always @ (RESET) begin
        if (RESET) #1 OUT = -32'd4;
    end

    //write the input value to the register when the reset is low and when the clock is at a positive edge and busywait is low 
    //writting to the register has a #1 delay
    always @ (posedge CLK) begin
        #1
        if (!RESET & !BUSYWAIT)  OUT = IN;
    end

endmodule