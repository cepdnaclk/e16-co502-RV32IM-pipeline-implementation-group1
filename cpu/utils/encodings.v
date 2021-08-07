// OPCODES
`define LUI_OPCODE 7'b0110111
`define AUIPC_OPCODE 7'b0010111
`define JAL_OPCODE 7'b1101111
`define JALR_OPCODE 7'b1100111
`define B_TYPE_OPCODE 7'b1100011
`define LOAD_OPCODE 7'b0000011
`define STORE_OPCODE 7'b0100011
`define I_TYPE_OPCODE 7'b0010011
`define R_TYPE_OPCODE 7'b0110011

// OP1SEL
`define DATA1 1'b0
`define PC 1'b1

// OP2SEL
`define DATA2 1'b0
`define IMM 1'b1

// REG_WRITE_EN
`define REG_WRITE_EN_0 1'b0
`define REG_WRITE_EN_1 1'b1

// WB_SEL
`define ALU 2'b00
`define MEM 2'b01
`define IMM_WB 2'b10
`define PC_4 2'b11

// ALU_OP
`define ADD 5'b00000
`define SUB 5'b00010
`define SLL 5'b00100
`define SLT 5'b01000
`define SLTU 5'b01100
`define XOR 5'b10000
`define SRL 5'b10100
`define SRA 5'b10110
`define OR 5'b11000
`define AND 5'b11100
`define MUL 5'b00001
`define MULH 5'b00101
`define MULHSU 5'b01001
`define MULHU 5'b01101
`define DIV 5'b10001
`define DIVU 5'b10101
`define REM 5'b11001
`define REMU 5'b11101

// BRANCH_JUMP
`define BEQ 3'b000
`define BNE 3'b001
`define NO 3'b010
`define J 3'b011
`define BLT 3'b100
`define BGE 3'b101
`define BLTU 3'b110
`define BGEU 3'b111

// IMM_SEL
`define U_TYPE 3'b000
`define J_TYPE 3'b001
`define S_TYPE 3'b010
`define B_TYPE 3'b011
`define I_SIGNED_TYPE 3'b100
`define I_SHIFT_TYPE 3'b101
`define I_UNSIGNED_TYPE 3'b111

// MEM_RW
`define NO_RW 4'b0000
`define LB 4'b1000
`define LH 4'b1001
`define LW 4'b1010
`define LBU 4'b1100
`define LHU 4'b1101
`define SB 4'b1011
`define SH 4'b1110
`define SW 4'b1111