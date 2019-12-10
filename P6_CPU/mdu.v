`timescale 1ns / 1ps

`include "const.v"

module mdu(
           input clk,
           input rst,
           input enMDU,
           input [3:0] MDUOp,
           input [31:0] D1,
           input [31:0] D2,
           output reg Busy,
           output reg [4:0] Tnew,
           output reg [31:0] OUT
       );

reg [31:0] HI0, LO0;

initial begin
    HI0 = 0;
    LO0 = 0;
    Busy = 0;
    Tnew = 0;
    OUT = 0;
end

always @(posedge clk) begin
    if(rst) begin
        Busy = 0;
        Tnew = 0;
        HI = 0;
        LO = 0;
        OUT = 0;
    end
    else begin
        if(enMDU)
        case (MDUOp)
            `MULT: begin
                {HI0, LO0} <= $signed(D1) * $signed(D2);
                Tnew <= 5'd5;
                Busy <= 1;
            end

            `MULTU: begin
                {HI0, LO0} <= D1 * D2;
                Tnew <= 5'd5;
                Busy <= 1;
            end

            `DIV: begin
                HI0 <= $signed(D1) % $signed(D2);
                LO0 <= $signed(D1) / $signed(D2);
                Tnew <= 5'd10;
                Busy <= 1;
            end

            `DIVU: begin
                HI0 <= D1 % D2;
                LO0 <= D1 / D2;
                Tnew <= 5'd10;
                Busy <= 1;
            end

            `MTHI: begin
                HI0 <= D1;
            end

            `MTLO: begin
                LO0 <= D1;
            end

            `MADDU: begin
                {HI0, LO0} <= {HI0, LO0} + D1 * D2;
            end

            default: begin
                $display("MDU, NM$L");
            end
        endcase
        else
        case (MDUOp)
            `MFHI:
                OUT <= HI0;
            `MFLO:
                OUT <= LO0;
            default: begin
                $display("MOVE FROM MDU, NM$L");
            end
        endcase
    end
end

endmodule // mdu
