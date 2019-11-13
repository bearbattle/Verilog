`timescale 1ns / 1ps

module mips(
           input clk,
           input reset
       );

ifu IFU(.clk(clk),
        .Reset(reset),
        .isZero(ALU.Zero),
        .imm(ID.imm),
        .jrPC(GRF.ReadData2)
       );

id ID(.Instruction(IFU.Instruction));

alu ALU(
        .A(GRF.ReadData1),
        .B(ALU_B.result));

mux_2_32 ALU_B(
             .option0(GRF.ReadData2),
             .option1(EXT.D32)
         );

ext EXT(
        .imm16(ID.imm));

dm DM(
       .clk(clk),
       .Reset(reset),
       .WriteAddress(ALU.C),
       .WriteData(GRF.ReadData2),
       .ReadAddress(ALU.C)
   );

grf GRF(
        .clk(clk),
        .Reset(reset),
        .ReadAddress1(ID.rs),
        .ReadAddress2(ID.rt),
        .WriteAddress(GRF_A3.result),
        .WriteData(GRF_WD.result)
    );

mux_4_5 GRF_A3(
            .option0(ID.rd),
            .option1(ID.rt),
            .option2(5'd31)
        );

mux_4_32 GRF_WD(
             .option0(ALU.C),
             .option1(DM.ReadData),
             .option2(EXT.D32),
             .option3(IFU.PC4)
         );

controller Controller(
               .opcode(ID.opcode),
               .funct(ID.funct),
               .isbeq(IFU.isbeq),
               .isjal(IFU.isjal),
               .isjr(IFU.isjr),
               .GRF_A3_MUX(GRF_A3.sel),
               .GRF_WD_MUX(GRF_WD.sel),
               .GRF_WE(GRF.WriteEnable),
               .ALU_B_MUX(ALU_B.sel),
               .ALUOp(ALU.ALUOp),
               .DM_WE(DM.WriteEnable),
               .EXTOp(EXT.EXTOp)
           );

endmodule // mips
