module instruction_cache(CLK, RESET, ADDRESS, READDATA, BUSYWAIT, MEM_ADDRESS, MEM_READ, MEM_READDATA, MEM_BUSYWAIT);

//Declare ports
input [31:0] ADDRESS;
input [127:0] MEM_READDATA;
input CLK, RESET, MEM_BUSYWAIT;
output reg [31:0] READDATA;
output reg BUSYWAIT;
output reg [27:0] MEM_ADDRESS;
output reg MEM_READ;

//Create reg arrays in cache
reg [127:0] DATA [0:7];
reg VALID [0:7];
reg [24:0] TAG [0:7];

//set busywait when a pc value is sent to the cache when the ADDRESS is not -4
always @ (ADDRESS)
begin
    if(ADDRESS != -32'd4) BUSYWAIT = 1;
end
    
//wires to store the extracted values depending on the index part of the address
wire VALID_OUT;
wire [127:0] DATA_OUT;
wire [24:0] TAG_OUT;

//Obtaining the stored values from the register array depending on the index
assign #1 DATA_OUT = DATA[ADDRESS[6:4]];
assign #1 VALID_OUT = VALID[ADDRESS[6:4]];
assign #1 TAG_OUT = TAG[ADDRESS[6:4]];


// tag compare and determining the hit status
wire TAG_STATUS, HIT;
assign #1 TAG_STATUS = (TAG_OUT == ADDRESS[31:7]) ? 1 : 0;
assign HIT = VALID_OUT & TAG_STATUS;

//clear busywait at positive clock edge and when there is a hit
always @ (posedge CLK)
begin
    if (HIT) BUSYWAIT = 0;
end

//select data from offsets if it is a hit else send dont care to the CPU
//instruction is sent to the CPU only if its a hit because if not some garbage instruction will be sent to the CPU
//if this garbage instruction is a Store instruction, the data in the data cache will be corrupted.
always @ (*)
begin
    #1
    if (HIT)
    begin
        case (ADDRESS[3:2])
            2'b00 : READDATA = DATA_OUT[31:0];
            2'b01 : READDATA = DATA_OUT[63:32];
            2'b10 : READDATA = DATA_OUT[95:64];
            2'b11 : READDATA = DATA_OUT[127:96];
        endcase
    end
    else 
        READDATA = 32'bx;
end



/* Cache Controller FSM Start */
parameter IDLE = 2'b00, READ_MEM = 2'b01, UPDATE_CACHE = 2'b10;
reg [1:0] STATE, NEXT_STATE;

// combinational next state logic
always @(*)
begin
    case (STATE)
        IDLE:
            if (!HIT && (ADDRESS != -32'd4))  
               NEXT_STATE = READ_MEM;
            else
                NEXT_STATE = IDLE;
            
        READ_MEM:
            if (!MEM_BUSYWAIT)
                NEXT_STATE = UPDATE_CACHE;
            else    
                NEXT_STATE = READ_MEM;

        UPDATE_CACHE:
            NEXT_STATE = IDLE;
            
    endcase
end

// combinational output logic
always @(STATE)
begin
    case(STATE)
        IDLE:
        begin
            MEM_READ = 0;
            MEM_ADDRESS = 28'dx;
        end
         
        READ_MEM: 
        begin
            MEM_READ = 1;
            MEM_ADDRESS = {ADDRESS[31:4]};
        end

        UPDATE_CACHE:
        begin
            MEM_READ = 0;
            #1
            DATA[ADDRESS[6:4]] = MEM_READDATA;
            VALID[ADDRESS[6:4]] = 1;
            TAG[ADDRESS[6:4]] = ADDRESS[31:7];
        end
            
    endcase
end

// sequential logic for state transitioning 
always @ (posedge CLK, RESET)
begin
    if(RESET)
        STATE = IDLE;
    else
        STATE = NEXT_STATE;
end

//reset the cache memory when the reset signal is high
integer i;

always @ (RESET)
begin
    if(RESET)
    begin
        for ( i = 0; i < 8; i = i + 1)
        begin
            VALID[i] = 0;
            TAG[i] = 25'bx;
            BUSYWAIT = 0;
            DATA[i] = 128'dx;
        end
    end
end
     
endmodule