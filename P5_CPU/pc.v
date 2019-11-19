`timescale 1ns / 1ps
module pc(
           input clk,
           input Reset,
           input [31:0] NPC,
           output reg [31:0] InstructionAddress
       );

initial begin
    InstructionAddress <= 32'h00003000;
end

always @(posedge clk ) begin
    if (Reset) begin
        InstructionAddress <= 32'h00003000;
    end
    else begin
        InstructionAddress <= nPC;
    end
end

endmodule // pc
