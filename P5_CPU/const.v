`define OP 31:26
`define FT 5:0
`define RS 25:21
`define RT 20:16
`define RD 15:11

`define ADD 2'b00
`define SUB 2'b01
`define OR  2'b10

`define UE 2'b00
`define SE 2'b01
`define HE 2'b10

`define R   6'b000000
`define ori 6'b001101
`define lw  6'b100011
`define sw  6'b101011
`define beq 6'b000100
`define lui 6'b001111
`define jal 6'b000011
`define j   6'b000010

`define addu 6'b100001
`define subu 6'b100011
`define jr   6'b001000

`define ADD4    2'd0
`define NPC     2'd1
`define JRPC    2'd2

`define DR  2'd0
`define AO  2'd1
`define PC  2'd2