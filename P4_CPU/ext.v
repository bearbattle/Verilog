`timescale 1ns / 1ps

module ext(
    input [15:0] imm16,
    input [1:0] EXTOp,
    output reg [31:0] D32
);

always @(*) begin
    case (EXTOp)
        2'b00: D32 <= {16'd0,imm16}; 
        2'b00: D32 <= {{16{imm16[15]}},imm16}; 
        2'b00: D32 <= {imm16,16'd0}; 
        default: D32 <= 0;
    endcase
end

endmodule // ext