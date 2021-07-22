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
        `assert(WB_SEL,`IMM_WB);
        // `assert(ALU_OP,5'bxxxxx);
        `assert(BRANCH_JUMP,`NO);
        `assert(IMM_SEL,`U_TYPE);
        $display("LUI test passed!");

        // AUIPC
        OPCODE = `AUIPC_OPCODE;
        FUNCT3 = 3'bxxx;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        `assert(OP1SEL,`PC);
        `assert(OP2SEL,`IMM);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(ALU_OP,`ADD);
        `assert(BRANCH_JUMP,`NO);
        `assert(IMM_SEL,`U_TYPE);
        $display("AUIPC test passed!");

        // JAL
        OPCODE = `JAL_OPCODE;
        FUNCT3 = 3'bxxx;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        `assert(OP1SEL,`PC);
        `assert(OP2SEL,`IMM);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`PC_4);
        `assert(ALU_OP,`ADD);
        `assert(BRANCH_JUMP,`J);
        `assert(IMM_SEL,`J_TYPE);
        $display("JAL test passed!");

        // JALR
        OPCODE = `JALR_OPCODE;
        FUNCT3 = 3'b000;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`IMM);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`PC_4);
        `assert(ALU_OP,`ADD);
        `assert(BRANCH_JUMP,`J);
        `assert(IMM_SEL,`I_SIGNED_TYPE);
        $display("JALR test passed!");

        // BEQ
        OPCODE = `B_TYPE_OPCODE;
        FUNCT3 = 3'b000;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        `assert(OP1SEL,`PC);
        `assert(OP2SEL,`IMM);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_0);
        // `assert(WB_SEL,`PC_4);
        `assert(ALU_OP,`ADD);
        `assert(BRANCH_JUMP,`BEQ);
        `assert(IMM_SEL,`B_TYPE);
        $display("BEQ test passed!");

        // BNE
        OPCODE = `B_TYPE_OPCODE;
        FUNCT3 = 3'b001;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        `assert(OP1SEL,`PC);
        `assert(OP2SEL,`IMM);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_0);
        // `assert(WB_SEL,`PC_4);
        `assert(ALU_OP,`ADD);
        `assert(BRANCH_JUMP,`BNE);
        `assert(IMM_SEL,`B_TYPE);
        $display("BNE test passed!");

        // BLT
        OPCODE = `B_TYPE_OPCODE;
        FUNCT3 = 3'b100;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        `assert(OP1SEL,`PC);
        `assert(OP2SEL,`IMM);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_0);
        // `assert(WB_SEL,`PC_4);
        `assert(ALU_OP,`ADD);
        `assert(BRANCH_JUMP,`BLT);
        `assert(IMM_SEL,`B_TYPE);
        $display("BLT test passed!");

        // BGE
        OPCODE = `B_TYPE_OPCODE;
        FUNCT3 = 3'b101;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        `assert(OP1SEL,`PC);
        `assert(OP2SEL,`IMM);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_0);
        // `assert(WB_SEL,`PC_4);
        `assert(ALU_OP,`ADD);
        `assert(BRANCH_JUMP,`BGE);
        `assert(IMM_SEL,`B_TYPE);
        $display("BGE test passed!");

        // BLTU
        OPCODE = `B_TYPE_OPCODE;
        FUNCT3 = 3'b110;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        `assert(OP1SEL,`PC);
        `assert(OP2SEL,`IMM);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_0);
        // `assert(WB_SEL,`PC_4);
        `assert(ALU_OP,`ADD);
        `assert(BRANCH_JUMP,`BLTU);
        `assert(IMM_SEL,`B_TYPE);
        $display("BLTU test passed!");

        // BGEU
        OPCODE = `B_TYPE_OPCODE;
        FUNCT3 = 3'b111;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        `assert(OP1SEL,`PC);
        `assert(OP2SEL,`IMM);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_0);
        // `assert(WB_SEL,`PC_4);
        `assert(ALU_OP,`ADD);
        `assert(BRANCH_JUMP,`BGEU);
        `assert(IMM_SEL,`B_TYPE);
        $display("BGEU test passed!");

        // TODO: Need to design the load and store
        // LB
        // LH
        // LW
        // LBU
        // LHU
        // SB
        // SH
        // SW

        // ADDI
        OPCODE = `I_TYPE_OPCODE;
        FUNCT3 = 3'b000;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`IMM);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(ALU_OP,`ADD);
        `assert(BRANCH_JUMP,`NO);
        `assert(IMM_SEL,`I_SIGNED_TYPE);
        $display("ADDI test passed!");

        // SLTI
        OPCODE = `I_TYPE_OPCODE;
        FUNCT3 = 3'b010;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`IMM);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(ALU_OP,`SLT);
        `assert(BRANCH_JUMP,`NO);
        `assert(IMM_SEL,`I_SIGNED_TYPE);
        $display("SLTI test passed!");
        
        // SLTIU
        OPCODE = `I_TYPE_OPCODE;
        FUNCT3 = 3'b011;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`IMM);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(ALU_OP,`SLTU);
        `assert(BRANCH_JUMP,`NO);
        `assert(IMM_SEL,`I_UNSIGNED_TYPE);
        $display("SLTIU test passed!");

        // XORI
        OPCODE = `I_TYPE_OPCODE;
        FUNCT3 = 3'b100;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`IMM);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(ALU_OP,`XOR);
        `assert(BRANCH_JUMP,`NO);
        `assert(IMM_SEL,`I_SIGNED_TYPE);
        $display("XORI test passed!");

        // ORI
        OPCODE = `I_TYPE_OPCODE;
        FUNCT3 = 3'b110;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`IMM);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(ALU_OP,`OR);
        `assert(BRANCH_JUMP,`NO);
        `assert(IMM_SEL,`I_SIGNED_TYPE);
        $display("ORI test passed!");

        // ANDI
        OPCODE = `I_TYPE_OPCODE;
        FUNCT3 = 3'b111;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`IMM);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(ALU_OP,`AND);
        `assert(BRANCH_JUMP,`NO);
        `assert(IMM_SEL,`I_SIGNED_TYPE);
        $display("ANDI test passed!");
        
        // SLLI
        OPCODE = `I_TYPE_OPCODE;
        FUNCT3 = 3'b001;
        FUNCT7 = 7'b0000000;
        `DECODE_DELAY
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`IMM);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(ALU_OP,`SLL);
        `assert(BRANCH_JUMP,`NO);
        `assert(IMM_SEL,`I_SHIFT_TYPE);
        $display("SLLI test passed!");

        // SRLI
        OPCODE = `I_TYPE_OPCODE;
        FUNCT3 = 3'b101;
        FUNCT7 = 7'b0000000;
        `DECODE_DELAY
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`IMM);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(ALU_OP,`SRL);
        `assert(BRANCH_JUMP,`NO);
        `assert(IMM_SEL,`I_SHIFT_TYPE);
        $display("SRLI test passed!");

        // SRAI
        OPCODE = `I_TYPE_OPCODE;
        FUNCT3 = 3'b101;
        FUNCT7 = 7'b0100000;
        `DECODE_DELAY
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`IMM);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(ALU_OP,`SRA);
        `assert(BRANCH_JUMP,`NO);
        `assert(IMM_SEL,`I_SHIFT_TYPE);
        $display("SRAI test passed!");


        // ADD
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b000;
        FUNCT7 = 7'b0000000;
        `DECODE_DELAY
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(ALU_OP,`ADD);
        `assert(BRANCH_JUMP,`NO);
        // `assert(IMM_SEL,`I_SIGNED_TYPE);
        $display("ADD test passed!");

        // SUB
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b000;
        FUNCT7 = 7'b0100000;
        `DECODE_DELAY
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(ALU_OP,`SUB);
        `assert(BRANCH_JUMP,`NO);
        // `assert(IMM_SEL,`I_SIGNED_TYPE);
        $display("SUB test passed!");

        // SLL
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b001;
        FUNCT7 = 7'b0000000;
        `DECODE_DELAY
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(ALU_OP,`SLL);
        `assert(BRANCH_JUMP,`NO);
        // `assert(IMM_SEL,`I_SIGNED_TYPE);
        $display("SLL test passed!");

        // SLT
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b010;
        FUNCT7 = 7'b0000000;
        `DECODE_DELAY
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(ALU_OP,`SLT);
        `assert(BRANCH_JUMP,`NO);
        // `assert(IMM_SEL,`I_SIGNED_TYPE);
        $display("SLT test passed!");

        // SLTU
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b011;
        FUNCT7 = 7'b0000000;
        `DECODE_DELAY
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(ALU_OP,`SLTU);
        `assert(BRANCH_JUMP,`NO);
        // `assert(IMM_SEL,`I_SIGNED_TYPE);
        $display("SLTU test passed!");

        // XOR
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b100;
        FUNCT7 = 7'b0000000;
        `DECODE_DELAY
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(ALU_OP,`XOR);
        `assert(BRANCH_JUMP,`NO);
        // `assert(IMM_SEL,`I_SIGNED_TYPE);
        $display("XOR test passed!");

        // SRL
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b101;
        FUNCT7 = 7'b0000000;
        `DECODE_DELAY
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(ALU_OP,`SRL);
        `assert(BRANCH_JUMP,`NO);
        // `assert(IMM_SEL,`I_SIGNED_TYPE);
        $display("SRL test passed!");

        // SRA
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b101;
        FUNCT7 = 7'b0100000;
        `DECODE_DELAY
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(ALU_OP,`SRA);
        `assert(BRANCH_JUMP,`NO);
        // `assert(IMM_SEL,`I_SIGNED_TYPE);
        $display("SRA test passed!");

        // OR
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b110;
        FUNCT7 = 7'b0000000;
        `DECODE_DELAY
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(ALU_OP,`OR);
        `assert(BRANCH_JUMP,`NO);
        // `assert(IMM_SEL,`I_SIGNED_TYPE);
        $display("OR test passed!");

        // AND
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b111;
        FUNCT7 = 7'b0000000;
        `DECODE_DELAY
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(ALU_OP,`AND);
        `assert(BRANCH_JUMP,`NO);
        // `assert(IMM_SEL,`I_SIGNED_TYPE);
        $display("AND test passed!");

        // MUL
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b000;
        FUNCT7 = 7'b0000001;
        `DECODE_DELAY
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(ALU_OP,`MUL);
        `assert(BRANCH_JUMP,`NO);
        // `assert(IMM_SEL,`I_SIGNED_TYPE);
        $display("MUL test passed!");

        // MULH
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b001;
        FUNCT7 = 7'b0000001;
        `DECODE_DELAY
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(ALU_OP,`MULH);
        `assert(BRANCH_JUMP,`NO);
        // `assert(IMM_SEL,`I_SIGNED_TYPE);
        $display("MULH test passed!");

        // MULHSU
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b010;
        FUNCT7 = 7'b0000001;
        `DECODE_DELAY
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(ALU_OP,`MULHSU);
        `assert(BRANCH_JUMP,`NO);
        // `assert(IMM_SEL,`I_SIGNED_TYPE);
        $display("MULHSU test passed!");

        // MULHU
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b011;
        FUNCT7 = 7'b0000001;
        `DECODE_DELAY
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(ALU_OP,`MULHU);
        `assert(BRANCH_JUMP,`NO);
        // `assert(IMM_SEL,`I_SIGNED_TYPE);
        $display("MULHU test passed!");

        // DIV
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b100;
        FUNCT7 = 7'b0000001;
        `DECODE_DELAY
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(ALU_OP,`DIV);
        `assert(BRANCH_JUMP,`NO);
        // `assert(IMM_SEL,`I_SIGNED_TYPE);
        $display("DIV test passed!");

        // DIVU
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b101;
        FUNCT7 = 7'b0000001;
        `DECODE_DELAY
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(ALU_OP,`DIVU);
        `assert(BRANCH_JUMP,`NO);
        // `assert(IMM_SEL,`I_SIGNED_TYPE);
        $display("DIVU test passed!");

        // REM
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b110;
        FUNCT7 = 7'b0000001;
        `DECODE_DELAY
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(ALU_OP,`REM);
        `assert(BRANCH_JUMP,`NO);
        // `assert(IMM_SEL,`I_SIGNED_TYPE);
        $display("REM test passed!");

        // REMU
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b111;
        FUNCT7 = 7'b0000001;
        `DECODE_DELAY
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(ALU_OP,`REMU);
        `assert(BRANCH_JUMP,`NO);
        // `assert(IMM_SEL,`I_SIGNED_TYPE);
        $display("REMU test passed!");

    end

endmodule