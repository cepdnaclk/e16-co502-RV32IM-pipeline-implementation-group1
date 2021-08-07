module if_id_pipeline_reg(
    IN_INSTRUCTION, 
    IN_PC, 
    OUT_INSTRUCTION, 
    OUT_PC, 
    CLK, 
    RESET, 
    BUSYWAIT);

    //declare the ports
    input [31:0] IN_INSTRUCTION, IN_PC;
    input CLK, RESET, BUSYWAIT;
    output reg [31:0] OUT_INSTRUCTION, OUT_PC;

    //RESETTING output registers
    //TODO: set proper values in RESET operation -> change the RESET test in the testbench
    always @ (*) begin
        #1
        if (RESET) begin
            OUT_PC = 32'd0;
            OUT_INSTRUCTION = 32'd0;
        end
    end

    //Writing the input values to the output registers, 
    //when the RESET is low and when the CLOCK is at a positive edge and BUSYWAIT is low 
    always @(posedge CLK)
    begin
        #1
        if (!RESET & !BUSYWAIT) begin
            OUT_PC = IN_PC;
            OUT_INSTRUCTION = IN_INSTRUCTION;
        end
    end


endmodule