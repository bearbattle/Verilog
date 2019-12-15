`timescale 1ns / 1ps

module add4(
    input [31:0] PC,
    output [31:0] PC4
    );

assign PC4 = PC + 4;

endmodule
