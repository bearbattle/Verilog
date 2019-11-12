`timescale 1ns / 1ps
module im(
           input [31:0] InstructionAddress,
           output [31:0] Instruction
       );

reg [31:0] ROM [9:0];

assign Instruction = ROM[InstructionAddress[31:2]];

integer i;

initial begin
    $readmemh("code.txt", ROM);
end

endmodule // IM
