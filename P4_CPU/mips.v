`timescale 1ns / 1ps

module mips(
           input clk,
           input reset
       );

ifu IFU();
alu ALU();
ext EXT();
dm DM();
grf GRF();
controller Controller();

endmodule // mips
