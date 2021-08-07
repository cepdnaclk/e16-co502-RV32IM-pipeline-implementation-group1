module bj_detect(BRANCH_JUMP, DATA1, DATA2, PC_SEL);
    input [2:0] BRANCH_JUMP;
    output PC_SEL;
    input [31:0] DATA1,DATA2;

    wire eq, unsign_lt, sign_lt;
    reg lt;
    wire out1, out2, out3, out4, out5;

    assign eq = DATA1 == DATA2 ? 1 : 0;
    assign unsign_lt = DATA1 < DATA2;
    assign sign_lt = ($signed(DATA1) < $signed(DATA2));

    always @(BRANCH_JUMP) begin
        case (BRANCH_JUMP)
            3'b11x: lt = unsign_lt;
            default: lt = sign_lt;
        endcase
    end
    
    and logicAnd1(out1, BRANCH_JUMP[2], !BRANCH_JUMP[0]);
    and logicAnd2(out2, BRANCH_JUMP[0], !lt);
    and logicAnd3(out3, BRANCH_JUMP[0], !eq);
    and logicAnd4(out4, !BRANCH_JUMP[2], !BRANCH_JUMP[1], BRANCH_JUMP[0]);
    and logicAnd5(out5, BRANCH_JUMP[2], !BRANCH_JUMP[0], lt);

    or logicOr(PC_SEL, out1, out2, out3, out4, out5);
endmodule