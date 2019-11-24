`timescale 1ns / 1ps

`include "const.v"

module regD(
           input clk,
           input enD,
           input rst,
           input [31:0] IR,
           input [31:0] PC,
           input [4:0] A1,
           input [4:0] A2,
           input [4:0] A3,
           input [2:0] Tnew,
           input [2:0] Tuse1,
           input [2:0] Tuse2,
           output reg [31:0] IRD,
           output reg [31:0] PCD,
           output reg [4:0] A1D,
           output reg [4:0] A2D,
           output reg [4:0] A3D,
           output reg [2:0] TnewD,
           output reg [2:0] Tuse1D,
           output reg [2:0] Tuse2D
       );
initial begin
    IRD = 0;
    PCD = 0;
    A1D = 0;
    A2D = 0;
    A3D = 0;
    TnewD = 0;
    Tuse1D = 0;
    Tuse2D = 0;
end

always @(posedge clk) begin
    if(rst) begin
        IRD <= 0;
        PCD <= 0;
        A1D <= 0;
        A2D <= 0;
        A3D <= 0;
        TnewD <= 0;
        Tuse1D <= 0;
        Tuse2D <= 0;
    end
    else if(enD) begin
        IRD <= IR;
        PCD <= PC;
        A1D <= A1;
        A2D <= A2;
        A3D <= A3;
        TnewD <= Tnew;
        Tuse1D <= Tuse1;
        Tuse2D <= Tuse2;
    end
end


endmodule


    module regE(
        input clk,
        input FlushE,
        input [31:0] IR,
        input [31:0] PC,
        input [31:0] RS,
        input [31:0] RT,
        input [31:0] D32,
        output reg [31:0] IRE,
        output reg [31:0] PCE,
        output reg [31:0] RSE,
        output reg [31:0] RTE,
        output reg [31:0] D32E,
        // input [4:0] A1,
        // input [4:0] A2,
        input [4:0] A3,
        input [2:0] Tnew,
        // input [2:0] Tuse1,
        // input [2:0] Tuse2,
        // output reg [4:0] A1E,
        // output reg [4:0] A2E,
        output reg [4:0] A3E,
        output reg [2:0] TnewE
        // output reg [2:0] Tuse1E,
        // output reg [2:0] Tuse2E
    );

initial begin
    IRE = 0;
    PCE = 0;
    RSE = 0;
    RTE = 0;
    D32E = 0;
    // A1E = 0;
    // A2E = 0;
    A3E = 0;
    TnewE = 0;
    // Tuse1E = 0;
    // Tuse2E = 0;
end

always @(posedge clk) begin
    if(FlushE) begin
        IRE <= 0;
        PCE <= 0;
        RSE <= 0;
        RTE <= 0;
        D32E <= 0;
        // A1E <= 0;
        // A2E <= 0;
        A3E <= 0;
        TnewE <= 0;
        // Tuse1E <= 0;
        // Tuse2E <= 0;
    end
    else begin
        IRE <= IR;
        PCE <= PC;
        RSE <= RS;
        RTE <= RT;
        D32E <= D32;
        // A1E <= A1;
        // A2E <= A2;
        A3E <= A3;
        TnewE <= Tnew > 0 ? Tnew - 1 : 0;
        // Tuse1E <= Tuse1;
        // Tuse2E <= Tuse2;
    end
end

endmodule

    module regM(
        input clk,
        input rst,
        input [31:0] IR,
        input [31:0] PC,
        input [31:0] RT,
        input [31:0] AO,
        output reg [31:0] IRM,
        output reg [31:0] PCM,
        output reg [31:0] RTM,
        output reg [31:0] AOM,
        // input [4:0] A1,
        // input [4:0] A2,
        input [4:0] A3,
        input [2:0] Tnew,
        // input [2:0] Tuse1,
        // input [2:0] Tuse2,
        // output reg [4:0] A1M,
        // output reg [4:0] A2M,
        output reg [4:0] A3M,
        output reg [2:0] TnewM
        // output reg [2:0] Tuse1M,
        // output reg [2:0] Tuse2M
    );

initial begin
    IRM = 0;
    PCM = 0;
    RTM = 0;
    AOM = 0;
    // A1M = 0;
    // A2M = 0;
    A3M = 0;
    TnewM = 0;
    // Tuse1M = 0;
    // Tuse2M = 0;
end

always @(posedge clk) begin
    if(rst) begin
        IRM <= 0;
        PCM <= 0;
        RTM <= 0;
        AOM <= 0;
        // A1M <= 0;
        // A2M <= 0;
        A3M <= 0;
        TnewM <= 0;
        // Tuse1M <= 0;
        // Tuse2M <= 0;
    end
    else begin
        IRM <= IR;
        PCM <= PC;
        RTM <= RT;
        AOM <= AO;
        // A1M <= A1;
        // A2M <= A2;
        A3M <= A3;
        TnewM <= Tnew > 0 ? Tnew - 1 : 0;
        // Tuse1M <= Tuse1;
        // Tuse2M <= Tuse2;
    end
end

endmodule // regM

          module regW(
              input clk,
              input rst,
              input [31:0] IR,
              input [31:0] PC,
              input [31:0] DR,
              input [31:0] AO,
              output reg [31:0] IRW,
              output reg [31:0] PCW,
              output reg [31:0] DRW,
              output reg [31:0] AOW,
            //   input [4:0] A1,
            //   input [4:0] A2,
              input [4:0] A3,
              input [2:0] Tnew,
            //   input [2:0] Tuse1,
            //   input [2:0] Tuse2,
            //   output reg [4:0] A1W,
            //   output reg [4:0] A2W,
              output reg [4:0] A3W,
              output reg [2:0] TnewW
            //   output reg [2:0] Tuse1W,
            //   output reg [2:0] Tuse2W
          );

initial begin
    IRW = 0;
    PCW = 0;
    DRW = 0;
    AOW = 0;
    // A1W = 0;
    // A2W = 0;
    A3W = 0;
    TnewW = 0;
    // Tuse1W = 0;
    // Tuse2W = 0;
end

always @(posedge clk) begin
    if(rst) begin
        IRW <= 0;
        PCW <= 0;
        DRW <= 0;
        AOW <= 0;
        // A1W = 0;
        // A2W <= 0;
        A3W <= 0;
        TnewW <= 0;
        // Tuse1W <= 0;
        // Tuse2W <= 0;
    end
    else begin
        IRW <= IR;
        PCW <= PC;
        DRW <= DR;
        AOW <= AO;
        // A1W <= A1;
        // A2W <= A2;
        A3W <= A3;
        TnewW <= Tnew > 0 ? Tnew - 1 : 0;
        // Tuse1W <= Tuse1;
        // Tuse2W <= Tuse2;
    end
end

endmodule // regW

