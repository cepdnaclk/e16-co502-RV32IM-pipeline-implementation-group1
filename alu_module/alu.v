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
                SLL_RESULT,
                SRL_RESULT,
                SUB_RESULT,
                SRA_RESULT,
                MUL_RESULT,
                MULHU_RESULT,
                MULHSU_RESULT,
                DIV_RESULT,
                DIVU_RESULT,
                REM_RESULT,
                REMU_RESULT;
    
    wire [63:0] MULH_RESULT;

    //  --> should add proper delays 
    assign #2 ADD_RESULT = DATA1 + DATA2;       // addition
    assign #2 SUB_RESULT = DATA1 - DATA2;       // Subtraction

    assign #2 SLT_RESULT = ($signed(DATA1) < $signed(DATA2)) ? 1'b1 : 1'b0;         // set less than
    assign #2 SLTU_RESULT = ($unsigned(DATA1) < $unsigned(DATA2)) ? 1'b1 : 1'b0;    // set less than unsigned
    
    assign #1 AND_RESULT = DATA1 & DATA2;       // bitwise logical AND
    assign #1 OR_RESULT = DATA1 | DATA2;        // bitwise logical OR
    assign #1 XOR_RESULT = DATA1 ^ DATA2;       // bitwise logical XOR
    assign #2 SLL_RESULT = DATA1 << DATA2;      // Logical Left Shift
    assign #2 SRL_RESULT = DATA1 >> DATA2;      // Logical Right Shift
    assign #2 SRA_RESULT = DATA1 >>> DATA2;     // Arithmetic Right shift
    
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
            `ADD: RESULT = ADD_RESULT; 
            `SUB: RESULT = SUB_RESULT; 
            `SLL: RESULT = SLL_RESULT; 
            `SLT: RESULT = SLT_RESULT; 
            `SLTU: RESULT = SLTU_RESULT; 
            `XOR: RESULT = XOR_RESULT; 
            `SRL: RESULT = SRL_RESULT; 
            `SRA: RESULT = SRA_RESULT; 
            `OR: RESULT = OR_RESULT; 
            `AND: RESULT = AND_RESULT; 
            `MUL: RESULT = MUL_RESULT; 
            `MULH: RESULT = MULH_RESULT[63:32]; 
            `MULHSU: RESULT = MULHU_RESULT; 
            `MULHU: RESULT = MULHSU_RESULT; 
            `DIV: RESULT = DIV_RESULT; 
            `DIVU: RESULT = DIVU_RESULT; 
            `REM : RESULT = REM_RESULT; 
            `REMU: RESULT = REMU_RESULT; 
                
            default:  RESULT = 0 ;  
                                
        endcase
    end

endmodule
