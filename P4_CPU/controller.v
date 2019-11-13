`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    01:27:53 11/13/2019
// Design Name:
// Module Name:    controller
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module controller(input [5:0] opcode,
                  input [5:0] funct,
                  output isbeq,
                  output isjal,
                  output isjr,
                  output [1:0] GRF_A3_MUX,
                  output [1:0] GRF_WD_MUX,
                  output GRF_WE,
                  output ALU_B_MUX,
                  output [1:0] ALUOp,
                  output DM_WE,
                  output [1:0] EXTOp);


Or OR(
	.isbeq(isbeq),
	.isjal(isjal),
	.isjr(isjr),
	.GRF_A3_MUX(GRF_A3_MUX),
	.GRF_WD_MUX(GRF_WD_MUX),
	.GRF_WE(GRF_WE),
	.ALU_B_MUX(ALU_B_MUX),
	.ALUOp(ALUOp),
	.DM_WE(DM_WE),
	.EXTOp(EXTOp),
	.ori(AND.isori),
	.lw(AND.islw),
	.sw(AND.issw),
	.beq(AND.isbeq),
	.lui(AND.islui),
	.jal(AND.isjal),
	.addu(AND.isaddu),
	.subu(AND.issubu),
	.jr(AND.isjr)
);
And AND(.opcode(opcode),
	.funct(funct),
	.isori(OR.ori),
	.islw(OR.lw),
	.issw(OR.sw),
	.isbeq(OR.beq),
	.islui(OR.lui),
	.isjal(OR.jal),
	.isaddu(OR.addu),
	.issubu(OR.subu),
	.isjr(OR.jr)
);

// .ori(AND.isori),
// .lw(AND.islw),
// .sw(AND.issw),
// .beq(AND.isbeq),
// .lui(AND.islui),
// .jal(AND.isjal),
// .addu(AND.isaddu),
// .subu(AND.issubu),
// .jr(AND.isjr)
endmodule
