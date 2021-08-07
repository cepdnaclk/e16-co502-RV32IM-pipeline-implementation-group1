`include "../utils/macros.v"
`include "../utils/encodings.v"
`include "control_unit.v"

`define DECODE_DELAY #2

module control_unit_tb;
    
    reg [6:0] OPCODE;
    reg [2:0] FUNCT3;
    reg [6:0] FUNCT7;
    
    wire OP1SEL, OP2SEL, REG_WRITE_EN;
    wire [1:0] WB_SEL;
    wire [4:0] ALU_OP;
    wire [2:0] BRANCH_JUMP, IMM_SEL;
    wire [3:0] READ_WRITE;
    
    control_unit my_control_unit(OPCODE, FUNCT3, FUNCT7, OP1SEL, OP2SEL, REG_WRITE_EN, WB_SEL, ALU_OP, BRANCH_JUMP, IMM_SEL, READ_WRITE);

    initial begin

        // LUI
        $display("Test 1 : LUI Control Signal Test");
        OPCODE = `LUI_OPCODE;
        FUNCT3 = 3'bxxx;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `assert(IMM_SEL,`U_TYPE);
        // `assert(OP1SEL,1'bx);
        // `assert(OP2SEL,1'bx);
        // `assert(ALU_OP,5'bxxxxx);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`IMM_WB);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("LUI test passed!\n");

        // AUIPC
        $display("Test 2 : AUIPC Control Signal Test");
        OPCODE = `AUIPC_OPCODE;
        FUNCT3 = 3'bxxx;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `assert(IMM_SEL,`U_TYPE);
        `assert(OP1SEL,`PC);
        `assert(OP2SEL,`IMM);
        `assert(ALU_OP,`ADD);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("AUIPC test passed!\n");

        // JAL
        $display("Test 3 : JAL Control Signal Test");
        OPCODE = `JAL_OPCODE;
        FUNCT3 = 3'bxxx;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `assert(IMM_SEL,`J_TYPE);
        `assert(OP1SEL,`PC);
        `assert(OP2SEL,`IMM);
        `assert(ALU_OP,`ADD);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`PC_4);
        `assert(BRANCH_JUMP,`J);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("JAL test passed!\n");

        // JALR
        $display("Test 4 : JALR Control Signal Test");
        OPCODE = `JALR_OPCODE;
        FUNCT3 = 3'b000;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `assert(IMM_SEL,`I_SIGNED_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`IMM);
        `assert(ALU_OP,`ADD);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`PC_4);
        `assert(BRANCH_JUMP,`J);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("JALR test passed!\n");

        // BEQ
        $display("Test 5 : BEQ Control Signal Test");
        OPCODE = `B_TYPE_OPCODE;
        FUNCT3 = 3'b000;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `assert(IMM_SEL,`B_TYPE);
        `assert(OP1SEL,`PC);
        `assert(OP2SEL,`IMM);
        `assert(ALU_OP,`ADD);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_0);
        // `assert(WB_SEL,`PC_4);
        `assert(BRANCH_JUMP,`BEQ);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("BEQ test passed!\n");

        // BNE
        $display("Test 6 : BNE Control Signal Test");
        OPCODE = `B_TYPE_OPCODE;
        FUNCT3 = 3'b001;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `assert(IMM_SEL,`B_TYPE);
        `assert(OP1SEL,`PC);
        `assert(OP2SEL,`IMM);
        `assert(ALU_OP,`ADD);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_0);
        // `assert(WB_SEL,`PC_4);
        `assert(BRANCH_JUMP,`BNE);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("BNE test passed!\n");

        // BLT
        $display("Test 7 : BLT Control Signal Test");
        OPCODE = `B_TYPE_OPCODE;
        FUNCT3 = 3'b100;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `assert(IMM_SEL,`B_TYPE);
        `assert(OP1SEL,`PC);
        `assert(OP2SEL,`IMM);
        `assert(ALU_OP,`ADD);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_0);
        // `assert(WB_SEL,`PC_4);
        `assert(BRANCH_JUMP,`BLT);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("BLT test passed!\n");

        // BGE
        $display("Test 8 : BGE Control Signal Test");
        OPCODE = `B_TYPE_OPCODE;
        FUNCT3 = 3'b101;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `assert(IMM_SEL,`B_TYPE);
        `assert(OP1SEL,`PC);
        `assert(OP2SEL,`IMM);
        `assert(ALU_OP,`ADD);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_0);
        // `assert(WB_SEL,`PC_4);
        `assert(BRANCH_JUMP,`BGE);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("BGE test passed!\n");

        // BLTU
        $display("Test 9 : BLTU Control Signal Test");
        OPCODE = `B_TYPE_OPCODE;
        FUNCT3 = 3'b110;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `assert(IMM_SEL,`B_TYPE);
        `assert(OP1SEL,`PC);
        `assert(OP2SEL,`IMM);
        `assert(ALU_OP,`ADD);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_0);
        // `assert(WB_SEL,`PC_4);
        `assert(BRANCH_JUMP,`BLTU);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("BLTU test passed!\n");

        // BGEU
        $display("Test 10 : BGEU Control Signal Test");
        OPCODE = `B_TYPE_OPCODE;
        FUNCT3 = 3'b111;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `assert(IMM_SEL,`B_TYPE);
        `assert(OP1SEL,`PC);
        `assert(OP2SEL,`IMM);
        `assert(ALU_OP,`ADD);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_0);
        // `assert(WB_SEL,`PC_4);
        `assert(BRANCH_JUMP,`BGEU);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("BGEU test passed!\n");

        // LB
        $display("Test 11 : LB Control Signal Test");
        OPCODE = `LOAD_OPCODE;
        FUNCT3 = 3'b000;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `assert(IMM_SEL,`I_SIGNED_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`IMM);
        `assert(ALU_OP,`ADD);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`MEM);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`LB);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("LB test passed!\n");

        // LH
        $display("Test 12 : LH Control Signal Test");
        OPCODE = `LOAD_OPCODE;
        FUNCT3 = 3'b001;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `assert(IMM_SEL,`I_SIGNED_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`IMM);
        `assert(ALU_OP,`ADD);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`MEM);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`LH);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("LH test passed!\n");

        // LW
        $display("Test 13 : LW Control Signal Test");
        OPCODE = `LOAD_OPCODE;
        FUNCT3 = 3'b010;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `assert(IMM_SEL,`I_SIGNED_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`IMM);
        `assert(ALU_OP,`ADD);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`MEM);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`LW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("LW test passed!\n");

        // LBU
        $display("Test 14 : LBU Control Signal Test");
        OPCODE = `LOAD_OPCODE;
        FUNCT3 = 3'b100;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `assert(IMM_SEL,`I_SIGNED_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`IMM);
        `assert(ALU_OP,`ADD);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`MEM);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`LBU);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("LBU test passed!\n");

        // LHU
        $display("Test 15 : LHU Control Signal Test");
        OPCODE = `LOAD_OPCODE;
        FUNCT3 = 3'b101;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `assert(IMM_SEL,`I_SIGNED_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`IMM);
        `assert(ALU_OP,`ADD);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`MEM);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`LHU);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("LHU test passed!\n");

        // SB
        $display("Test 16 : SB Control Signal Test");
        OPCODE = `STORE_OPCODE;
        FUNCT3 = 3'b000;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `assert(IMM_SEL,`S_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`IMM);
        `assert(ALU_OP,`ADD);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_0);
        // `assert(WB_SEL,`MEM);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`SB);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("SB test passed!\n");

        // SH
        $display("Test 17 : SH Control Signal Test");
        OPCODE = `STORE_OPCODE;
        FUNCT3 = 3'b001;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `assert(IMM_SEL,`S_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`IMM);
        `assert(ALU_OP,`ADD);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_0);
        // `assert(WB_SEL,`MEM);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`SH);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("SH test passed!\n");

        // SW
        $display("Test 18 : SW Control Signal Test");
        OPCODE = `STORE_OPCODE;
        FUNCT3 = 3'b010;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `assert(IMM_SEL,`S_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`IMM);
        `assert(ALU_OP,`ADD);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_0);
        // `assert(WB_SEL,`MEM);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`SW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("SW test passed!\n");

        // ADDI
        $display("Test 19 : ADDI Control Signal Test");
        OPCODE = `I_TYPE_OPCODE;
        FUNCT3 = 3'b000;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `assert(IMM_SEL,`I_SIGNED_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`IMM);
        `assert(ALU_OP,`ADD);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("ADDI test passed!\n");

        // SLTI
        $display("Test 20 : SLTI Control Signal Test");
        OPCODE = `I_TYPE_OPCODE;
        FUNCT3 = 3'b010;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `assert(IMM_SEL,`I_SIGNED_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`IMM);
        `assert(ALU_OP,`SLT);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("SLTI test passed!\n");

        // SLTIU
        $display("Test 21 : SLTIU Control Signal Test");
        OPCODE = `I_TYPE_OPCODE;
        FUNCT3 = 3'b011;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `assert(IMM_SEL,`I_UNSIGNED_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`IMM);
        `assert(ALU_OP,`SLTU);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("SLTIU test passed!\n");
        
        // XORI
        $display("Test 22 : XORI Control Signal Test");
        OPCODE = `I_TYPE_OPCODE;
        FUNCT3 = 3'b100;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `assert(IMM_SEL,`I_SIGNED_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`IMM);
        `assert(ALU_OP,`XOR);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("XORI test passed!\n");

        // ORI
        $display("Test 23 : ORI Control Signal Test");
        OPCODE = `I_TYPE_OPCODE;
        FUNCT3 = 3'b110;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `assert(IMM_SEL,`I_SIGNED_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`IMM);
        `assert(ALU_OP,`OR);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("ORI test passed!\n");

        // ANDI
        $display("Test 24 : ANDI Control Signal Test");
        OPCODE = `I_TYPE_OPCODE;
        FUNCT3 = 3'b111;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `assert(IMM_SEL,`I_SIGNED_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`IMM);
        `assert(ALU_OP,`AND);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("ANDI test passed!\n");

        // SLLI
        $display("Test 25 : SLLI Control Signal Test");
        OPCODE = `I_TYPE_OPCODE;
        FUNCT3 = 3'b001;
        FUNCT7 = 7'b0000000;
        `DECODE_DELAY
        #0;
        `assert(IMM_SEL,`I_SHIFT_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`IMM);
        `assert(ALU_OP,`SLL);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("SLLI test passed!\n");
        
        // SRLI
        $display("Test 26 : SRLI Control Signal Test");
        OPCODE = `I_TYPE_OPCODE;
        FUNCT3 = 3'b101;
        FUNCT7 = 7'b0000000;
        `DECODE_DELAY
        #0;
        `assert(IMM_SEL,`I_SHIFT_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`IMM);
        `assert(ALU_OP,`SRL);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("SRLI test passed!\n");

        // SRAI
        $display("Test 27 : SRAI Control Signal Test");
        OPCODE = `I_TYPE_OPCODE;
        FUNCT3 = 3'b101;
        FUNCT7 = 7'b0100000;
        `DECODE_DELAY
        #0;
        `assert(IMM_SEL,`I_SHIFT_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`IMM);
        `assert(ALU_OP,`SRA);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("SRAI test passed!\n");

        // ADD
        $display("Test 28 : ADD Control Signal Test");
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b000;
        FUNCT7 = 7'b0000000;
        `DECODE_DELAY
        #0;
        // `assert(IMM_SEL,`I_SHIFT_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(ALU_OP,`ADD);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("ADD test passed!\n");

        // SUB
        $display("Test 29 : SUB Control Signal Test");
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b000;
        FUNCT7 = 7'b0100000;
        `DECODE_DELAY
        #0;
        // `assert(IMM_SEL,`I_SHIFT_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(ALU_OP,`SUB);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("SUB test passed!\n");

        // SLL
        $display("Test 30 : SLL Control Signal Test");
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b001;
        FUNCT7 = 7'b0000000;
        `DECODE_DELAY
        #0;
        // `assert(IMM_SEL,`I_SHIFT_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(ALU_OP,`SLL);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("SLL test passed!\n");

        // SLT
        $display("Test 31 : SLT Control Signal Test");
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b010;
        FUNCT7 = 7'b0000000;
        `DECODE_DELAY
        #0;
        // `assert(IMM_SEL,`I_SHIFT_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(ALU_OP,`SLT);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("SLT test passed!\n");

        // SLTU
        $display("Test 32 : SLTU Control Signal Test");
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b011;
        FUNCT7 = 7'b0000000;
        `DECODE_DELAY
        #0;
        // `assert(IMM_SEL,`I_SHIFT_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(ALU_OP,`SLTU);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("SLTU test passed!\n");

        // XOR
        $display("Test 33 : XOR Control Signal Test");
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b100;
        FUNCT7 = 7'b0000000;
        `DECODE_DELAY
        #0;
        // `assert(IMM_SEL,`I_SHIFT_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(ALU_OP,`XOR);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("XOR test passed!\n");

        // SRL
        $display("Test 34 : SRL Control Signal Test");
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b101;
        FUNCT7 = 7'b0000000;
        `DECODE_DELAY
        #0;
        // `assert(IMM_SEL,`I_SHIFT_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(ALU_OP,`SRL);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("SRL test passed!\n");

        // SRA
        $display("Test 35 : SRA Control Signal Test");
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b101;
        FUNCT7 = 7'b0100000;
        `DECODE_DELAY
        #0;
        // `assert(IMM_SEL,`I_SHIFT_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(ALU_OP,`SRA);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("SRA test passed!\n");

        // OR
        $display("Test 36 : OR Control Signal Test");
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b110;
        FUNCT7 = 7'b0000000;
        `DECODE_DELAY
        #0;
        // `assert(IMM_SEL,`I_SHIFT_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(ALU_OP,`OR);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("OR test passed!\n");

        // AND
        $display("Test 37 : AND Control Signal Test");
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b111;
        FUNCT7 = 7'b0000000;
        `DECODE_DELAY
        #0;
        // `assert(IMM_SEL,`I_SHIFT_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(ALU_OP,`AND);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("AND test passed!\n");

        // MUL
        $display("Test 38 : MUL Control Signal Test");
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b000;
        FUNCT7 = 7'b0000001;
        `DECODE_DELAY
        #0;
        // `assert(IMM_SEL,`I_SHIFT_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(ALU_OP,`MUL);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("MUL test passed!\n");

        // MULH
        $display("Test 39 : MULH Control Signal Test");
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b001;
        FUNCT7 = 7'b0000001;
        `DECODE_DELAY
        #0;
        // `assert(IMM_SEL,`I_SHIFT_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(ALU_OP,`MULH);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("MULH test passed!\n");

        // MULHSU
        $display("Test 40 : MULHSU Control Signal Test");
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b010;
        FUNCT7 = 7'b0000001;
        `DECODE_DELAY
        #0;
        // `assert(IMM_SEL,`I_SHIFT_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(ALU_OP,`MULHSU);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("MULHSU test passed!\n");

        // MULHU
        $display("Test 41 : MULHU Control Signal Test");
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b011;
        FUNCT7 = 7'b0000001;
        `DECODE_DELAY
        #0;
        // `assert(IMM_SEL,`I_SHIFT_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(ALU_OP,`MULHU);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("MULHU test passed!\n");

        // DIV
        $display("Test 42 : DIV Control Signal Test");
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b100;
        FUNCT7 = 7'b0000001;
        `DECODE_DELAY
        #0;
        // `assert(IMM_SEL,`I_SHIFT_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(ALU_OP,`DIV);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("DIV test passed!\n");

        // DIVU
        $display("Test 43 : DIVU Control Signal Test");
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b101;
        FUNCT7 = 7'b0000001;
        `DECODE_DELAY
        #0;
        // `assert(IMM_SEL,`I_SHIFT_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(ALU_OP,`DIVU);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("DIVU test passed!\n");

        // REM
        $display("Test 44 : REM Control Signal Test");
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b110;
        FUNCT7 = 7'b0000001;
        `DECODE_DELAY
        #0;
        // `assert(IMM_SEL,`I_SHIFT_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(ALU_OP,`REM);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("REM test passed!\n");

        // REMU
        $display("Test 45 : REMU Control Signal Test");
        OPCODE = `R_TYPE_OPCODE;
        FUNCT3 = 3'b111;
        FUNCT7 = 7'b0000001;
        `DECODE_DELAY
        #0;
        // `assert(IMM_SEL,`I_SHIFT_TYPE);
        `assert(OP1SEL,`DATA1);
        `assert(OP2SEL,`DATA2);
        `assert(ALU_OP,`REMU);
        `assert(REG_WRITE_EN,`REG_WRITE_EN_1);
        `assert(WB_SEL,`ALU);
        `assert(BRANCH_JUMP,`NO);
        `assert(READ_WRITE,`NO_RW);
        
        $display("IMM_SEL: %b, OP1SEL: %b OP2SEL: %b ALU_OP: %b REG_WRITE_EN: %b WB_SEL: %b BRANCH_JUMP: %b READ_WRITE: %b", IMM_SEL, OP1SEL, OP2SEL, ALU_OP, REG_WRITE_EN, WB_SEL, BRANCH_JUMP, READ_WRITE);
        $display("REMU test passed!\n");

        $display("All tests passed!");

    end

endmodule