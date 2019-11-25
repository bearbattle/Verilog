`timescale 1ns / 1ps

`include "const.v"

module EController(
        input [31:0] IR,
        output reg [1:0] ALUOp,
        output reg BSel
    );

initial begin
    ALUOp = 0;
    BSel = 0;
end

always @(*) begin
    ALUOp = 0;
    BSel = 0;
    case (IR[`OP])
        // cal_r
        `R: begin
            case (IR[`FT])
                `addu: begin
                    ALUOp = `ADD;
                end

                `subu: begin
                    ALUOp = `SUB;
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
            ALUOp = `OR;
            BSel = 1;
        end

        `lui: begin
            ALUOp = `OR;
            BSel = 1;
        end

        //  link
        `jal: begin
        end

        // b
        `beq: begin
        end

        // load
        `lw: begin
            BSel = 1;
        end

        //  store
        `sw: begin
            BSel = 1;
        end

        default: begin
        end
    endcase
end

endmodule