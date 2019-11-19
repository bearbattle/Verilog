`timescale 1 ns / 1ps

module id(
    input [31:0] Instruction,
    output [5:0] opcode,
    output [5:0] funct,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [15:0] imm,
    output [25:0] ins_index
);

assign {opcode, rs, rt, rd} = Instruction[31:11];
assign funct = Instruction[5:0];
assign imm = Instruction[15:0];
assign ins_index = Instruction[25:0];

endmodule // id