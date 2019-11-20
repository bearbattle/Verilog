`timescale 1ns / 1ps

module npc(
           input [31:0] PC4,
           input isb,
           input isj,
           input [25:0] imm,
           output reg [31:0] NPC
       );

always @(*) begin
    case ({isb, isj})
        3'b10:
            NPC = PC4 + {{16{imm[15]}},imm[15:0]};
        3'b01:
            NPC = {PC4[31:26],imm[25:0]};
        default:
            NPC = PC4;
    endcase
end

endmodule // npc
