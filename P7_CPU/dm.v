`timescale 1ns / 1ps

`include "const.v"

module dm(
           input clk,
           input rst,
           input Wr,
           input [31:0] A,
           input [3:0] be,
           input [31:0] WD,
           output reg [31:0] DR
       );

reg [31:0] RAM [4095:0];
integer i;
wire [7:0] bytei[3:0];
wire [31:0] IR = M.IRM;

assign bytei[3] = RAM[A[31:2]][31:24];
assign bytei[2] = RAM[A[31:2]][23:16];
assign bytei[1] = RAM[A[31:2]][15:8];
assign bytei[0] = RAM[A[31:2]][7:0];

initial begin
    for (i = 0; i < 4096; i = i + 1) begin
        RAM[i] = 32'h00000000;
    end
    DR = 0;
end

//Write
always @(posedge clk ) begin
    if (rst) begin
        for (i = 0; i < 4096; i = i + 1) begin
            RAM[i] <= 32'h00000000;
        end
    end
    else begin
        if(Wr) begin
            case (IR[`OP])
                `sb: begin
                    case (be)
                        4'b0001: begin
                            RAM[A[31:2]] <= {bytei[3], bytei[2], bytei[1], WD[7:0]};
                            $display("%d@%h: *%h <= %h", $time, M.PCM, {A[31:2],2'd0}, {bytei[3], bytei[2], bytei[1], WD[7:0]});
                        end
                        4'b0010: begin
                            RAM[A[31:2]] <= {bytei[3], bytei[2], WD[7:0], bytei[0]};
                            $display("%d@%h: *%h <= %h", $time, M.PCM, {A[31:2],2'd0}, {bytei[3], bytei[2], WD[7:0], bytei[0]});
                        end
                        4'b0100: begin
                            RAM[A[31:2]] <= {bytei[3], WD[7:0], bytei[1], bytei[0]};
                            $display("%d@%h: *%h <= %h", $time, M.PCM, {A[31:2],2'd0}, {bytei[3], WD[7:0], bytei[1], bytei[0]});
                        end
                        4'b1000: begin
                            RAM[A[31:2]] <= {WD[7:0], bytei[2], bytei[1], bytei[0]};
                            $display("%d@%h: *%h <= %h", $time, M.PCM, {A[31:2],2'd0}, {WD[7:0], bytei[2], bytei[1], bytei[0]});
                        end
                        default:
                            $display("SB-MEM, NM$L");
                    endcase
                end
                `sh: begin
                    case (be)
                        4'b0011: begin
                            RAM[A[31:2]] <= {bytei[3], bytei[2], WD[15:0]};
                            $display("%d@%h: *%h <= %h", $time, M.PCM, {A[31:2],2'd0}, {bytei[3], bytei[2], WD[15:0]});
                        end
                        4'b1100: begin
                            RAM[A[31:2]] <= {WD[15:0], bytei[1], bytei[0]};
                            $display("%d@%h: *%h <= %h", $time, M.PCM, {A[31:2],2'd0}, {WD[15:0], bytei[1], bytei[0]});
                        end
                        default:
                            $display("SH-MEM, NM$L");
                    endcase
                end
                `sw : begin
                    RAM[A[31:2]] <= WD;
                    $display("%d@%h: *%h <= %h", $time, M.PCM, {A[31:2],2'd0}, WD);
                end
                default:
                    $display("LOAD-MEM, NM$L");
            endcase
        end
    end
end

//Read
always @(*) begin
    if(rst)
        DR = 0;
    case (IR[`OP])
        `lb: begin
            case (be)
                4'b0001:
                    DR = {{24{bytei[0][7]}}, bytei[0]};
                4'b0010:
                    DR = {{24{bytei[1][7]}}, bytei[1]};
                4'b0100:
                    DR = {{24{bytei[2][7]}}, bytei[2]};
                4'b1000:
                    DR = {{24{bytei[3][7]}}, bytei[3]};
                default: begin
                    DR = 32'hxxxxxxxx;
                    //$display("LB-MEM, NM$L");
                end
            endcase
        end

        `lbu: begin
            case (be)
                4'b0001:
                    DR = {24'h0, bytei[0]};
                4'b0010:
                    DR = {24'h0, bytei[1]};
                4'b0100:
                    DR = {24'h0, bytei[2]};
                4'b1000:
                    DR = {24'h0, bytei[3]};
                default: begin
                    DR = 32'hxxxxxxxx;
                    //$display("LBU-MEM, NM$L");
                end
            endcase
        end

        `lh: begin
            case (be)
                4'b0011:
                    DR = {{16{bytei[1][7]}}, bytei[1], bytei[0]};
                4'b1100:
                    DR = {{16{bytei[3][7]}}, bytei[3], bytei[2]};
                default: begin
                    DR = 32'hxxxxxxxx;
                    //$display("LH-MEM, NM$L");
                end
            endcase
        end

        `lhu: begin
            case (be)
                4'b0011:
                    DR = {16'h0000, bytei[1], bytei[0]};
                4'b1100:
                    DR = {16'h0000, bytei[3], bytei[2]};
                default: begin
                    DR = 32'hxxxxxxxx;
                    //$display("LHU-MEM, NM$L");
                end
            endcase
        end

        `lw:
            DR = RAM[A[31:2]];
        default:
            DR = 32'hxxxxxxxx;
        // $display("READ-MEM, NM$L");
    endcase
end

endmodule // dm
