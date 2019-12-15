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
                `add: begin
                    RFWr = 1;
                end

                `addu: begin
                    RFWr = 1;
                end

                `sub: begin
                    RFWr = 1;
                end

                `subu: begin
                    RFWr = 1;
                end

                `mult: begin
                    RFWr = 1;
                end

                `multu: begin
                end

                `div: begin
                end

                `divu: begin
                end

                `sll: begin
                    RFWr = 1;
                end

                `srl: begin
                    RFWr = 1;
                end

                `sra: begin
                    RFWr = 1;
                end

                `sllv: begin
                    RFWr = 1;
                end

                `srlv: begin
                    RFWr = 1;
                end

                `srav: begin
                    RFWr = 1;
                end

                `and: begin
                    RFWr = 1;
                end

                `or: begin
                    RFWr = 1;
                end

                `xor: begin
                    RFWr = 1;
                end

                `nor: begin
                    RFWr = 1;
                end

                `slt: begin
                    RFWr = 1;
                end

                `sltu: begin
                    RFWr = 1;
                end

                // jr
                `jr: begin
                end

                `jalr: begin
                    RFWr = 1;
                end

                `mfhi: begin
                    RFWr = 1;
                end

                `mflo: begin
                    RFWr = 1;
                end

                `mthi: begin
                end

                `mtlo: begin
                end
                default: begin
                end
            endcase
        end

        //  cal_i
        `addi: begin
            RFWr = 1;
        end

        `addiu: begin
            RFWr = 1;
        end

        `andi: begin
            RFWr = 1;
        end

        `ori: begin
            RFWr = 1;
        end

        `xori: begin
            RFWr = 1;
        end

        `lui: begin
            RFWr = 1;
        end

        `slti: begin
            RFWr = 1;
        end

        `sltiu: begin
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
        `lb: begin
            RFWr = 1;
        end

        `lbu: begin
            RFWr = 1;
        end

        `lh: begin
            RFWr = 1;
        end

        `lhu: begin
            RFWr = 1;
        end

        `lw: begin
            RFWr = 1;
        end

        //  store
        `sb: begin
        end

        `sh: begin
        end

        `sw: begin
        end

        `mas: begin
            case (IR[`FT])
                `madd:
                    RFWr = 1;
                `maddu:
                    RFWr = 1;
                `msub:
                    RFWr = 1;
                `msubu:
                    RFWr = 1;
                default: begin

                end
            endcase
        end
        default: begin
        end
    endcase
end

endmodule
