`timescale 1ns / 1ps

`include "const.v"

module EController(
           input [31:0] IR,
           output reg [3:0] ALUOp,
           output reg BSel,
           output reg enMDU,
           output reg [3:0] MDUOp,
           output reg [1:0] WDSel
       );

initial begin
    ALUOp = 0;
    BSel = 0;
    enMDU = 0;
    MDUOp = 0;
    WDSel = 0;
end

always @(*) begin
    ALUOp = 0;
    BSel = 0;
    enMDU = 0;
    MDUOp = 0;
    WDSel = 0;
    case (IR[`OP])
        // cal_r
        `R: begin
            case (IR[`FT])
                `add: begin
                    ALUOp = `ADD;
                    WDSel = `AO;
                end

                `addu: begin
                    ALUOp = `ADD;
                    WDSel = `AO;
                end

                `sub: begin
                    ALUOp = `SUB;
                    WDSel = `AO;
                end

                `subu: begin
                    ALUOp = `SUB;
                    WDSel = `AO;
                end

                `mult: begin
                    enMDU = 1;
                    MDUOp = `MULT;
                end

                `multu: begin
                    enMDU = 1;
                    MDUOp = `MULTU;
                end

                `div: begin
                    enMDU = 1;
                    MDUOp = `DIV;
                end

                `divu: begin
                    enMDU = 1;
                    MDUOp = `DIVU;
                end

                `sll: begin
                    ALUOp = `SLL;
                    WDSel = `AO;
                end

                `srl: begin
                    ALUOp = `SRL;
                    WDSel = `AO;
                end

                `sra: begin
                    ALUOp = `SRA;
                    WDSel = `AO;
                end

                `sllv: begin
                    ALUOp = `SLLV;
                    WDSel = `AO;
                end

                `srlv: begin
                    ALUOp = `SRLV;
                    WDSel = `AO;
                end

                `srav: begin
                    ALUOp = `SRAV;
                    WDSel = `AO;
                end

                `and: begin
                    ALUOp = `AND;
                    WDSel = `AO;
                end

                `or: begin
                    ALUOp = `OR;
                    WDSel = `AO;
                end

                `xor: begin
                    ALUOp = `XOR;
                    WDSel = `AO;
                end

                `nor: begin
                    ALUOp = `NOR;
                    WDSel = `AO;
                end

                `slt: begin
                    ALUOp = `SLT;
                    WDSel = `AO;
                end

                `sltu: begin
                    ALUOp = `SLTU;
                    WDSel = `AO;
                end

                // jr
                `jr: begin
                end

                `jalr: begin
                    WDSel = `PC;
                end

                `mfhi: begin
                    MDUOp = `MFHI;
                    WDSel = `MD;
                end

                `mflo: begin
                    MDUOp = `MFLO;
                    WDSel = `MD;
                end

                `mthi: begin
                    enMDU = 1;
                    MDUOp = `MTHI;
                end

                `mtlo: begin
                    enMDU = 1;
                    MDUOp = `MTLO;
                end
                default: begin
                end
            endcase
        end

        //  cal_i
        `addi: begin
            ALUOp = `ADD;
            BSel = 1;
            WDSel = `AO;
        end

        `addiu: begin
            ALUOp = `ADD;
            BSel = 1;
            WDSel = `AO;
        end

        `andi: begin
            ALUOp = `AND;
            BSel = 1;
            WDSel = `AO;
        end

        `ori: begin
            ALUOp = `OR;
            BSel = 1;
            WDSel = `AO;
        end

        `xori: begin
            ALUOp = `XOR;
            BSel = 1;
            WDSel = `AO;
        end

        `lui: begin
            ALUOp = `OR;
            BSel = 1;
            WDSel = `AO;
        end

        `slti: begin
            ALUOp = `SLT;
            BSel = 1;
            WDSel = `AO;
        end

        `sltiu: begin
            ALUOp = `SLTU;
            BSel = 1;
            WDSel = `AO;
        end

        //  link
        `jal: begin
            WDSel = `PC;
        end

        // b
        `beq: begin
        end

        // load
        `lb: begin
            BSel = 1;
        end

        `lbu: begin
            BSel = 1;
        end

        `lh: begin
            BSel = 1;
        end

        `lhu: begin
            BSel = 1;
        end

        `lw: begin
            BSel = 1;
        end

        //  store
        `sb: begin
            BSel = 1;
        end

        `sh: begin
            BSel = 1;
        end

        `sw: begin
            BSel = 1;
        end

        default: begin
        end
    endcase
end

endmodule
