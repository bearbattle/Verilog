`timescale 1ns / 1ps

`include "const.v"

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
           input [4:0] A1,
           input [4:0] A2,
           input [4:0] A3,
           input [2:0] Tnew,
           // input [2:0] Tuse1,
           // input [2:0] Tuse2,
           output reg [4:0] A1E,
           output reg [4:0] A2E,
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
        A1E <= 0;
        A2E <= 0;
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
        A1E <= A1;
        A2E <= A2;
        A3E <= A3;
        TnewE <= Tnew > 0 ? Tnew - 1 : 0;
        // Tuse1E <= Tuse1;
        // Tuse2E <= Tuse2;
    end
end

endmodule
