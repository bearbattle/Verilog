`timescale 1ns / 1ps
module npc(
           input [31:0] curPC,
           input isbeq,
           input isZero,
           input isjal,
           input [15:0] imm,
           input isjr,
           input [31:0] jrPC,
           output reg [31:0] newPC,
           output reg [31:0] PC4
       );

always @(*) begin
    case ({isbeq, isjal, isjr})
        3'b000: begin
            newPC <= curPC +4;
        end
        3'b100: begin
            if(isZero) begin
                newPC <= curPC + 4 + {{14{imm[15]}}, imm, 2{0}};
            end
            else
                newPC <= curPC + 4;
        end
        3'b010: begin
            PC4 <= curPC + 4;
            newPC <= curPC + 4 + {{16{imm[15]}},imm};
        end
        3'b001: begin
            newPC <= jrPC;
        end
        default:
            newPC <= curPC + 4;
    endcase
end

endmodule // npc
