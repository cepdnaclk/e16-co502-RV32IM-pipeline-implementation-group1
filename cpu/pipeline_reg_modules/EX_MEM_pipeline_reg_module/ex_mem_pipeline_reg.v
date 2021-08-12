module ex_mem_pipeline_reg(
    IN_INSTRUCTION, // INSTRUCTION [11:7]
    IN_PC,
    IN_ALU_RESULT, 
    IN_DATA2, 
    IN_IMMEDIATE,
    IN_READ_WRITE,
    IN_WB_SEL,
    IN_REG_WRITE_EN,
    OUT_INSTRUCTION,
    OUT_PC,
    OUT_ALU_RESULT,
    OUT_DATA2,
    OUT_IMMEDIATE, 
    OUT_READ_WRITE,
    OUT_WB_SEL,
    OUT_REG_WRITE_EN,
    CLK, 
    RESET,
    BUSYWAIT);

    //declare the ports
    input [4:0] IN_INSTRUCTION;
    input [1:0] IN_WB_SEL;
    input [3:0] IN_READ_WRITE;
    
    input [31:0] IN_PC,
            IN_ALU_RESULT,
            IN_DATA2,
            IN_IMMEDIATE;   
                
    input IN_REG_WRITE_EN,
        CLK, 
        RESET, 
        BUSYWAIT;

    output reg [4:0] OUT_INSTRUCTION;
    output reg [1:0] OUT_WB_SEL;
    output reg [3:0] OUT_READ_WRITE;

    output reg [31:0] OUT_PC,
                    OUT_ALU_RESULT,
                    OUT_DATA2,
                    OUT_IMMEDIATE; 

    output reg OUT_REG_WRITE_EN;


    //RESETTING output registers
    always @ (*) begin
        if (RESET) begin
            #1;
            OUT_INSTRUCTION = 5'd0;
            OUT_PC = 32'd0;
            OUT_ALU_RESULT = 32'd0;
            OUT_DATA2 = 32'd0;
            OUT_IMMEDIATE =  32'd0;
            OUT_READ_WRITE = 4'd0;
            OUT_WB_SEL = 2'b0;
            OUT_REG_WRITE_EN = 1'b0;
        end
    end

    //Writing the input values to the output registers, 
    //when the RESET is low and when the CLOCK is at a positive edge and BUSYWAIT is low 
    always @(posedge CLK)
    begin
        #0
        if (!RESET & !BUSYWAIT) begin
            OUT_INSTRUCTION <= #1 IN_INSTRUCTION;
            OUT_PC <= #1 IN_PC;
            OUT_ALU_RESULT <= #1 IN_ALU_RESULT;
            OUT_DATA2 <= #1 IN_DATA2;
            OUT_IMMEDIATE <= #1  IN_IMMEDIATE;
            OUT_READ_WRITE <= #1 IN_READ_WRITE;
            OUT_WB_SEL <= #1 IN_WB_SEL;
            OUT_REG_WRITE_EN <= #1 IN_REG_WRITE_EN;
        end
    end

endmodule