/**
Author  : Shirly Madushanka
Date    : Jul 29, 2021

Description : 
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <ctype.h>

#define LINE_SIZE 512

// #define DEBUG 1
#ifdef DEBUG
#define PRINT printf 
#else 
#define PRINT(...) 
#endif


char *JAL   = "1101111";
char *JALR  = "1100111";
char *BEQ   = "1100011";
char *BNE   = "1100011";
char *BLT   = "1100011";
char *BGE   = "1100011";
char *BLTU  = "100011";
char *BGEU  = "1100011";
char *LB    = "0000011";
char *LH    = "0000011";
char *LW    = "0000011";
char *LBU   = "0000011";
char *LHU   = "0000011";
char *SB    = "0100011";
char *SH    = "0100011";
char *SW    = "0100011";
char *ADDI  = "0010011";
char *SLTI  = "0010011";
char *SLTIU = "0010011";
char *XORI  = "0010011";
char *ORI   = "0010011";
char *ANDI  = "0010011";
char *SLLI  = "0010011";
char *SRLI  = "0010011";
char *SRAI  = "0010011";
char *ADD   = "0110011";
char *SUB   = "0110011";
char *SLL   = "0110011";
char *SLT   = "0110011";
char *SLTU  = "0110011";
char *XOR   = "0110011";
char *SRL   = "0110011";
char *SRA   = "0110011";
char *OR    = "0110011";
char *AND   = "0110011";
char *MUL   = "0110011";
char *MULH  = "0110011";
char *MULHSU= "0110011";
char *MULHU = "0110011";
char *DIV   = "0110011";
char *DIVU  = "0110011";
char *REM   = "0110011";
char *REMU  = "0110011";

char *R_TYPE = "0110011";
char *I_TYPE = "0010011";
char *B_TYPE = "1100011";
char *J_TYPE = "1101111";
char *LUI   = "0110111";
char *AUIPC = "0010111";
char *NOT_VALID = "not-valid";

char *OPERAND = "operand";
char *OFFSET = "immediate";
char *BASE_AND_OFFSET = "base-and-offset";

char* opcodeFromFormat(char* format, char* keyword) {
    PRINT("Decide opcode for %s, %s instruction\n",format, keyword);
    if(strcmp(format,"R_TYPE") == 0) return R_TYPE;
    if(strcmp(format,"I_TYPE") == 0 || strcmp(format,"SFT_TYPE") == 0) return I_TYPE;
    if(strcmp(format,"B_TYPE") == 0) return B_TYPE;
    if(strcmp(format,"J_TYPE") == 0) return J_TYPE;
    if(strcmp(format, "U_TYPE") == 0) {
        if(strcasecmp(keyword, "lui") == 0) return LUI;
        if(strcasecmp(keyword, "auipc") == 0) return AUIPC;
    }
    return "0000000";
}

char* getInstructionType(char* keyword) {
    PRINT("Decide instruction type for %s\n",keyword);
    if(
        strcasecmp(keyword, "mul") == 0 || 
        strcasecmp(keyword, "mulh") == 0 || 
        strcasecmp(keyword, "mulhu") == 0 ||
        strcasecmp(keyword, "mulhsu") == 0 ||
        strcasecmp(keyword, "div") == 0 ||
        strcasecmp(keyword, "divu") == 0 ||
        strcasecmp(keyword, "rem") == 0 ||
        strcasecmp(keyword, "remu") == 0 ||
        strcasecmp(keyword, "add") == 0 ||
        strcasecmp(keyword, "sub") == 0 ||
        strcasecmp(keyword, "sll") == 0 ||
        strcasecmp(keyword, "slt") == 0 ||
        strcasecmp(keyword, "sltu") == 0 ||
        strcasecmp(keyword, "xor") == 0 ||
        strcasecmp(keyword, "srl") == 0 ||
        strcasecmp(keyword, "sra") == 0 ||
        strcasecmp(keyword, "or") == 0 ||
        strcasecmp(keyword, "and") == 0
    ) return "R_TYPE";

    if(
        strcasecmp(keyword, "lb") == 0 ||
        strcasecmp(keyword, "lh") == 0 ||
        strcasecmp(keyword, "lw") == 0 ||
        strcasecmp(keyword, "lbu") == 0 ||
        strcasecmp(keyword, "addi") == 0 ||
        strcasecmp(keyword, "slti") == 0 ||
        strcasecmp(keyword, "sltiu") == 0 ||
        strcasecmp(keyword, "xori") == 0 ||
        strcasecmp(keyword, "ori") == 0 ||
        strcasecmp(keyword, "ori") == 0 ||
        strcasecmp(keyword, "andi") == 0 ||
        strcasecmp(keyword, "jalr") == 0
    ) return "I_TYPE";

    if(
        strcasecmp(keyword, "sb") == 0 ||
        strcasecmp(keyword, "sh") == 0 ||
        strcasecmp(keyword, "sw") == 0
    ) return "S_TYPE";

    if(
        strcasecmp(keyword, "slli") == 0 ||
        strcasecmp(keyword, "srli") == 0 ||
        strcasecmp(keyword, "srai") == 0
    ) return "SFT_TYPE";

    if(
        strcasecmp(keyword, "jal") == 0
    ) return "J_TYPE";

    if(
        strcasecmp(keyword, "lui") == 0 ||
        strcasecmp(keyword, "auipc") == 0
    ) return "U_TYPE";

    return NOT_VALID;
}

char* getFunc7(char* instruction, char* type) {
    PRINT("Generating function 7 encodes for %s - %s instruction\n",type,instruction);
    if(strcmp(type,"R_TYPE") == 0) {
        if(strcasecmp(instruction, "mul") == 0) return "0000001";
        if(strcasecmp(instruction, "mulh") == 0) return "0000001";
        if(strcasecmp(instruction, "mulhu") == 0) return "0000001";
        if(strcasecmp(instruction, "mulhsu") == 0) return "0000001";
        if(strcasecmp(instruction, "div") == 0) return "0000001";
        if(strcasecmp(instruction, "divu") == 0) return "0000001";
        if(strcasecmp(instruction, "rem") == 0) return "0000001";
        if(strcasecmp(instruction, "remu") == 0) return "0000001";
        if(strcasecmp(instruction, "add") == 0) return "0000000";
        if(strcasecmp(instruction, "sub") == 0) return "0100000";
        if(strcasecmp(instruction, "sll") == 0) return "0000000";
        if(strcasecmp(instruction, "slt") == 0) return "0000000";
        if(strcasecmp(instruction, "sltu") == 0) return "0000000";
        if(strcasecmp(instruction, "xor") == 0) return "0000000";
        if(strcasecmp(instruction, "srl") == 0) return "0000000";
        if(strcasecmp(instruction, "sra") == 0) return "0100000";
        if(strcasecmp(instruction, "or") == 0) return "0000000";
        if(strcasecmp(instruction, "and") == 0) return "0000000";
    }
    
    return "0000000";
}

char* getFunc3(char* instruction, char* type) {
    PRINT("Generating function 3 encodes for %s - %s instruction\n",type,instruction);
    if(strcmp(type,"R_TYPE") == 0) {
        if(strcasecmp(instruction, "mul") == 0) return "000";
        if(strcasecmp(instruction, "mulh") == 0) return "001";
        if(strcasecmp(instruction, "mulhu") == 0) return "010";
        if(strcasecmp(instruction, "mulhsu") == 0) return "011";
        if(strcasecmp(instruction, "div") == 0) return "100";
        if(strcasecmp(instruction, "divu") == 0) return "101";
        if(strcasecmp(instruction, "rem") == 0) return "110";
        if(strcasecmp(instruction, "remu") == 0) return "111";
        if(strcasecmp(instruction, "add") == 0) return "000";
        if(strcasecmp(instruction, "sub") == 0) return "000";
        if(strcasecmp(instruction, "sll") == 0) return "001";
        if(strcasecmp(instruction, "slt") == 0) return "010";
        if(strcasecmp(instruction, "sltu") == 0) return "011";
        if(strcasecmp(instruction, "xor") == 0) return "100";
        if(strcasecmp(instruction, "srl") == 0) return "101";
        if(strcasecmp(instruction, "sra") == 0) return "101";
        if(strcasecmp(instruction, "or") == 0) return "110";
        if(strcasecmp(instruction, "and") == 0) return "111";
    }
    if(strcmp(type,"I_TYPE") == 0) {
        if(strcasecmp(instruction, "lb")) return "000";
        if(strcasecmp(instruction, "lh")) return "001";
        if(strcasecmp(instruction, "lw")) return "010";
        if(strcasecmp(instruction, "lbu")) return "100";
        if(strcasecmp(instruction, "addi")) return "101";
        if(strcasecmp(instruction, "andi")) return "000";
        if(strcasecmp(instruction, "slti")) return "010";
        if(strcasecmp(instruction, "sltiu")) return "011";
        if(strcasecmp(instruction, "xori")) return "100";
        if(strcasecmp(instruction, "ori")) return "110";
        if(strcasecmp(instruction, "jalr")) return "111";
    }
    if(strcmp(type,"B_TYPE") == 0) {
        if(strcasecmp(instruction, "beq")) return "001";
        if(strcasecmp(instruction, "bne")) return "010";
        if(strcasecmp(instruction, "blt")) return "011";
        if(strcasecmp(instruction, "bge")) return "100";
        if(strcasecmp(instruction, "bltu")) return "101";
        if(strcasecmp(instruction, "bgeu")) return "110";
    }
    if(strcmp(type,"J_TYPE") == 0)  {
        if(strcasecmp(instruction, "jal")) return "111";
    }
    if(strcmp(type, "U_TYPE") == 0) {
        if(strcasecmp(instruction, "lui")) return "000";
        if(strcasecmp(instruction, "auipc")) return "000";
    }
    if(strcmp(type, "S_TYPE") == 0) {
        if(strcasecmp(instruction, "sb")) return "000";
        if(strcasecmp(instruction, "sh")) return "000";
        if(strcasecmp(instruction, "sw")) return "000";
    }
    return "000";
}

void errorHandler(char* message, char* out_file, int lineNumber, char* fileName) {
    printf("[ERR] : %s on line %d in file %s. Exitting!\n", message, lineNumber, fileName);
    if(remove(out_file) == 0) {
        PRINT("Output file deleted!\n");
    }else {
        PRINT("Error deleting output file!\n");
    }
    exit(1);
}

int encodeToFormat(FILE* fo,char* keyword, char* type, char* destination_register, char* src1_register, char* src2_register, char* immediate, char* base_register) {
    char pline[LINE_SIZE]="";
    char* opcode = opcodeFromFormat(type, keyword);
    char* func3 = getFunc3(keyword, type);
    char* func7 = getFunc7(keyword, type);
    char * immediateRef = immediate;
    if(strcmp(type, "R_TYPE") == 0) {
        sprintf(pline, "%.7s %.5s %.5s %.3s %.5s %.7s",func7, src2_register, src1_register, func3, destination_register, opcode);
    } else if (strcmp(type, "J_TYPE") == 0) {
        char imm10_1[11]="";
        char imm19_12[9]="";
        strncpy(imm10_1, immediateRef+(31 - 10), 10);
        strncpy(imm19_12, immediateRef+(32 - 19), 8);
        sprintf(pline, "%c %.10s %c %.8s %.5s %.7s",immediateRef[31-20], imm10_1, immediateRef[31-11], imm19_12, destination_register, opcode);
    }
    fputs(pline, fo);
    fputs("\n", fo);
    return 0;
}

int operandCountChecker(char* type) {
    if(strcmp(type, "R_TYPE") == 0) return 4;
    if(strcmp(type, "J_TYPE") == 0) return 3;
    return 0;
}

int main(int argc, char *argv[]) {

    char out_file[256];
    FILE *fi, *fo;
	char line[LINE_SIZE];
    const char delim[] = " ";
    char *in_token;
    int lineNumber = 0;

    strcpy(out_file,argv[1]);
	strcat(out_file,".machine");

 	if ((fi = fopen(argv[1],"r")) == NULL){
		printf("Err0r: Cannot open source file!\n");
		exit(1);
	}

	if ((fo = fopen(out_file,"wb")) == NULL){
		printf("Error: Cannot open output file!\n");
		fclose(fi);
		exit(1);
	}

    while(fgets(line, LINE_SIZE, fi)!=NULL) // Read a line from the input .s file
	{
        // track line number
        lineNumber++;

        // Handle empty lines
        if(strcmp(line, "\n") == 0) {
            PRINT("[INFO] : Skipping empty line %d in file %s\n", lineNumber, argv[1]);
            continue;
        }
        
        char pline[LINE_SIZE]="";
		char tline[LINE_SIZE];
        char operandOrder[LINE_SIZE]="";
        char keyword[10]="";
        int count = 0;
        strcpy(tline,line);
        in_token = strtok(tline, delim);
        strcpy(keyword, in_token);

        char destination_register[6];
        char src1_register[6];
        char src2_register[6];
        char immediate[33];
        char base_register[6];

        // Handle comments.
        if(
            strcmp(keyword, "//") == 0 || 
            strcmp(keyword, "// ") == 0 || 
            strcmp(keyword, "//\n") == 0
        ) {
            PRINT("[INFO] : Skipping comment line on line %d in file %s\n", lineNumber, argv[1]);
            continue;
        }

        char* type = getInstructionType(keyword);

        if(strcmp(type, NOT_VALID) == 0) {
            errorHandler("Invalid instruction", out_file, lineNumber, argv[1]);
        }

        count++;
        /**
         * Handling opcodes
        */
       in_token = strtok(NULL,delim);
       count++;
       while(in_token != NULL){
           if(count > operandCountChecker(type)) errorHandler("Invalid instruction operand(s)", out_file, lineNumber, argv[1]);
           if(strstr(in_token,"x") && (strstr(in_token,"x") == in_token)) {
                int length = strlen(in_token);
                int registerNumber = 0;
                for (int i = 1; i < length; i++){
                    if(in_token[i] == '\n') continue;
                    if(isdigit(in_token[i])) {
                        registerNumber = registerNumber*10 + (in_token[i] - '0');
                    } else {
                        errorHandler("Invalid instruction", out_file, lineNumber, argv[1]);
                    }
                }
                if(registerNumber == 0 && count == 2) {
                    errorHandler("Can't use x0 as a destination register", out_file, lineNumber, argv[1]);
                }else if (registerNumber > 31) {
                    errorHandler("Invalid register number", out_file, lineNumber, argv[1]);
                }
                char registerNumberInBinary[6];
                strcpy(registerNumberInBinary, "");
                for (int i = 4; i >= 0; i--){
                    int digit = registerNumber >> i;
                    if(digit & 1) {
                        registerNumberInBinary[4 - i] = '1';
                    }else {
                        registerNumberInBinary[4 - i] = '0';
                    }
                }
                registerNumberInBinary[5] = '\0';
                if(count == 2) strcpy(destination_register, registerNumberInBinary);
                if(count == 3) strcpy(src1_register, registerNumberInBinary);
                if(count == 4) strcpy(src2_register, registerNumberInBinary);
                if(count == 2 || count == 3) {
                    strcat(operandOrder, OPERAND);
                    strcat(operandOrder, "_");
                } else strcat(operandOrder, OPERAND);
           } else {
                char* pch = strchr(in_token, '(');
                if(pch) {
                    strcat(operandOrder, BASE_AND_OFFSET);
                    int length = strlen(pch);
                    int registerNumber = 0;
                    for (int i = 1; i < length - 1; i++){
                        if(pch[i] == '\n') continue;
                        if(isdigit(pch[i])) {
                            registerNumber = registerNumber*10 + (pch[i] - '0');
                        }
                    }
                    if (registerNumber > 31) {
                        errorHandler("Invalid register number", out_file, lineNumber, argv[1]);
                    }
                    strcpy(base_register, "");
                    for (int i = 4; i >= 0; i--){
                        int digit = registerNumber >> i;
                        if(digit & 1) {
                            base_register[4 - i] = '1';
                        }else {
                            base_register[4 - i] = '0';
                        }
                    }
                    base_register[5] = '\0';
                }else {
                    strcat(operandOrder, OFFSET);
                    int immediateValue = 0;
                    int length = strlen(in_token);
                    for (int i = 0; i < length; i++){
                        if(in_token[i] == '\n') continue;
                        if(isdigit(in_token[i])) {
                            immediateValue = immediateValue*10 + (in_token[i] - '0');
                        }
                    }

                    strcpy(immediate, "");
                    for (int i = 31; i >= 0; i--){
                        int digit = immediateValue >> i;
                        if(digit & 1) {
                            immediate[31 - i] = '1';
                        }else {
                            immediate[31 - i] = '0';
                        }
                    }
                    immediate[32] = '\0';
                }
           }
           
           in_token = strtok(NULL,delim);
           count ++;
       }
        encodeToFormat(fo, keyword, type, destination_register, src1_register, src2_register, immediate, base_register);

        // char* func3 = getFunc3(keyword, type);
        // char* func7 = getFunc7(keyword, type);
        // fputs(opcode, fo);
        // fputs("\n", fo);
        // printf("funct3: %s, funct7: %s\n",func3,func7);
    }

    // char* keyword = argv[1];
    // char* type = getInstructionType(keyword);
    // char* opcode = opcodeFromFormat(type, keyword);
    // char* func3 = getFunc3(keyword, type);
    // char* func7 = getFunc7(keyword, type);
    // printf("type: %s, opcode: %s\n",type,opcode);
    // printf("funct3: %s, funct7: %s\n",func3,func7);
    fclose(fi); 
	fclose(fo);
    return 0;
}