/*
    Immediate Generation Module 
*/


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
    assign J_OUT[0] = 0;        
    assign J_OUT[10:1] = IN[23:14];
    assign J_OUT[11] = IN[13];
    assign J_OUT[19:12] = IN[12:5];
    assign J_OUT[31:20] = {12{IN[24]}};

    // B Type Immediate
    assign B_OUT[0] = 0;
    assign B_OUT[4:1] = IN[4:1];
    assign B_OUT[10:5] = IN[23:18];
    assign B_OUT[11] = IN[0];
    assign B_OUT[31:12] = {20{IN[24]}};

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
            3'b000: OUT = U_OUT;
            3'b001: OUT = J_OUT;
            3'b010: OUT = S_OUT;
            3'b011: OUT = B_OUT;     
            3'b100: OUT = I_SIGN_OUT;          
            3'b101: OUT = I_SHIFT_OUT;         
            3'b110: OUT = I_UNSIGN_OUT;           
            default: OUT = 0 ;  
                                
        endcase
    end

endmodule