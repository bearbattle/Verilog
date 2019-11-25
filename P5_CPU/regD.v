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