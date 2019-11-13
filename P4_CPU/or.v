`timescale 1ns / 1ps

module Or( input ori,
           input lw,
           input sw,
           input beq,
           input lui,
           input jal,
           input addu,
           input subu,
           input jr,
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

assign isbeq = beq;
assign isjal = jal;
assign isjr = jr;
assign GRF_A3_MUX[0] = ori | lw | lui;
assign GRF_A3_MUX[1] = jal;
assign GRF_WD_MUX[0] = lw | jal;
assign GRF_WD_MUX[1] = lui | jal;
assign GRF_WE = addu | subu | ori | lw | lui | jal;
assign ALU_B_MUX = ori | lw | sw;
assign ALUOp[0] = subu;
assign ALUOp[1] = ori;
assign DM_WE = sw;
assign EXTOp[0] = lw | sw;
assign EXTOp[1] = lui;

endmodule // And
