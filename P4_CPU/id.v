module id(
    input [31:0] Instruction,
    output [5:0] opcode,
    output [5:0] funct,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [15:0] imm
);

assign {opcode, rs, rt, rd} = Instruction[31:11];
assign funct = Instruction[5:0];
assign imm = Instruction[15:0];

endmodule // id