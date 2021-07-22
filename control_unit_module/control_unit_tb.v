`include "../utils/macros.v"
`include "../utils/encodings.v"
`include "control_unit.v"

`define DECODE_DELAY #2

module control_unit_tb;
    
    reg [6:0] OPCODE;
    reg [2:0] FUNCT3;
    reg [6:0] FUNCT7;
    
    wire OP1SEL, OP2SEL, MEM_WRITE, MEM_READ, REG_WRITE_EN;
    wire [1:0] WB_SEL;
    wire [4:0] ALU_OP;
    wire [2:0] BRANCH_JUMP, IMM_SEL;
    
    control_unit my_control_unit(OPCODE, FUNCT3, FUNCT7, OP1SEL, OP2SEL, MEM_WRITE, MEM_READ, REG_WRITE_EN, WB_SEL, ALU_OP, BRANCH_JUMP, IMM_SEL);

    initial begin

        // LUI
        OPCODE = `LUI_OPCODE;
        FUNCT3 = 3'bxxx;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        // `assert(OP1SEL,1'bx);
        // `assert(OP2SEL,1'bx);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`IMM);
        // `assert(ALU_OP,5'bxxxxx);
        `assert(BRANCH_JUMP,`NO);
        `assert(IMM_SEL,`U_TYPE);
        $display("LUI test passed!");

        // JAL
        // JALR
        // BEQ
        // BNE
        // BLT
        // BGE
        // BLTU
        // BGEU
        // LB
        // LH
        // LW
        // LBU
        // LHU
        // SB
        // SH
        // SW
        // ADDI
        // SLTI
        // SLTIU
        // XORI
        // ORI
        // ANDI
        // SLLI
        // SRLI
        // SRAI
        // ADD
        // SUB
        // SLL
        // SLT
        // SLTU
        // XOR
        // SRL
        // SRA
        // OR
        // AND
        // MUL
        // MULH
        // MULHSU
        // MULHSU
        // DIV
        // DIVU
        // REM
        // REMU

    end

endmodule