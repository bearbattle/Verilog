`timescale 1ns / 1ps

module grf(
           input clk,
           input rst,
           input Wr,
           input [4:0] A1,
           input [4:0] A2,
           input [4:0] A3,
           input [31:0] WD,
           output [31:0] RD1,
           output [31:0] RD2
       );

reg [31:0] GRF [31:0];
integer i;

assign RD1 = A1 == 0 ? 0 : A1 == A3 ? WD : GRF[A1];
assign RD2 = A2 == 0 ? 0 : A2 == A3 ? WD : GRF[A2];

initial begin
    for(i = 0; i < 32; i = i + 1) begin
        GRF[i] = 0;
    end
end

always @(posedge clk) begin
    if (rst) begin
        for(i = 0; i < 32; i = i + 1) begin
            GRF[i] = 0;
        end
    end
    else begin
        if(Wr && A3 != 5'd0) begin
            GRF[A3] = WD;
            $display("@%h: $%d <= %h", W.PCW, A3,WD);
        end
    end
end

endmodule // grf
