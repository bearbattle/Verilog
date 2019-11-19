`timescale 1ns / 1ps
module pc(
           input clk,
           input rst,
           input enPC,
           input [31:0] NPC,
           output reg [31:0] PC
       );

initial begin
    PC = 32'h00003000;
end

always @(posedge clk ) begin
    if (rst) begin
        PC = 32'h00003000;
    end
    else begin
        if(enPC)
            PC = NPC;
    end
end

endmodule // pc
