`timescale 1ns / 1ps
`include "const.v"

module DController(
           input [31:0] IR,
           input Zero,
           output [1:0] EXTOp,
           output isj,
           output isb,
           output [1:0] PCSel
       );

assign EXTOp = IR[`OP] == `lui ? `HE :
       IR[`OP] == `ori ? `UE : `SE;

assign isj = (IR[`OP] == `jal || IR[`OP] == `j);
assign isb = (IR[`OP] == `beq) && Zero;

assign PCSel = (IR[`OP] == `R && IR[`FT] == `jr) ? 2'd2 :
       ((IR[`OP] == `beq) || (IR[`OP] == `jal) || (IR[`OP] == `j)) ? 2'd1 : 2'd0;
endmodule

    module EController(
        input [31:0] IR,
        output [1:0] ALUOp,
        output BSel
    );


assign ALUOp = (IR[`OP] == `lui) || (IR[`OP] == `ori) ? `OR :
       (IR[`OP] != `R) ? `ADD :
       (IR[`FT] == `subu) ? `SUB : `ADD;

assign BSel = (IR[`OP] == `lui) || (IR[`OP] == `ori) || (IR[`OP] == `lw) || (IR[`OP] == `sw) ? 1 : 0;

endmodule

    module MController(
        input [31:0] IR,
        output DMWr
    );


assign DMWr = IR[`OP] == `sw ? 1 : 0;

endmodule

    module WController(
        input [31:0] IR,
        output RFWr,
        output [1:0] WRSel,
        output [1:0] WDSel
    );

assign RFWr = (IR[`OP] == `lui) || (IR[`OP] == `ori) || (IR[`OP] == `lw) || (IR[`OP] == `R && IR[`FT] != `jr) || (IR[`OP] == `jal) ? 1 : 0;
assign WRSel = (IR[`OP] == `lw) || (IR[`OP] == `ori) || (IR[`OP] == `lui) ? 0 :
       (IR[`OP] == `jal) ? 2 : 1;
assign WDSel =  (IR[`OP] == `lw) ? 0 :
       (IR[`OP] == `jal) ? 2 : 1;

endmodule
