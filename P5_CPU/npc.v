`timescale 1ns / 1ps

module npc(
           input [31:0] PC,
           input isb,
           input isjal,
           input [25:0] imm,
           input isjr,
           input [31:0] RA,
           output reg [31:0] NPC,
           output reg [31:0] PC4
       );

always @(*) begin
    PC4 = PC + 4;

    case ({isb, isjal, isjr})
        3'b100:
            NPC = PC + 4 + {{16{imm[15]}},imm[15:0]};
        3'b010:
            NPC = {PC[31:26],imm[25:0]};
        3'b001:
            NPC = RA;
        default:
            NPC = PC + 4;
    endcase
end

endmodule // npc
