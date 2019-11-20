`timescale 1ns / 1ps

module cmp(
    input [31:0] RS,
    input [31:0] RT,
    output Zero
    );

assign Zero = RS == RT;

endmodule
