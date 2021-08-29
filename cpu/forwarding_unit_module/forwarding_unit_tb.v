`include "forwarding_unit.v"
`include "../utils/macros.v"
`include "../utils/encodings.v"
module forwarding_unit_tb;

    reg [4:0] ADDR1, ADDR2, WB_ADDR, MEM_ADDR, EXE_ADDR;
    reg OP1SEL, OP2SEL;
    reg [6:0] OPCODE;
    wire DATA1IDSEL, DATA2IDSEL, DATAMEMSEL;
    wire [1:0] DATA1EXESEL, DATA2EXESEL;

    integer j;
    forwarding_unit my_forwarding_unit(ADDR1, ADDR2, WB_ADDR, MEM_ADDR, EXE_ADDR, OP1SEL, OP2SEL, OPCODE, DATA1IDSEL, DATA2IDSEL, DATA1EXESEL, DATA2EXESEL, DATAMEMSEL);

    initial begin
        $dumpfile("forwarding_unit_wavedata.vcd");
        $dumpvars(0, forwarding_unit_tb);

        /* ------- Forwarding unit Test 01 ----------
            Able to detect RW -> MEM data dependancy
            lw r1 8(r2)
            sw r1 8(r3)

            DATAMEMSEL signal should be high.
        */
        EXE_ADDR = 5'd1;
        ADDR2 = 5'd1;
        OP1SEL = 1'b0;
        OP2SEL = 1'b1;
        OPCODE = `STORE_OPCODE;
        #0;
        `assert(DATAMEMSEL,1);
        $display("Forwarding unit Test 01 - Able to detect RW -> MEM data dependancy test passed!");


        /* ------- Forwarding unit Test 02 ----------
            Able to detect RW -> EXE data dependancy
            lw r1 8(r2)
            sub r5,r6,r7
            add r3,r2,r1

            DATA2EXESEL signal should be 10.
        */
        MEM_ADDR = 5'd1;
        EXE_ADDR = 5'd5;
        ADDR1 = 5'd2;
        ADDR2 = 5'd1;
        OPCODE = `R_TYPE_OPCODE;
        OP1SEL = 1'b0;
        OP2SEL = 1'b0;
        #0;
        `assert(DATA2EXESEL,2'b10);
        $display("Forwarding unit Test 02 - Able to detect RW -> EX data dependancy test passed!");

        /* ------- Forwarding unit Test 03 ----------
            Able to detect RW -> ID data dependancy
            lw r1 8(r2)
            sub r5,r6,r7
            sub r8,r9,r10
            add r3,r2,r1

            DATA2IDSEL signal should be 1.
        */
        WB_ADDR = 5'd1;
        MEM_ADDR = 5'd5;
        EXE_ADDR = 5'd8;
        ADDR1 = 5'd2;
        ADDR2 = 5'd1;
        OPCODE = `R_TYPE_OPCODE;
        OP1SEL = 1'b0;
        OP2SEL = 1'b0;
        #0;
        `assert(DATA2IDSEL,1'b1);
        $display("Forwarding unit Test 03 - Able to detect RW -> ID data dependancy test passed!");
    
        /* ------- Forwarding unit Test 04 ----------
            Able to detect MEM -> EXE data dependancy
            add r1 r2 r3
            sub r5 r1 r4

            DATA1IDSEL signal should be high.
            DATA2IDSEL signal should be low.
        */
        EXE_ADDR = 5'd1;
        ADDR1 = 5'd1;
        ADDR2 = 5'd4;
        OP1SEL = 1'b0;
        OP2SEL = 1'b0;
        OPCODE = `R_TYPE_OPCODE;
        #0;
        `assert(DATA1IDSEL,1'b1);
        `assert(DATA2IDSEL,1'b0);
        $display("Forwarding unit Test 04 - Able to detect MEM -> EXE data dependancy test passed!");
        #500;
        $finish;

    end

endmodule