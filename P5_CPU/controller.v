`timescale 1ns / 1ps

parameter ADD = 2'b00;
parameter SUB = 2'b01;
parameter OR = 2'b10;

parameter UE = 2'b00;
parameter SE = 2'b01;
parameter HE = 2'b10;

parameter R   = 6'b000000;
parameter ori = 6'b001101;
parameter lw  = 6'b100011;
parameter sw  = 6'b101011;
parameter beq = 6'b000100;
parameter lui = 6'b001111;
parameter jal = 6'b000011;

parameter addu = 6'b100001;
parameter subu = 6'b100011;
parameter jr   = 6'b001000;

module DController(
    input [31:0] IR,
    output [1:0] EXTOp
);

wire opcode = IR[31:26];

assign EXTOp = opcode == lui ? HE :
                opcode == ori ? UE : SE;

endmodule

module EController(
    input [31:0] IR,
    output [1:0] ALUOp,
    output BSel
);

wire opcode = IR[31:26];
wire funct = IR[5:0];

assign ALUOp = (opcode == lui) || (opcode == ori) ? OR :
               (opcode != R) ? ADD : 
               (funct == SUB) ? SUB : ADD;

assign BSel = (opcode == lui) || (opcode == ori) || (opcode == lw) || (opcode == sw) ? 1 : 0;

endmodule

module MController(
    input [31:0] IR,
    output DMWr
);

wire opcode = IR[31:26];

assign DMWr = opcode == sw ? 1 : 0;

endmodule

module WController(
    input [31:0] IR,
    output RFWr,
    output [1:0] WRSel,
    output [1:0] WDSel
);

wire opcode = IR[31:26];
wire funct = IR[5:0];

assign RFWr = (opcode == lui) || (opcode == ori) || (opcode == lw) || (opcode == R && funct != jr) || (opcode == jal) ? 1 : 0;
assign WRSel = (opcode == lw) || (opcode == ori) || (opcode == lui) ? 0 :
                (opcode == jal) ? 2 : 1;
assign WDSel =  (opcode == lw) ? 0 :
                (opcode == jal) ? 2 : 1;

endmodule

module StallController(
    input [31:0] IRD,
    input [31:0] IRE,
    input [31:0] IRM,
    output enPC,
    output enD,
    output FlushE
);

wire stall_b, stall_b_c_r, stall_b_c_i, stall_b_l;
wire stall_c_r
wire stall_c_i
wire stall_l
wire stall_s

wire stall

wire [5:0] IRDOP = IRD[31:26];
wire [5:0] IRDFT = IRD[5:0];
wire [4:0] IRDRS = IRD[25:21];
wire [4:0] IRDRT = IRD[20:16];
wire [4:0] IRDRD = IRD[15:11];

wire [5:0] IREOP = IRE[31:26];
wire [5:0] IREFT = IRE[5:0];
wire [4:0] IRERS = IRE[25:21];
wire [4:0] IRERT = IRE[20:16];
wire [4:0] IRERD = IRE[15:11];


wire [5:0] IRMOP = IRM[31:26];
wire [5:0] IRMFT = IRM[5:0];
wire [4:0] IRMRS = IRM[25:21];
wire [4:0] IRMRT = IRM[20:16];
wire [4:0] IRMRD = IRM[15:11];

assign stall_b_c_r = (IRDOP == beq) && (IREOP == R) && ((IRDRS == IRERD) || (IRDRT == IRERD));
assign stall_b_c_i = (IRDOP == beq) && ((IREOP == ori) || (IREOP == lui)) && ((IRDRS == IRERT) || (IRDRT == IRERT));
assign stall_b_l = (IRDOP == beq) && (IREOP == R) && ((IRDRS == IRERD) || (IRDRT == IRERD));



endmodule
