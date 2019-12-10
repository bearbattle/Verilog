`timescale 1ns / 1ps

`include "const.v"

module DController(
           input [31:0] IR,
           input Zero,
           input Neq,
           input Lez,
           input Gtz,
           input Ltz,
           input Gez,
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
                // jr
                `jr: begin
                    PCSel = `JRPC;
                end

                `jalr: begin
                    PCSel = `JRPC;
                end
                default: begin
                end
            endcase
        end

        //  cal_i
        `addi: begin
            EXTOp = `SE;
        end

        `addiu: begin
            EXTOp = `SE;
        end

        `andi: begin
            EXTOp = `UE;
        end

        `ori: begin
            EXTOp = `UE;
        end

        `xori: begin
            EXTOp = `UE;
        end

        `lui: begin
            EXTOp = `HE;
        end

        `slti: begin
            EXTOp = `SE;
        end

        `sltiu: begin
            EXTOp = `SE;
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

        `bne: begin
            isb = Neq;
            PCSel = `NPC;
        end

        `blez: begin
            isb = Lez;
            PCSel = `NPC;
        end

        `bgtz: begin
            isb = Gtz;
            PCSel = `NPC;
        end

        `bltz: begin
            isb = IR[20:16] == 5'd0 ? Ltz :
                IR[20:16] == 5'd0 ? Gez : 0;
            PCSel = `NPC;
        end

        // load
        `lb: begin
            EXTOp = `SE;
        end

        `lbu: begin
            EXTOp = `SE;
        end

        `lh: begin
            EXTOp = `SE;
        end

        `lhu: begin
            EXTOp = `SE;
        end

        `lw: begin
            EXTOp = `SE;
        end

        //  store
        `sb: begin
            EXTOp = `SE;
        end

        `sh: begin
            EXTOp = `SE;
        end

        `sw: begin
            EXTOp = `SE;
        end

        default: begin
        end
    endcase
end

endmodule
