`timescale 1ns / 1ps

module npc(
           input [31:0] PC,
           input isb,
           input isj,
           input [25:0] imm,
           output reg [31:0] NPC
       );

always @(*) begin
    case ({isb, isj})
        3'b10:
            NPC = PC + {{14{imm[15]}},imm[15:0], 2'b00};
        3'b01:
            NPC = {PC[31:28],imm[25:0], 2'b00};
        default:
            NPC = PC + 4;
    endcase
end

endmodule // npc
