`timescale 1ns / 1ps
module im(
           input [31:0] PC,
           output [31:0] Instruction
       );

reg [31:0] ROM [4095:0];

assign Instruction = ROM[(PC - 32'h3000) >> 2];

initial begin
    $readmemh("code.txt", ROM);
end

endmodule // IM
