`timescale 1ns / 1ps

module regD(
        input clk,
        input enD,
        input FlushD,
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
    if(FlushD) begin
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
    output [31:0] IRE,
    output [31:0] PC4E,
    output [31:0] RSE,
    output [31:0] RTE,
    output [31:0] D32E
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
    input [31:0] IR,
    input [31:0] PC4,
    input [31:0] RT,
    input [31:0] AO,
    output [31:0] IRM,
    output [31:0] PC4M,
    output [31:0] RTM,
    output [31:0] AOM
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
end

endmodule // regM

module regW(
    input clk,
    input [31:0] IR,
    input [31:0] PC4,
    input [31:0] DR,
    input [31:0] AO,
    output [31:0] IRM,
    output [31:0] PC4M,
    output [31:0] DRM,
    output [31:0] AOM
);

initial begin
    IRM = 0;
    PC4M = 0;
    DRM = 0;
    AOM = 0;
end

always @(posedge clk) begin
    IRM = IR;
    PC4M = PC4;
    DRM = RTM;
    AOM = AO;
end

endmodule // regW
