`timescale 1ps / 1ns

module funct(input isR,
             input [5:0] funct,
             output reg isaddu,
             output reg issubu,
             output reg isjr);
    
    localparam addu = 6'b100001;
    localparam subu = 6'b100011;
    localparam jr   = 6'b001000;
    
    initial begin
        isaddu <= 0;
        issubu <= 0;
        isjr   <= 0;
    end
    
    always @(*) begin
        isaddu <= 0;
        issubu <= 0;
        isjr   <= 0;
        if (isR) begin
            case (funct)
                addu: isaddu <= 1;
                subu: issubu <= 1;
                jr: isjr     <= 1;
                default: begin
                    isaddu <= 0;
                    issubu <= 0;
                    isjr   <= 0;
                end
            endcase
        end
    end
    
endmodule // funct
