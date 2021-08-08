`include "../other_modules/mux_2x1_32bit/mux_2x1_32bit.v"
`include "../other_modules/mux_4x1_32bit/mux_4x1_32bit.v"
`include "../other_modules/register_32bit/register_32bit.v"
`include "../other_modules/adder_32bit/adder_32bit.v"
`include "../instruction_cache_module/instruction_cache.v"
`include "../reg_file_module/reg_file.v"
`include "../control_unit_module/control_unit.v"
`include "../immediate_gen_module/immediate_generate.v"
`include "../alu_module/alu.v"
`include "../bj_detect_module/bj_detect.v"
`include "../data_cache_module/data_cache.v"

module cpu_single_cycle(RESET, CLK, INST_MEM_READDATA, DATA_MEM_READDATA, DATA_MEM_WRITEDATA, INST_MEM_READ, DATA_MEM_BUSYWAIT, DATA_MEM_READ, DATA_MEM_WRITE, INST_MEM_ADDRESS, DATA_MEM_ADDRESS, INST_MEM_BUSYWAIT);

input RESET, CLK, INST_MEM_BUSYWAIT, DATA_MEM_BUSYWAIT;
input [127:0] INST_MEM_READDATA, DATA_MEM_READDATA;
output [127:0] DATA_MEM_WRITEDATA;
output INST_MEM_READ, DATA_MEM_READ, DATA_MEM_WRITE;
output [27:0] INST_MEM_ADDRESS, DATA_MEM_ADDRESS;

wire [31:0] PC_SEL_MUX_OUT, PC_4_OUT, ALU_OUT, PC_OUT, INSTRUCTION, WB_MUX_OUT, REG_FILE_OUT1, REG_FILE_OUT2, IMM_GEN_OUT, OPERAND1, OPERAND2, READDATA, PC_4_WB_OUT;
wire BUSYWAIT, DATA_BUSYWAIT, INST_BUSYWAIT, WRITE_ENABLE, REG_WRITE_EN, OP1SEL, OP2SEL, PC_SEL;
wire [1:0] WB_SEL;
wire [4:0] ALUOP;
wire [3:0] READ_WRITE;
wire [2:0] IMM_SEL, BRANCH_JUMP;

assign BUSYWAIT = (DATA_BUSYWAIT | INST_BUSYWAIT);
assign WRITE_ENABLE = (REG_WRITE_EN & !BUSYWAIT);

// Instruction decode stage
mux_2x1_32bit pc_select_mux(PC_4_OUT, ALU_OUT, PC_SEL_MUX_OUT, PC_SEL);

register_32bit program_counter(PC_SEL_MUX_OUT, PC_OUT, RESET, CLK, BUSYWAIT);

adder_32bit pc_4_adder(PC_OUT, PC_4_OUT);

instruction_cache inst_cache(CLK, RESET, PC_OUT, INSTRUCTION, INST_BUSYWAIT, INST_MEM_ADDRESS, INST_MEM_READ, INST_MEM_READDATA, INST_MEM_BUSYWAIT);

// Reg file read stage
reg_file register_file(WB_MUX_OUT, REG_FILE_OUT1, REG_FILE_OUT2, INSTRUCTION[11:7], INSTRUCTION[19:15], INSTRUCTION[24:20], WRITE_ENABLE, CLK, RESET);

immediate_generate imm_gen(INSTRUCTION[31:7], IMM_GEN_OUT, IMM_SEL);

control_unit ctrl_unit(INSTRUCTION[6:0], INSTRUCTION[14:12], INSTRUCTION[31:25], OP1SEL, OP2SEL, REG_WRITE_EN, WB_SEL, ALUOP, BRANCH_JUMP, IMM_SEL, READ_WRITE);

// ALU stage
mux_2x1_32bit operand1_mux(REG_FILE_OUT1, PC_OUT, OPERAND1, OP1SEL);

mux_2x1_32bit operand2_mux(REG_FILE_OUT2, IMM_GEN_OUT, OPERAND2, OP2SEL);

alu alu_unit(OPERAND1, OPERAND2, ALU_OUT, ALUOP);

bj_detect bj_unit(BRANCH_JUMP, REG_FILE_OUT1, REG_FILE_OUT2, PC_SEL);

// MEM stage
adder_32bit pc_4_adder_wb(PC_OUT, PC_4_WB_OUT);

data_cache d_cache(CLK, RESET, DATA_BUSYWAIT, READ_WRITE, REG_FILE_OUT2, READDATA, ALU_OUT, DATA_MEM_BUSYWAIT, DATA_MEM_READ, DATA_MEM_WRITE, DATA_MEM_READDATA, DATA_MEM_WRITEDATA, DATA_MEM_ADDRESS);

// WB_STAGE

mux_4x1_32bit wb_mux(ALU_OUT, READDATA, IMM_GEN_OUT, PC_4_WB_OUT, WB_MUX_OUT, WB_SEL);
    
endmodule