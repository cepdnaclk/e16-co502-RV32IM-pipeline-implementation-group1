module loading_unit (
    DATA_IN,
    DATA_OUT,
    LOAD_SEL
);

input [31:0] DATA_IN;
input [2:0] LOAD_SEL;
output reg [31:0] DATA_OUT;

wire [31:0] LB, LH, LW, LBU, LHU;

assign LB[7:0] = {DATA_IN[31:24]};
assign LB[31:8] = {24{DATA_IN[31]}};

assign LH[15:0] = {DATA_IN[31:16]};
assign LH[31:16] = {24{DATA_IN[31]}};

assign LW = DATA_IN;

assign LBU = {24'd0, DATA_IN[31:24]};

assign LHU = {16'd0, DATA_IN[31:16]};

always @ (*) begin
    #1;
    case(LOAD_SEL)
        3'b000 :   DATA_OUT = LB;
        3'b001 :   DATA_OUT = LH;
        3'b010 :   DATA_OUT = LW;
        3'b100 :   DATA_OUT = LBU;
        3'b101 :   DATA_OUT = LHU;
        default: DATA_OUT = 0 ; 
    endcase
end
    
endmodule