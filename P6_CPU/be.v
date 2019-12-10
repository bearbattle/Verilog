`timescale 1ns / 1ps

`include "const.v"

module be(
           input [31:0] A,
           output reg [3:0] BE
       );

initial begin
    BE = 0;
end

always @(*) begin
    BE = 0;
    case (M.IRM[`OP])
        `lb: begin
            BE[A[1:0] % 4] = 1;
        end

        `lbu: begin
            BE[A[1:0] % 4] = 1;
        end

        `lh: begin
            BE[3] = (A[1] == 1);
            BE[2] = (A[1] == 1);
            BE[1] = (A[1] == 0);
            BE[0] = (A[1] == 0);
        end

        `lhu: begin
            BE[3] = (A[1] == 1);
            BE[2] = (A[1] == 1);
            BE[1] = (A[1] == 0);
            BE[0] = (A[1] == 0);
        end

        `lw: begin
            BE = 4'b1111;
        end

        `sb: begin
            BE[A[1:0] % 4] = 1;
        end

        `sh: begin
            BE[3] = (A[1] == 1);
            BE[2] = (A[1] == 1);
            BE[1] = (A[1] == 0);
            BE[0] = (A[1] == 0);
        end

        `sw: begin
            BE = 4'b1111;
        end
    endcase
end

endmodule // be
