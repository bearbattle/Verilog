`timescale 1ps / 1ns

module and(input [5:0] opcode,
           input [5:0] funct,
           output reg isori,
           output reg islw,
           output reg issw,
           output reg isbeq,
           output reg islui,
           output reg isjal,
           output reg isaddu,
           output reg issubu,
           output reg isjr);

funct u_funct(.funct(funct), .isaddu(isaddu), .issubu(issubu), .isjr(isjr));
opcode u_opcode(.opcode(opcode), .isori(isori), .islw(islw), .issubu(issw), .isbeq(isbeq), .islui(islui), .isjal(isjal));

endmodule // and
