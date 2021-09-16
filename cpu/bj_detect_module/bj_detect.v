

module bj_detect(BRANCH_JUMP, DATA1, DATA2, PC_SEL_OUT);
    input [2:0] BRANCH_JUMP;
    output PC_SEL_OUT;
    input [31:0] DATA1,DATA2;

    wire eq, unsign_lt, sign_lt, PC_SEL;
    reg lt;
    wire out1, out2, out3, out4, out5;

    assign #2 PC_SEL_OUT = PC_SEL;

    assign eq = DATA1 == DATA2 ? 1 : 0;
    assign unsign_lt = DATA1 < DATA2;
    assign sign_lt = ($signed(DATA1) < $signed(DATA2));


    always @(*) begin
        case (BRANCH_JUMP[2:1])
            2'b11: lt = unsign_lt;
            default: lt = sign_lt;
        endcase
    end

    and logicAnd1(out1, !BRANCH_JUMP[2], BRANCH_JUMP[0], !eq);
    and logicAnd2(out2, !BRANCH_JUMP[2], BRANCH_JUMP[1], BRANCH_JUMP[0]);
    and logicAnd3(out3, BRANCH_JUMP[2], !BRANCH_JUMP[0], lt);
    and logicAnd4(out4, BRANCH_JUMP[2], eq, lt);
    and logicAnd5(out5, BRANCH_JUMP[2], BRANCH_JUMP[0], !lt);
    and logicAnd6(out6, !BRANCH_JUMP[2], !BRANCH_JUMP[1], !BRANCH_JUMP[0], eq);

    or logicOr(PC_SEL, out1, out2, out3, out4, out5, out6);    

endmodule