/*
    Immediate Generation Module 
*/
`include "../utils/encodings.v"

module immediate_generate(IN, OUT, IMM_SEL);

    // port declaration
    input [24:0] IN;            // instruction[31:7]
    input [2:0] IMM_SEL;        // immediate select op
    output reg [31:0] OUT;      // sign extended 32-bit value


    wire [31:0]  U_OUT,
                J_OUT,
                B_OUT,
                I_SIGN_OUT,
                I_UNSIGN_OUT,
                S_OUT,
                I_SHIFT_OUT;

    // U Type Immediate
    assign U_OUT[11:0] = {12{1'b0}};
    assign U_OUT[31:12] = IN[24:5];
               
    // J type Immediate
    assign J_OUT[1:0] = 2'b00;        
    assign J_OUT[11:2] = IN[23:14];
    assign J_OUT[12] = IN[13];
    assign J_OUT[20:13] = IN[12:5];
    assign J_OUT[31:21] = {11{IN[24]}};

    // B Type Immediate
    assign B_OUT[1:0] = 2'b00;
    assign B_OUT[5:2] = IN[4:1];
    assign B_OUT[11:6] = IN[23:18];
    assign B_OUT[12] = IN[0];
    assign B_OUT[31:13] = {19{IN[24]}};

    //I Type Immediate
    assign I_SIGN_OUT[11:0] = IN[24:13] ;
    assign I_SIGN_OUT[31:12] = {20{IN[24]}};

    //IU --> unsigned extend Immediate
    assign I_UNSIGN_OUT[11:0] = IN[24:13] ;
    assign I_UNSIGN_OUT[31:12] = {20{1'b0}};

    // S Type Immediate
    assign S_OUT[4:0] = IN[4:0] ;
    assign S_OUT[11:5] = IN[24:18];
    assign S_OUT[31:12] = {20{IN[24]}};

    // SFT 
    assign I_SHIFT_OUT[4:0] = IN[17:13];
    assign I_SHIFT_OUT[31:5] = {27{1'b0}};    
    
    always @(*)
    begin
      
        case(IMM_SEL)
            `U_TYPE: OUT = U_OUT;
            `J_TYPE: OUT = J_OUT;
            `S_TYPE: OUT = S_OUT;
            `B_TYPE: OUT = B_OUT;     
            `I_SIGNED_TYPE: OUT = I_SIGN_OUT;          
            `I_SHIFT_TYPE: OUT = I_SHIFT_OUT;         
            `I_UNSIGNED_TYPE: OUT = I_UNSIGN_OUT;           
            default: OUT = 0 ;  
                                
        endcase
    end

endmodule