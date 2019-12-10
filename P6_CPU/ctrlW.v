`timescale 1ns / 1ps

`include "const.v"

module WController(
           input [31:0] IR,
           output reg RFWr
       );

initial begin
    RFWr = 0;
end

always @(*) begin
    RFWr = 0;
    case (IR[`OP])
        // cal_r
        `R: begin
            case (IR[`FT])
                `addu: begin
                    RFWr = 1;
                end

                `subu: begin
                    RFWr = 1;
                end
                // jr
                `jr: begin

                end
                default: begin
                end
            endcase
        end

        //  cal_i
        `ori: begin
            RFWr = 1;
        end

        `lui: begin
            RFWr = 1;
        end

        //  link
        `jal: begin
            RFWr = 1;
        end

        // b
        `beq: begin
        end

        // load
        `lw: begin
            RFWr = 1;
        end

        //  store
        `sw: begin
        end
        default: begin
        end
    endcase
end

endmodule
