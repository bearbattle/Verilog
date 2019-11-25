`timescale 1ns / 1ps

`include "const.v"

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

