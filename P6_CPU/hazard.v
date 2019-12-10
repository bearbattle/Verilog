`timescale 1ns / 1ps

`include "const.v"

module StallController(
           //    input [31:0] IRD,
           //    input [31:0] IRE,
           //    input [31:0] IRM,
           output enPC,
           output enD,
           output FlushE
       );

reg stall_e;
reg stall_m;
reg stall_w;
reg stall_md;

wire stall;

assign stall = stall_e | stall_m | stall_w | stall_md;

initial begin
    stall_e = 0;
    stall_m = 0;
    stall_w = 0;
    stall_md = 0;
end

always@(*) begin
    stall_e = 0;
    stall_m = 0;
    stall_w = 0;
    stall_md = 0;
    // E:A1
    if(D.A1D != 0 && E.A3E == D.A1D && E.TnewE > D.Tuse1D)
        stall_e = 1;
    // E:A2
    if(D.A2D != 0 && E.A3E == D.A2D && E.TnewE > D.Tuse2D)
        stall_e = 1;

    // M:A1
    if(D.A1D != 0 && M.A3M == D.A1D && M.TnewM > D.Tuse1D)
        stall_m = 1;
    // M:A2
    if(D.A2D != 0 && M.A3M == D.A2D && M.TnewM > D.Tuse2D)
        stall_m = 1;

    if((D.IRD[`OP] == `mult || D.IRD[`OP] == `multu
            || D.IRD[`OP] == `div || D.IRD[`OP] == `divu
            || D.IRD[`OP] == `mfhi || D.IRD[`OP] == `mflo
            || D.IRD[`OP] == `mthi || D.IRD[`OP] == `mtlo) && MDU.Tnew > 1)
        stall_md = 1;
end

assign enPC = ~stall;
assign enD = ~stall;
assign FlushE = stall;

endmodule

    module ForwardController(
        // input [31:0] IRD,
        // input [31:0] IRE,
        // input [31:0] IRM,
        // input [31:0] IRW,
        output reg [2:0] FRSDSel,
        output reg [2:0] FRTDSel,
        output reg [2:0] FRSESel,
        output reg [2:0] FRTESel,
        output reg [2:0] FRTMSel
    );

initial begin
    FRSDSel = 0;
    FRTDSel = 0;
    FRSESel = 0;
    FRTESel = 0;
    FRTMSel = 0;
end

always @(*) begin
    FRSDSel = 0;
    FRTDSel = 0;
    FRSESel = 0;
    FRTESel = 0;
    FRTMSel = 0;

    // D A1
    if (D.A1D != 0) begin
        if (M.A3M == D.A1D && M.TnewM == 0)
            FRSDSel = 2;
        else if (W.A3W == D.A1D && W.TnewW == 0) 
            FRSDSel = 1;
    end

    // D A2
    if (D.A2D != 0) begin
        if (M.A3M == D.A2D && M.TnewM == 0)
            FRTDSel = 2;
        else if (W.A3W == D.A2D && W.TnewW == 0)
            FRTDSel = 1;
    end

    // E A1
    if(E.A1E != 0) begin
        if (M.A3M == E.A1E && M.TnewM == 0)
            FRSESel = 2;
        else if (W.A3W == E.A1E && W.TnewW == 0)
            FRSESel = 1;
    end

    // E A2
    if(E.A2E != 0) begin
        if (M.A3M == E.A2E && M.TnewM == 0)
            FRTESel = 2;
        else if (W.A3W == E.A2E && W.TnewW == 0)
            FRTESel = 1;
    end

    // M A2
    if(M.A2M != 0)
        if (W.A3W == M.A2M && W.TnewW == 0)
            FRTMSel = 1;
end

endmodule
