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
