`timescale 1ns / 1ps
`include "const.v"

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

StallController SCtrl(
    .IRD(D.IRD),
    .IRE(E.IRE),
    .IRM(M.IRM)
    );

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
    .PC4(ADD4.PC4));

//ID

DController DCtrl(.IR(D.IRD),
    .Zero(CMP.Zero));

grf RF(.clk(clk),
    .rst(reset),
    .A1(D.IRD[`RS]),
    .A2(D.IRD[`RT]),
    .Wr(WCtrl.RFWr),
    .A3(M3.result),
    .WD(M4.result)
    );

ext EXT(.imm16(D.IRD[15:0]),
    .EXTOp(DCtrl.EXTOp));

cmp CMP(.RS(MFRSD.result),
    .RT(MFRTD.result));

npc NPC(.isb(DCtrl.isb),
    .isj(DCtrl.isj),
    .PC4(D.PC4D),
    .imm(D.IRD[25:0]));

mux_5_32 MFRSD(
    .sel(FCtrl.FRSDSel),
    .option0(RF.RD1),
    .option1(M4.result),
    .option2(W.PC4W + 4),
    .option3(M.AOM),
    .option4(M.PC4M + 4)
    );

mux_5_32 MFRTD(
    .sel(FCtrl.FRTDSel),
    .option0(RF.RD2),
    .option1(M4.result),
    .option2(W.PC4W + 4),
    .option3(M.AOM),
    .option4(M.PC4M + 4)
    );

// ID/EX

regE E(
    .clk(clk),
    .FlushE(SCtrl.FlushE | reset),
    .IR(D.IRD),
    .PC4(D.PC4D),
    .RS(MFRSD.result),
    .RT(MFRTD.result),
    .D32(EXT.D32)
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
    .option2(W.PC4W + 4),
    .option3(M.AOM),
    .option4(M.PC4M + 4)
    );

mux_5_32 MFRTE(
    .sel(FCtrl.FRTESel),
    .option0(E.RTE),
    .option1(M4.result),
    .option2(W.PC4W + 4),
    .option3(M.AOM),
    .option4(M.PC4M + 4)
    );

// EX/MEM

regM M(.clk(clk),
    .rst(reset),
    .IR(E.IRE),
    .PC4(E.PC4E),
    .AO(ALU.C),
    .RT(MFRTE.result)
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

mux_4_32 MFRTM(
    .sel(FCtrl.FRTMSel),
    .option0(M.RTM),
    .option1(M4.result),
    .option2(W.PC4W + 4)
    );

// MEM/WB

regW W(
    .clk(clk),
    .rst(reset),
    .IR(M.IRM),
    .PC4(M.PC4M),
    .DR(DM.DR),
    .AO(M.AOM)
    );

// WB

WController WCtrl(.IR(W.IRW));

mux_4_5 M3(
    .sel(WCtrl.WRSel),
    .option0(W.IRW[`RT]),
    .option1(W.IRW[`RD]),
    .option2(5'h1F)
);

mux_4_32 M4(
    .sel(WCtrl.WDSel),
    .option0(W.DRW),
    .option1(W.AOW),
    .option2(W.PC4W + 4)
    );

endmodule // mips
