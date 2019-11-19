`timescale 1ns / 1ps

module mips(
           input clk,
           input reset
       );

ifu IFU(.clk(clk),
        .Reset(reset),
        .isZero(ALU.Zero),
        .imm(ID.imm),
        .jrPC(GRF.ReadData1),
        .jalPC(ID.ins_index),
        .isbeq(Ctrl.isbeq),
        .isjal(Ctrl.isjal),
        .isjr(Ctrl.isjr)
       );

id ID(.Instruction(IFU.Instruction));

alu ALU(
        .A(GRF.ReadData1),
        .B(ALU_B.result),
        .ALUOp(Ctrl.ALUOp));

mux_2_32 ALU_B(
             .option0(GRF.ReadData2),
             .option1(EXT.D32),
             .sel(Ctrl.ALU_B_MUX)
         );

ext EXT(
        .imm16(ID.imm),
        .EXTOp(Ctrl.EXTOp)
    );

dm DM(
       .clk(clk),
       .Reset(reset),
       .WriteEnable(Ctrl.DM_WE),
       .WriteAddress(ALU.C),
       .WriteData(GRF.ReadData2),
       .ReadAddress(ALU.C)
   );

grf GRF(
        .clk(clk),
        .Reset(reset),
        .ReadAddress1(ID.rs),
        .ReadAddress2(ID.rt),
        .WriteEnable(Ctrl.GRF_WE),
        .WriteAddress(GRF_A3.result),
        .WriteData(GRF_WD.result)
    );

mux_4_5 GRF_A3(
            .option0(ID.rd),
            .option1(ID.rt),
            .option2(5'd31),
            .sel(Ctrl.GRF_A3_MUX)
        );

mux_4_32 GRF_WD(
             .option0(ALU.C),
             .option1(DM.ReadData),
             .option2(EXT.D32),
             .option3(IFU.PC4),
             .sel(Ctrl.GRF_WD_MUX)
         );

controller Ctrl(
               .opcode(ID.opcode),
               .funct(ID.funct)
           );

endmodule // mips
