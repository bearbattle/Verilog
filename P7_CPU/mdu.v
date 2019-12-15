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
           output [31:0] OUT
       );

reg [31:0] HI, LO;
wire [63:0] SMULT = $signed(D1) * $signed(D2);
wire [63:0] UMULT = D1 * D2;

assign OUT = MDUOp == `MFHI ? HI :
       MDUOp == `MFLO ? LO : 0;

initial begin
    HI = 0;
    LO = 0;
    Busy = 0;
    Tnew = 0;
end

always @(posedge clk) begin
    if(rst) begin
        Busy <= 0;
        Tnew <= 0;
        HI <= 0;
        LO <= 0;
    end
    else begin
        if(enMDU) begin
            case (MDUOp)
                `MULT: begin
                    {HI, LO} <= SMULT;
                    Tnew <= 5'd5;
                    Busy <= 1;
                end

                `MULTU: begin
                    {HI, LO} <= UMULT;
                    Tnew <= 5'd5;
                    Busy <= 1;
                end

                `DIV: begin
                    if(D2 == 0) begin
                        $display("Divided by 0, NM$L");
                        Tnew <= 5'd10;
                        Busy <= 1;
                    end
                    else begin
                        HI <= $signed(D1) % $signed(D2);
                        LO <= $signed(D1) / $signed(D2);
                        Tnew <= 5'd10;
                        Busy <= 1;
                    end
                end

                `DIVU: begin
                    if(D2 == 0) begin
                        $display("Divided by 0, NM$L");
                        Tnew <= 5'd10;
                        Busy <= 1;
                    end
                    else begin
                        HI <= D1 % D2;
                        LO <= D1 / D2;
                        Tnew <= 5'd10;
                        Busy <= 1;
                    end
                end

                `MTHI: begin
                    HI <= D1;
                end

                `MTLO: begin
                    LO <= D1;
                end

                `MADD: begin
                    {HI, LO} <= {HI, LO} + SMULT;
                    Tnew <= 5'd5;
                    Busy <= 1;
                end

                `MSUB: begin
                    {HI, LO} <= {HI, LO} - SMULT;
                    Tnew <= 5'd5;
                    Busy <= 1;
                end

                `MADDU: begin
                    {HI, LO} <= {HI, LO} + UMULT;
                    Tnew <= 5'd5;
                    Busy <= 1;
                end

                `MSUBU: begin
                    {HI, LO} <= {HI, LO} - UMULT;
                    Tnew <= 5'd5;
                    Busy <= 1;
                end

                default: begin
                    $display("MDU, NM$L");
                end
            endcase
        end
        else begin
            Tnew <= Tnew > 0 ? Tnew - 1 : 0;
            Busy <= Tnew > 1;
        end
    end
end

endmodule // mdu
