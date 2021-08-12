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
    always @ (*) begin
        if (RESET) begin
            #1;
            OUT_PC = 32'd0;
            OUT_INSTRUCTION = 32'd0;
        end
    end

    //Writing the input values to the output registers, 
    //when the RESET is low and when the CLOCK is at a positive edge and BUSYWAIT is low 
    always @(posedge CLK)
    begin
        #0
        if (!RESET & !BUSYWAIT) begin
            OUT_PC <= #1 IN_PC;
            OUT_INSTRUCTION <= #1 IN_INSTRUCTION;
        end
    end


endmodule