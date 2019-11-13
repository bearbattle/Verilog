`timescale 1ns / 1ps
module dm(
           input clk,
           input Reset,
           input WriteEnable,
           input [31:0] WriteAddress,
           input [31:0] WriteData,
           input [31:0] ReadAddress,
           output [31:0] ReadData
       );

reg [31:0] RAM [1023:0];
integer i;

assign ReadData = RAM[ReadAddress[31:2]];

initial begin
    for (i = 0; i < 1024; i = i + 1) begin
        RAM[i] <= 32'h00000000;
    end
end

always @(posedge clk ) begin
    if (Reset) begin
        for (i = 0; i < 1024; i = i + 1) begin
            RAM[i] <= 32'h00000000;
        end
    end
    else begin
        if(WriteEnable) begin
            RAM[WriteAddress[31:2]] = WriteData;
				$display("@%h: *%h <= %h", IFU.PC0, WriteAddress, WriteData);
        end
    end
end

endmodule // dm
