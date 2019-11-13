`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    01:27:53 11/13/2019
// Design Name:
// Module Name:    controller
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module controller(input [5:0] opcode,
                  input [5:0] funct,
                  output isbeq,
                  output isjal,
                  output isjr,
                  output [1:0] GRF_A3_MUX,
                  output [1:0] GRF_WD_MUX,
                  output GRF_WE,
                  output ALU_B_MUX,
                  output [1:0] ALUOp,
                  output DM_WE,
                  output [1:0] EXTOp);

localparam R   = 6'b000000;
localparam ori = 6'b001101;
localparam lw  = 6'b100011;
localparam sw  = 6'b101011;
localparam beq = 6'b000100;
localparam lui = 6'b001111;
localparam jal = 6'b000011;

localparam addu = 6'b100001;
localparam subu = 6'b100011;
localparam jr   = 6'b001000;

always @(*) begin
    isbeq = 0;
    isjal = 0;
    isjr = 0;
    GRF_A3_MUX = 0;
    GRF_WD_MUX = 0;
    GRF_WE = 0;
    ALU_B_MUX = 0;
    ALUOp = 0;
    DM_WE = 0;
    EXTOp = 0;
    case(opcode)
        R: begin
            case (funct)
                addu: begin
					WE <= 1;
                end
                subu: begin

                end
                jr: begin

                end
                default: begin
                    isbeq <= 0;
                    isjal <= 0;
                    isjr <= 0;
                    GRF_A3_MUX <= 0;
                    GRF_WD_MUX <= 0;
                    GRF_WE <= 0;
                    ALU_B_MUX <= 0;
                    ALUOp <= 0;
                    DM_WE <= 0;
                    EXTOp <= 0;
                end
            endcase
        end






    endcase
end

endmodule
