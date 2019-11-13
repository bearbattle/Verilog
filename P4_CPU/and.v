`timescale 1ns / 1ps

module And(input [5:0] opcode,
           input [5:0] funct,
           output isori,
           output islw,
           output issw,
           output isbeq,
           output islui,
           output isjal,
           output isaddu,
           output issubu,
           output isjr);

opcode u_opcode(.opcode(opcode), .isori(isori), .islw(islw), .issw(issw), .isbeq(isbeq), .islui(islui), .isjal(isjal), .isR(u_funct.isR));
funct u_funct(.funct(funct), .isaddu(isaddu), .issubu(issubu), .isjr(isjr), .isR(u_opcode.isR));

endmodule // And
