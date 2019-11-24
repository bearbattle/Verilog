`timescale 1ns / 1ps

module mips(
           input clk,
           input reset
       );
// Controller
ForwardController FCtrl(
                      .IRD(D.IRD),
                      .IRE(E.IRE),
                      .IRM(M.IRM),
                      .IRW(W.IRW)
                  );

// StallController SCtrl(
//                     .IRD(D.IRD),
//                     .IRE(E.IRE),
//                     .IRM(M.IRM)
//                 );
StallController SCtrl();

atcoder AT(.IR(IM.Instruction));

//IF

pc PC(.clk(clk),
      .rst(reset),
      .enPC(SCtrl.enPC),
      .NPC(M1.result));

im IM(.PC(PC.PC));

add4 ADD4(.PC(PC.PC));

mux_4_32 M1(.option0(ADD4.PC4),
            .option1(NPC.NPC),
            .option2(MFRSD.result),
            .sel(DCtrl.PCSel));

// IF/ID
regD D(.clk(clk),
       .rst(reset),
       .enD(SCtrl.enD),
       .IR(IM.Instruction),
       .PC(PC.PC),
       .A1(AT.A1),
       .A2(AT.A2),
       .A3(AT.A3),
       .Tnew(AT.Tnew),
       .Tuse1(AT.Tuse1),
       .Tuse2(AT.Tuse2)
       );

//ID

DController DCtrl(.IR(D.IRD),
                  .Zero(CMP.Zero));

grf RF(.clk(clk),
       .rst(reset),
       .A1(D.A1D),
       .A2(D.A2D),
       .Wr(WCtrl.RFWr),
       .A3(W.A3W),
       .WD(M4.result)
      );

ext EXT(.imm16(D.IRD[15:0]),
        .EXTOp(DCtrl.EXTOp));

cmp CMP(.RS(MFRSD.result),
        .RT(MFRTD.result));

npc NPC(.isb(DCtrl.isb),
        .isj(DCtrl.isj),
        .PC(D.PC),
        .imm(D.IRD[25:0]));

mux_5_32 MFRSD(
             .sel(FCtrl.FRSDSel),
             .option0(RF.RD1),
             .option1(M4.result),
             .option2(W.PCW + 8),
             .option3(M.AOM),
             .option4(M.PCM + 8)
         );

mux_5_32 MFRTD(
             .sel(FCtrl.FRTDSel),
             .option0(RF.RD2),
             .option1(M4.result),
             .option2(W.PCW + 8),
             .option3(M.AOM),
             .option4(M.PCM + 8)
         );

// ID/EX

regE E(
         .clk(clk),
         .FlushE(SCtrl.FlushE | reset),
         .IR(D.IRD),
         .PC(D.PCD),
         .RS(MFRSD.result),
         .RT(MFRTD.result),
         .D32(EXT.D32),
         .A3(D.A3D),
         .Tnew(D.TnewD)
     );

//EX

EController ECtrl(.IR(E.IRE));

alu ALU(.A(MFRSE.result),
        .B(M2.result),
        .ALUOp(ECtrl.ALUOp));

mux_2_32 M2(
             .sel(ECtrl.BSel),
             .option0(MFRTE.result),
             .option1(E.D32E)
         );

mux_5_32 MFRSE(
             .sel(FCtrl.FRSESel),
             .option0(E.RSE),
             .option1(M4.result),
             .option2(W.PCW + 8),
             .option3(M.AOM),
             .option4(M.PCM + 8)
         );

mux_5_32 MFRTE(
             .sel(FCtrl.FRTESel),
             .option0(E.RTE),
             .option1(M4.result),
             .option2(W.PCW + 8),
             .option3(M.AOM),
             .option4(M.PCM + 8)
         );

// EX/MEM

regM M(.clk(clk),
       .rst(reset),
       .IR(E.IRE),
       .PC(E.PCE),
       .AO(ALU.C),
       .RT(MFRTE.result),
       .A3(E.A3E),
       .Tnew(E.TnewE)
      );

// MEM

MController MCtrl(.IR(M.IRM));

dm DM(
       .clk(clk),
       .rst(reset),
       .A(M.AOM),
       .WD(MFRTM.result),
       .Wr(MCtrl.DMWr)
   );

mux_5_32 MFRTM(
             .sel(FCtrl.FRTMSel),
             .option0(M.RTM),
             .option1(M4.result),
             .option2(W.PCW + 8)
         );

// MEM/WB

regW W(
         .clk(clk),
         .rst(reset),
         .IR(M.IRM),
         .PC(M.PCM),
         .DR(DM.DR),
         .AO(M.AOM),
         .A3(M.A3M),
         .Tnew(M.TnewM)
     );

// WB

WController WCtrl(.IR(W.IRW));

mux_4_32 M4(
             .sel(WCtrl.WDSel),
             .option0(W.DRW),
             .option1(W.AOW),
             .option2(W.PCW + 8)
         );

endmodule // mips
