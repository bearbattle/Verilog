`timescale 1ns / 1ps

`include "const.v"

module DController(
           input [31:0] IR,
           input Zero,
           output reg [1:0] EXTOp,
           output reg isj,
           output reg isb,
           output reg [1:0] PCSel
       );

initial begin
    EXTOp = 0;
    isj = 0;
    isb = 0;
    PCSel = 0;
end

always @(*) begin
    EXTOp = 0;
    isj = 0;
    isb = 0;
    PCSel = 0;
    case (IR[`OP])
        // cal_r
        `R: begin
            case (IR[`FT])
                `addu: begin
                end

                `subu: begin
                end
                // jr
                `jr: begin
                    PCSel = `JRPC;
                end
                default: begin
                end
            endcase
        end

        //  cal_i
        `ori: begin
            EXTOp = `UE;
        end

        `lui: begin
            EXTOp = `HE;
        end

        //  link
        `jal: begin
            PCSel = `NPC;
            isj = 1;
        end

        // j
        `j: begin
            PCSel = `NPC;
            isj = 1;
        end

        // b
        `beq: begin
            isb = Zero;
            PCSel = `NPC;
        end

        // load
        `lw: begin
            EXTOp = `SE;
        end

        //  store
        `sw: begin
            EXTOp = `SE;
        end

        default: begin
        end
    endcase
end

endmodule