`timescale 1ns / 1ps
`include "const.v"

module DController(
           input [31:0] IR,
           output [1:0] EXTOp
       );

wire opcode = IR[31:26];

assign EXTOp = opcode == `lui ? `HE :
       opcode == `ori ? `UE : `SE;

endmodule

    module EController(
        input [31:0] IR,
        output [1:0] ALUOp,
        output BSel
    );

wire opcode = IR[31:26];
wire funct = IR[5:0];

assign ALUOp = (opcode == `lui) || (opcode == `ori) ? `OR :
       (opcode != `R) ? `ADD :
       (funct == `SUB) ? `SUB : `ADD;

assign BSel = (opcode == `lui) || (opcode == `ori) || (opcode == `lw) || (opcode == `sw) ? 1 : 0;

endmodule

    module MController(
        input [31:0] IR,
        output DMWr
    );

wire opcode = IR[31:26];

assign DMWr = opcode == `sw ? 1 : 0;

endmodule

    module WController(
        input [31:0] IR,
        output RFWr,
        output [1:0] WRSel,
        output [1:0] WDSel
    );

wire opcode = IR[31:26];
wire funct = IR[5:0];

assign RFWr = (opcode == `lui) || (opcode == `ori) || (opcode == `lw) || (opcode == `R && funct != `jr) || (opcode == `jal) ? 1 : 0;
assign WRSel = (opcode == `lw) || (opcode == `ori) || (opcode == `lui) ? 0 :
       (opcode == `jal) ? 2 : 1;
assign WDSel =  (opcode == `lw) ? 0 :
       (opcode == `jal) ? 2 : 1;

endmodule

    module StallController(
        input [31:0] IRD,
        input [31:0] IRE,
        input [31:0] IRM,
        output enPC,
        output enD,
        output FlushE
    );

wire stall_b, stall_b_c_r, stall_b_c_i, stall_b_l_E, stall_b_l_M;
wire stall_c_r;
wire stall_c_i;
wire stall_l;
wire stall_s;

wire stall;

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

assign stall_b_c_r = (IRDOP == `beq) && (IREOP == `R) && ((IRDRS == IRERD) || (IRDRT == IRERD));
assign stall_b_c_i = (IRDOP == `beq) && ((IREOP == `ori) || (IREOP == `lui)) && ((IRDRS == IRERT) || (IRDRT == IRERT));
assign stall_b_l_E = (IRDOP == `beq) && (IREOP == `R) && ((IRDRS == IRERD) || (IRDRT == IRERD));
assign stall_b_l_M = (IRDOP == `beq) && (IRMOP == `R) && ((IRMRS == IRERD) || (IRMRT == IRERD));
assign stall_b = stall_b_c_r || stall_b_c_i || stall_b_l_E || stall_b_l_M;

assign stall_c_r = ( (IRDOP == `R) ) &&
       ((IREOP == `lw) && ((IRERT == IRDRS) || (IRERT == IRDRT)));

assign stall_c_i = ((IRDOP == `ori) || (IRDOP == `lui)) &&
       ((IREOP == `lw) && ((IRERT == IRDRS) ));

assign stall_l = (IRDOP == `lw) &&
       ((IREOP == `lw) && (IRERT == IRERS));

assign stall_s = (IRDOP == `sw) &&
       ((IREOP == `lw) && (IRERT == IRERS));

assign stall = stall_b || stall_c_r || stall_c_i || stall_l || stall_s;

assign enPC = ~stall;
assign enD = ~stall;
assign FlushE = stall;

endmodule

    module forward(
        input [31:0] IRD,
        input [31:0] IRE,
        input [31:0] IRM,
        input [31:0] IRW,
        output reg [2:0] FRSDSel,
        output reg [2:0] FRTDSel,
        output reg [2:0] FRSESel,
        output reg [2:0] FRTESEl,
        output reg [2:0] FRTMSel
    );

initial begin
    FRSDSel = 0;
    FRTDSel = 0;
    FRSESel = 0;
    FRTESEl = 0;
    FRTMSel = 0;
end

always @(*) begin
    FRSDSel = 0;
    FRTDSel = 0;
    FRSESel = 0;
    FRTESEl = 0;
    FRTMSel = 0;
    if(IRD[`OP] == beq || (IRD[`OP] == `R && IRD[`FT] == `jr)) begin
        case(IRM[`OP])
            `R: begin
                if(IRM[`FT] != `jr)
                    FRSDSel = 4;
            end
            
        endcase
    end

endmodule
