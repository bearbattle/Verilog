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
                  output reg isbeq,
                  output reg isjal,
                  output reg isjr,
                  output reg [1:0] GRF_A3_MUX,
                  output reg [1:0] GRF_WD_MUX,
                  output reg GRF_WE,
                  output reg ALU_B_MUX,
                  output reg [1:0] ALUOp,
                  output reg DM_WE,
                  output reg [1:0] EXTOp);

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
                    GRF_WE <= 1;
                end
                subu: begin
                    GRF_WE <= 1;
                    ALUOp <= 1;
                end
                jr: begin
                    isjr <= 1;
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

        ori: begin
            GRF_WE <= 1;
            GRF_A3_MUX <= 1;
            ALU_B_MUX <= 1;
            ALUOp <= 2;
        end

        lw : begin
            GRF_WE <= 1;
            GRF_A3_MUX <= 1;
            GRF_WD_MUX <= 1;
            ALU_B_MUX <= 1;
            EXTOp <= 1;
        end

        sw : begin
            ALU_B_MUX <= 1;
            DM_WE <= 1;
            EXTOp <= 1;
        end

        beq: begin
            isbeq <= 1;
        end

        lui: begin
            GRF_A3_MUX <= 1;
            GRF_WE <= 1;
            EXTOp <= 2;
        end

        jal: begin
            isjal <= 1;
            GRF_WE <= 1;
            GRF_A3_MUX <= 2;
            GRF_WD_MUX <= 3;
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

endmodule
