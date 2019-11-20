`timescale 1ns / 1ps

`include "const.v"

module regD(
        input clk,
        input enD,
        input rst,
        input [31:0] IR,
        input [31:0] PC4,
        output reg [31:0] IRD,
        output reg [31:0] PC4D
       );
initial begin
    IRD = 0;
    PC4D = 0;
end

always @(posedge clk) begin
    if(enD) begin
        IRD = IR;
        PC4D = PC4;
    end
    if(rst) begin
        IRD = 0;
        PC4D = 0;
    end
end


endmodule


module regE(
    input clk,
    input FlushE,
    input [31:0] IR,
    input [31:0] PC4,
    input [31:0] RS,
    input [31:0] RT,
    input [31:0] D32,
    output reg [31:0] IRE,
    output reg [31:0] PC4E,
    output reg [31:0] RSE,
    output reg [31:0] RTE,
    output reg [31:0] D32E
);

initial begin
    IRE = 0;
    PC4E = 0;
    RSE = 0;
    RTE = 0;
    D32E = 0;
end

always @(posedge clk) begin
    IRE = IR;
    PC4E = PC4;
    RSE = RS;
    RTE = RT;
    D32E = D32;
    if(FlushE) begin
        IRE = 0;
        PC4E = 0;
        RSE = 0;
        RTE = 0;
        D32E = 0;
    end
end

endmodule

module regM(
    input clk,
    input rst,
    input [31:0] IR,
    input [31:0] PC4,
    input [31:0] RT,
    input [31:0] AO,
    output reg [31:0] IRM,
    output reg [31:0] PC4M,
    output reg [31:0] RTM,
    output reg [31:0] AOM
);

initial begin
    IRM = 0;
    PC4M = 0;
    RTM = 0;
    AOM = 0;
end

always @(posedge clk) begin
    IRM = IR;
    PC4M = PC4;
    RTM = RTM;
    AOM = AO;
    if(rst) begin
        IRM = 0;
        PC4M = 0;
        RTM = 0;
        AOM = 0;
    end
end

endmodule // regM

module regW(
    input clk,
    input rst,
    input [31:0] IR,
    input [31:0] PC4,
    input [31:0] DR,
    input [31:0] AO,
    output reg [31:0] IRW,
    output reg [31:0] PC4W,
    output reg [31:0] DRW,
    output reg [31:0] AOW
);

initial begin
    IRW = 0;
    PC4W = 0;
    DRW = 0;
    AOW = 0;
end

always @(posedge clk) begin
    IRW = IR;
    PC4W = PC4;
    DRW = DR;
    AOW = AO;
    if(rst) begin
        IRW = 0;
        PC4W = 0;
        DRW = 0;
        AOW = 0;
    end
end

endmodule // regW

