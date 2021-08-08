/****************************************
reg_file module
Name    : Perera G K B H
ENo     : E/16/276

*****************************************/

module reg_file(WRITE_DATA, DATA1, DATA2, WRITE_ADDRESS, DATA1_ADDRESS, DATA2_ADDRESS, WRITE_ENABLE, CLK, RESET);

    //create the 8x8 register array
    reg [31:0] REGISTER[0:31];

    //declaring ports
    input [31:0] WRITE_DATA;
    input [4:0] DATA1_ADDRESS, DATA2_ADDRESS, WRITE_ADDRESS;
    input WRITE_ENABLE, CLK, RESET;
    output [31:0] DATA1, DATA2;

    //variable to count the iterations in loops
    integer i;

    //reading the registers
    //this runs always when the register values changes or when the register outaddress changes
    assign #2 DATA1 = REGISTER[DATA1_ADDRESS];
    assign #2 DATA2 = REGISTER[DATA2_ADDRESS];

    //resetting the registers
    always @ (*) begin
        //if the reset = 1, then all the registers are set to 0
        if (RESET) begin  
            #2 for (i = 0; i < 32; i = i + 1)
                REGISTER[i] = 32'd0;
        end
    end

    //writting the values to a register
    //this runs only on positive clock edges
    always @ (posedge CLK) begin
        #1
        //if the write = 1 and reset = 0, the given register will be written with the given value
        // TODO: NOP support
        if (WRITE_ENABLE & !RESET & WRITE_ADDRESS != 0) begin
            REGISTER[WRITE_ADDRESS] = WRITE_DATA;
        end
    end

endmodule