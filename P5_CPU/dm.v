`timescale 1ns / 1ps
module dm(
           input clk,
           input rst,
           input Wr,
           input [31:0] A,
           input [31:0] WD,
           output [31:0] DR
       );

reg [31:0] RAM [1023:0];
integer i;

assign DR = RAM[A[11:2]];

initial begin
    for (i = 0; i < 1024; i = i + 1) begin
        RAM[i] = 32'h00000000;
    end
end

always @(posedge clk ) begin
    if (rst) begin
        for (i = 0; i < 1024; i = i + 1) begin
            RAM[i] <= 32'h00000000;
        end
    end
    else begin
        if(Wr) begin
            RAM[A[11:2]] <= WD;
			$display("%d@%h: *%h <= %h",$time, M.PCM, A,WD);
        end
    end
end

endmodule // dm
