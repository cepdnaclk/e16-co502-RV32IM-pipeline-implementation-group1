`timescale 1ns/100ps

module alu(DATA1, DATA2, RESULT, SELECT);

    // port declaration
    input [31:0] DATA1, DATA2;
    input [4:0] SELECT;     // func3: 3bits + func7[0] + func7[5]
    output reg [31:0] RESULT;
    

    // alu intermediate results
    wire [31:0] ADD_RESULT,
                SLT_RESULT,
                SLTU_RESULT,
                AND_RESULT,
                OR_RESULT,
                XOR_RESULT,
                SLL_RESSULT,
                SRL_RESULT,
                SUB_RESULT,
                SRA_RESULT,
                MUL_RESULT,
                MULH_RESULT,
                MULHU_RESULT,
                MULHSU_RESULT,
                DIV_RESULT,
                DIVU_RESULT,
                REM_RESULT,
                REMU_RESULT;

    //  --> should add proper delays 
    assign #2 ADD_RESULT = DATA1 + DATA2;       // addition
    assign #2 SUB_RESULT = DATA1 - DATA2;       // Subtraction

    assign #2 SLT_RESULT = ($signed(DATA1) < $signed(DATA2)) ? 1'b1 : 1'b0;         // set less than
    assign #2 SLTU_RESULT = ($unsigned(DATA1) < $unsigned(DATA2)) ? 1'b1 : 1'b0;    // set less than unsigned
    
    assign #1 AND_RESULT = DATA1 & DATA2;       // bitwise logical AND
    assign #1 OR_RESULT = DATA1 | DATA2;        // bitwise logical OR
    assign #1 XOR_RESULT = DATA1 ^ DATA2;       // bitwise logical XOR
    assign #1 SLL_RESULT = DATA1 << DATA2;      // Logical Left Shift
    assign #1 SRL_RESULT = DATA1 >> DATA2;      // Logical Right Shift
    assign #1 SRA_RESULT = DATA1 >>> DATA2;     // Arithmetic Right shift
    
    // --> upper 32 bit
    assign #3 MUL_RESULT = DATA1 * DATA2;       // Multiplication
    assign #3 MULH_RESULT = DATA1 * DATA2;      // Multiplication High Signed x Signed
    assign #3 MULHU_RESULT = $unsigned(DATA1) * $unsigned(DATA2);     // Multiplication High Unsigned x Unsigned
    assign #3 MULHSU_RESULT = $signed(DATA1) * $unsigned(DATA2);     // Multiplication High Signed x UnSigned
    
    // DIV --> should round towards zero 
    assign #3 DIV_RESULT = DATA1 / DATA2;                           // Division
    assign #3 DIVU_RESULT = $unsigned(DATA1) / $unsigned(DATA2);    // Division Unsigned
    assign #3 REM_RESULT = DATA1 % DATA2;       // Remainder
    assign #3 REMU_RESULT = DATA1 % DATA2;      // Remainder Unsigned

    always @(*)
    begin
 
        case(SELECT)
            5'b00000: RESULT = ADD_RESULT; 
            5'b00010: RESULT = SUB_RESULT; 
            5'b00100: RESULT = SLL_RESULT; 
            5'b01000: RESULT = SLT_RESULT; 
            5'b01100: RESULT = SLTU_RESULT; 
            5'b10000: RESULT = XOR_RESULT; 
            5'b10100: RESULT = SRL_RESULT; 
            5'b10110: RESULT = SRA_RESULT; 
            5'b11000: RESULT = OR_RESULT; 
            5'b11100: RESULT = AND_RESULT; 
            5'b00001: RESULT = MUL_RESULT; 
            5'b00101: RESULT = MULH_RESULT; 
            5'b01001: RESULT = MULHU_RESULT; 
            5'b01101: RESULT = MULHSU_RESULT; 
            5'b10001: RESULT = DIV_RESULT; 
            5'b10101: RESULT = DIVU_RESULT; 
            5'b11001: RESULT = REM_RESULT; 
            5'b11101: RESULT = REMU_RESULT; 
                
            default:  RESULT = 0 ;  
                                
        endcase
    end

endmodule
