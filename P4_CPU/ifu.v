`timescale 1ns / 1ps
module ifu(
           input clk,
           input Reset,
           input isbeq,
           input isZero,
           input isjal,
           input [15:0] imm,
           input isjr,
           input [31:0] jrPC,
           output [31:0] Instruction,
           output [31:0] PC4,
           output [31:0] PC0
       );

//wire [31:0] InsAddr;

pc PC(.clk(clk), .Reset(Reset), .nPC(NPC.newPC));

npc NPC(.curPC(PC.InstructionAddress),
        .isbeq(isbeq),
        .isZero(isZero),
        .isjal(isjal),
        .imm(imm),
        .isjr(isjr),
        .jrPC(jrPC),
        .newPC(PC.nPC),
        .PC4(PC4));

im IM(.InstructionAddress(PC.InstructionAddress), .Instruction(Instruction));

assign PC0 = PC.InstructionAddress;

endmodule // ifu
