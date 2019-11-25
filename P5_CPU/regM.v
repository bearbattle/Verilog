`timescale 1ns / 1ps

`include "const.v"

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
        input [4:0] A2,
        input [4:0] A3,
        input [2:0] Tnew,
        // input [2:0] Tuse1,
        // input [2:0] Tuse2,
        // output reg [4:0] A1M,
        output reg [4:0] A2M,
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
    A2M = 0;
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
        A2M <= 0;
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
        A2M <= A2;
        A3M <= A3;
        TnewM <= Tnew > 0 ? Tnew - 1 : 0;
        // Tuse1M <= Tuse1;
        // Tuse2M <= Tuse2;
    end
end

endmodule // regM