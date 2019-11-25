`timescale 1ns / 1ps

`include "const.v"

module WController(
           input [31:0] IR,
           output reg RFWr,
           output reg [1:0] WDSel
       );

initial begin
    RFWr = 0;
    WDSel = 0;
end

always @(*) begin
    RFWr = 0;
    WDSel = 0;
    case (IR[`OP])
        // cal_r
        `R: begin
            case (IR[`FT])
                `addu: begin
                    RFWr = 1;
                    WDSel = `AO;
                end

                `subu: begin
                    RFWr = 1;
                    WDSel = `AO;
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
            WDSel = `AO;
        end

        `lui: begin
            RFWr = 1;
            WDSel = `AO;
        end

        //  link
        `jal: begin
            RFWr = 1;
            WDSel = `PC;
        end

        // b
        `beq: begin
        end

        // load
        `lw: begin
            RFWr = 1;
            WDSel = `DR;
        end

        //  store
        `sw: begin
        end
        default: begin
        end
    endcase
end

endmodule
