`timescale 1ns / 1ps

module opcode(input [5:0] opcode,
              output reg isR,
              output reg isori,
              output reg islw,
              output reg issw,
              output reg isbeq,
              output reg islui,
              output reg isjal);

localparam R   = 6'b000000;
localparam ori = 6'b001101;
localparam lw  = 6'b100011;
localparam sw  = 6'b101011;
localparam beq = 6'b000100;
localparam lui = 6'b001111;
localparam jal = 6'b000011;

initial begin
    isR   <= 0;
    isori <= 0;
    islw  <= 0;
    issw  <= 0;
    isbeq <= 0;
    islui <= 0;
    isjal <= 0;
end

always @(*) begin
    isR   <= 0;
    isori <= 0;
    islw  <= 0;
    issw  <= 0;
    isbeq <= 0;
    islui <= 0;
    isjal <= 0;
    case(opcode)
        R: isR     <= 1;
        ori: isori <= 1;
        lw: islw   <= 1;
        sw: issw   <= 1;
        beq: isbeq <= 1;
        lui: islui <= 1;
        jal: isjal <= 1;
        default: begin
            isR   <= 0;
            isori <= 0;
            islw  <= 0;
            issw  <= 0;
            isbeq <= 0;
            islui <= 0;
            isjal <= 0;
        end
    endcase
end

endmodule // opcode
