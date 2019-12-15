`timescale 1ns / 1ps

`include "const.v"

module MController(
           input [31:0] IR,
           output DMWr,
           output reg [1:0] WDSel
       );


assign DMWr = (IR[`OP] == `sw
               || IR[`OP] == `sb
               || IR[`OP] == `sh)  ? 1 : 0;

initial begin
    WDSel = 0;
end

always @(*) begin
    WDSel = 0;
    case (IR[`OP])
        // cal_r
        `R: begin
            case (IR[`FT])
                `mfhi:
                    WDSel = `MD;
                `mflo:
                    WDSel = `MD;
                // jr
                `jr: begin
                end

                `jalr: begin
                    WDSel = `PC;
                end
                default: begin
                    WDSel = `AO;
                end
            endcase
        end

        //  cal_i
        `addi: begin
            WDSel = `AO;
        end

        `addiu: begin
            WDSel = `AO;
        end

        `andi: begin
            WDSel = `AO;
        end

        `ori: begin
            WDSel = `AO;
        end

        `xori: begin
            WDSel = `AO;
        end

        `lui: begin
            WDSel = `AO;
        end

        `slti: begin
            WDSel = `AO;
        end

        `sltiu: begin
            WDSel = `AO;
        end

        //  link
        `jal: begin
            WDSel = `PC;
        end

        // j
        `j: begin
        end

        // b
        `beq: begin
        end

        `bne: begin
        end

        `blez: begin
        end

        `bgtz: begin
        end

        `bltz: begin
        end

        // load
        `lb: begin
            WDSel = `DR;
        end

        `lbu: begin
            WDSel = `DR;
        end

        `lh: begin
            WDSel = `DR;
        end

        `lhu: begin
            WDSel = `DR;
        end

        `lw: begin
            WDSel = `DR;
        end

        //  store
        `sb: begin
        end

        `sh: begin
        end

        `sw: begin
        end

        default: begin
        end
    endcase
end

endmodule
