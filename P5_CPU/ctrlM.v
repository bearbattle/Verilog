`timescale 1ns / 1ps

`include "const.v"

module MController(
        input [31:0] IR,
        output DMWr
    );


assign DMWr = IR[`OP] == `sw ? 1 : 0;

endmodule