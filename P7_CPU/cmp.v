`timescale 1ns / 1ps

module cmp(
    input [31:0] RS,
    input [31:0] RT,
    output Zero,
    output Neq,
    output Lez,
    output Gtz,
    output Ltz,
    output Gez
    );

assign Zero = RS == RT;
assign Neq  = RS != RT;
assign Lez  = $signed(RS) <= 0;
assign Gtz  = $signed(RS) >  0;
assign Ltz  = $signed(RS) <  0;
assign Gez  = $signed(RS) >= 0;

endmodule
