`timescale 1ns / 1ps

module controller(input [5:0] opcode,
                  input [5:0] funct,
                  input Zero,
                  output reg isb,
                  output reg isjal,
                  output reg isjr,
                  output reg RFWr,
                  output reg [1:0] WDSel,
                  output reg DMWr,
                  output reg [1:0] DstSel,
                  output reg [1:0] ALUOp,
                  output reg ALUBSel,
                  output reg [1:0] EXTOp);

parameter ADD = 2'b00;
parameter SUB = 2'b01;
parameter OR = 2'b10;

parameter UE = 2'b00;
parameter SE = 2'b01;
parameter HE = 2'b10;

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
    isb = 0;
    isjal = 0;
    isjr = 0;
    RFWr = 0;
    WDSel = 0;
    DMWr = 0;
    DstSel = 0;
    ALUOp = 0;
    ALUBSel = 0;
    EXTOp = 0;
    case(opcode)
        R: begin
            case (funct)
                addu: begin
                    RFWr = 1;
                end
                subu: begin
                    RFWr = 1;
                    ALUOp = SUB;
                end
                jr: begin
                    isjr = 1;
                end
                default: begin
                    isb = 0;
                    isjal = 0;
                    isjr = 0;
                    RFWr = 0;
                    WDSel = 0;
                    DMWr = 0;
                    DstSel = 0;
                    ALUOp = 0;
                    ALUBSel = 0;
                    EXTOp = 0;
                end
            endcase
        end

        ori: begin
            RFWr = 1;
            DstSel = 1;
            ALUBSel = 1;
            ALUOp = OR;
        end

        lw : begin
            RFWr = 1;
            DstSel = 1;
            WDSel = 1;
            ALUBSel = 1;
            EXTOp = SE;
        end

        sw : begin
            ALUBSel = 1;
            DMWr = 1;
            EXTOp = SE;
        end

        beq: begin
            isb = Zero;
        end

        lui: begin
            DstSel = 1;
            RFWr = 1;
            WDSel= 2;
            EXTOp = HE;
        end

        jal: begin
            isjal = 1;
            RFWr = 1;
            DstSel = 2;
            WDSel = 3;
        end

        default: begin
            isb = 0;
            isjal = 0;
            isjr = 0;
            RFWr = 0;
            WDSel = 0;
            DMWr = 0;
            DstSel = 0;
            ALUOp = 0;
            ALUBSel = 0;
            EXTOp = 0;
        end
    endcase
end

endmodule
