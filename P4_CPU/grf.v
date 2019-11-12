`timescale 1ns / 1ps

module grf(
           input clk,
           input Reset,
           input WriteEnable,
           input [4:0] ReadAddress1,
           input [4:0] ReadAddress2,
           input [4:0] WriteAddress,
           input [31:0] WriteData,
           output [31:0] ReadData1,
           output [31:0] ReadData2);

reg [31:0] GRF [4:0];
integer i;

assign ReadData1 = GRF[ReadAddress1];
assign ReadData2 = GRF[ReadAddress2];

initial begin
    for(i = 0; i < 32; i = i + 1) begin
        GRF[i] <= 0;
    end
end

always @(posedge clk) begin
    if (Reset) begin
        for(i = 0; i < 32; i = i + 1) begin
            GRF[i] <= 0;
        end
    end
    else begin
        if(WriteEnable && WriteAddress != 0) begin
            GRF[WriteAddress] <= WriteData;
            $display("%h",GRF[WriteAddress]);
        end
    end
end

endmodule // grf
