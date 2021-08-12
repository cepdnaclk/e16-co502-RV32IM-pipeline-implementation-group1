module instruction_memory(CLK, READ, ADDRESS, READDATA, BUSYWAIT);

`define MEM_READ_DELAY #40

input               CLK;
input               READ;
input[27:0]          ADDRESS;
output reg [127:0]  READDATA;
output reg          BUSYWAIT;

reg READACCESS;

//Declare memory array 1024x8-bits 
reg [7:0] MEM_ARRAY [0:1023];

// //Initialize instruction memory
// initial
// begin
//     BUSYWAIT = 0;
//     READACCESS = 0;
// end

//Detecting an incoming memory access
always @(READ)
begin
    BUSYWAIT = (READ)? 1 : 0;
    READACCESS = (READ)? 1 : 0;
end

//Reading
always @(posedge CLK)
begin
    if(READACCESS)
    begin
        READDATA[7:0]     = `MEM_READ_DELAY MEM_ARRAY[{ADDRESS,4'b0000}];
        READDATA[15:8]    = `MEM_READ_DELAY MEM_ARRAY[{ADDRESS,4'b0001}];
        READDATA[23:16]   = `MEM_READ_DELAY MEM_ARRAY[{ADDRESS,4'b0010}];
        READDATA[31:24]   = `MEM_READ_DELAY MEM_ARRAY[{ADDRESS,4'b0011}];
        READDATA[39:32]   = `MEM_READ_DELAY MEM_ARRAY[{ADDRESS,4'b0100}];
        READDATA[47:40]   = `MEM_READ_DELAY MEM_ARRAY[{ADDRESS,4'b0101}];
        READDATA[55:48]   = `MEM_READ_DELAY MEM_ARRAY[{ADDRESS,4'b0110}];
        READDATA[63:56]   = `MEM_READ_DELAY MEM_ARRAY[{ADDRESS,4'b0111}];
        READDATA[71:64]   = `MEM_READ_DELAY MEM_ARRAY[{ADDRESS,4'b1000}];
        READDATA[79:72]   = `MEM_READ_DELAY MEM_ARRAY[{ADDRESS,4'b1001}];
        READDATA[87:80]   = `MEM_READ_DELAY MEM_ARRAY[{ADDRESS,4'b1010}];
        READDATA[95:88]   = `MEM_READ_DELAY MEM_ARRAY[{ADDRESS,4'b1011}];
        READDATA[103:96]  = `MEM_READ_DELAY MEM_ARRAY[{ADDRESS,4'b1100}];
        READDATA[111:104] = `MEM_READ_DELAY MEM_ARRAY[{ADDRESS,4'b1101}];
        READDATA[119:112] = `MEM_READ_DELAY MEM_ARRAY[{ADDRESS,4'b1110}];
        READDATA[127:120] = `MEM_READ_DELAY MEM_ARRAY[{ADDRESS,4'b1111}];
        BUSYWAIT = 0;
        READACCESS = 0;
    end
end
 
endmodule