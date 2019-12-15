`timescale 1ns / 1ps
`include "const.v"

module atcoder(
           input [31:0] IR,
           output reg [4:0] A1,
           output reg [4:0] A2,
           output reg [4:0] A3,
           output reg [2:0] Tnew,
           output reg [2:0] Tuse1,
           output reg [2:0] Tuse2
       );

initial begin
    A1 = 0;
    A2 = 0;
    A3 = 0;
    Tnew = 0;
    Tuse1 = 0;
    Tuse2 = 0;
end

always @(*) begin
    A1 = 0;
    A2 = 0;
    A3 = 0;
    Tnew = 0;
    Tuse1 = 0;
    Tuse2 = 0;
    case (IR[`OP])
        // cal_r
        `R: begin
            case (IR[`FT])
                `jr: begin
                    A1 = IR[`RS];
                    Tuse1 = 0;
                end

                `jalr: begin
                    A1 = IR[`RS];
                    Tuse1 = 0;
                    A3 = IR[`RD];
                    Tnew = 0;
                end

                default: begin
                    A1 = IR[`RS];
                    A2 = IR[`RT];
                    A3 = IR[`RD];
                    Tnew = 2;
                    Tuse1 = 1;
                    Tuse2 = 1;
                end
            endcase
        end

        //  cal_i
        `addi: begin
            A1 = IR[`RS];
            A3 = IR[`RT];
            Tnew = 2;
            Tuse1 = 1;
        end

        `addiu: begin
            A1 = IR[`RS];
            A3 = IR[`RT];
            Tnew = 2;
            Tuse1 = 1;
        end

        `andi: begin
            A1 = IR[`RS];
            A3 = IR[`RT];
            Tnew = 2;
            Tuse1 = 1;
        end

        `ori: begin
            A1 = IR[`RS];
            A3 = IR[`RT];
            Tnew = 2;
            Tuse1 = 1;
        end

        `xori: begin
            A1 = IR[`RS];
            A3 = IR[`RT];
            Tnew = 2;
            Tuse1 = 1;
        end

        `lui: begin
            A1 = IR[`RS];
            A3 = IR[`RT];
            Tnew = 2;
            Tuse1 = 1;
        end

        `slti: begin
            A1 = IR[`RS];
            A3 = IR[`RT];
            Tnew = 2;
            Tuse1 = 1;
        end

        `sltiu: begin
            A1 = IR[`RS];
            A3 = IR[`RT];
            Tnew = 2;
            Tuse1 = 1;
        end

        //  link
        `jal: begin
            A3 = 5'd31;
            Tnew = 0;
        end

        // b
        `beq: begin
            A1 = IR[`RS];
            A2 = IR[`RT];
            Tuse1 = 0;
            Tuse2 = 0;
        end

        `bne: begin
            A1 = IR[`RS];
            A2 = IR[`RT];
            Tuse1 = 0;
            Tuse2 = 0;
        end

        `blez: begin
            A1 = IR[`RS];
            Tuse1 = 0;
        end

        `bgtz: begin
            A1 = IR[`RS];
            Tuse1 = 0;
        end

        `bltz: begin
            A1 = IR[`RS];
            Tuse1 = 0;
        end
        // load
        `lb: begin
            A1 = IR[`RS];
            A3 = IR[`RT];
            Tnew = 3;
            Tuse1 = 1;
        end

        `lbu: begin
            A1 = IR[`RS];
            A3 = IR[`RT];
            Tnew = 3;
            Tuse1 = 1;
        end

        `lh: begin
            A1 = IR[`RS];
            A3 = IR[`RT];
            Tnew = 3;
            Tuse1 = 1;
        end

        `lhu: begin
            A1 = IR[`RS];
            A3 = IR[`RT];
            Tnew = 3;
            Tuse1 = 1;
        end

        `lw: begin
            A1 = IR[`RS];
            A3 = IR[`RT];
            Tnew = 3;
            Tuse1 = 1;
        end

        //  store
        `sb: begin
            A1 = IR[`RS];
            A2 = IR[`RT];
            Tuse1 = 1;
            Tuse2 = 2;
        end

        `sh: begin
            A1 = IR[`RS];
            A2 = IR[`RT];
            Tuse1 = 1;
            Tuse2 = 2;
        end

        `sw: begin
            A1 = IR[`RS];
            A2 = IR[`RT];
            Tuse1 = 1;
            Tuse2 = 2;
        end

        `mas: begin
            A1 = IR[`RS];
            A2 = IR[`RT];
            Tuse1 = 1;
            Tuse2 = 1;
        end
        default: begin
        end
    endcase


end

endmodule // atcoder
