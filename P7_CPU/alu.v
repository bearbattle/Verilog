`timescale 1ns / 1ps

`include "const.v"

module alu(
           input [31:0] A,
           input [31:0] B,
           input [4:0] s,
           input [3:0] ALUOp,
           output reg [31:0] C,
           output reg Zero
       );

always @(*) begin
    Zero = A == B ? 1 : 0;
    case (ALUOp)
        `ADD:
            C = A + B;
        `SUB:
            C = A - B;
        `AND:
            C = A & B;
        `OR:
            C = A | B;
        `XOR:
            C = A ^ B;
        `NOR:
            C = ~(A | B);
        `SLL:
            C = B << s;
        `SRL:
            C = B >> s;
        `SRA:
            C = $signed(B) >>> s;
        `SLLV:
            C = B << A[4:0];
        `SRLV:
            C = B >> A[4:0];
        `SRAV:
            C = $signed(B) >>> A[4:0];
        `SLT:
            C = $signed(A) < $signed(B) ? 1 : 0;
        `SLTU:
            C = A < B ? 1 : 0;
        default:
            C = 0;
    endcase
end

endmodule // alu
