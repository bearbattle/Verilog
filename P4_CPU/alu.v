`timescale 1ns / 1ps

module alu(
           input [31:0] A,
           input [31:0] B,
           input [1:0] ALUOp,
           output reg [31:0] C,
           output reg zero
       );

always @(*) begin
    zero = A == B ? 1 : 0;
    case (ALUOp)
        2'b00:
            C = A + B;
        2'b01:
            C = A - B;
        2'b10:
            C = A | B;
        default:
            C = 0;
    endcase
end

endmodule // alu
