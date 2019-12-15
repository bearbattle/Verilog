`define OP 31:26
`define FT 5:0
`define RS 25:21
`define RT 20:16
`define RD 15:11

//ALUOp
`define ADD  4'd0
`define SUB  4'd1
`define AND  4'd2
`define OR   4'd3
`define XOR  4'd4
`define NOR  4'd5
`define SLL  4'd6
`define SRL  4'd7
`define SRA  4'd8
`define SLLV 4'd9
`define SRLV 4'd10
`define SRAV 4'd11
`define SLT  4'd12
`define SLTU 4'd13

//MDUOp
`define MULT  4'd0
`define MULTU 4'd1
`define DIV   4'd2
`define DIVU  4'd3
`define MTHI  4'd4
`define MTLO  4'd5
`define MFHI  4'd6
`define MFLO  4'd7
`define MADD  4'd8
`define MSUB  4'd9
`define MADDU 4'd10
`define MSUBU 4'd11

//EXTOp
`define UE 2'b00
`define SE 2'b01
`define HE 2'b10

`define R   6'b000000
//load
`define lb  6'b100000
`define lbu 6'b100100
`define lh  6'b100001
`define lhu 6'b100101
`define lw  6'b100011
//store
`define sb  6'b101000
`define sh  6'b101001
`define sw  6'b101011
//cal_i
`define addi  6'b001000
`define addiu 6'b001001
`define andi  6'b001100
`define ori   6'b001101
`define xori  6'b001110
`define lui   6'b001111
`define slti  6'b001010
`define sltiu 6'b001011
//b
`define beq   6'b000100
`define bne   6'b000101
`define blez  6'b000110
`define bgtz  6'b000111
`define bltz  6'b000001
`define bgez  6'b000001
//j
`define j   6'b000010
`define jal 6'b000011

//R
`define add   6'b100000
`define addu  6'b100001
`define sub   6'b100010
`define subu  6'b100011
`define mult  6'b011000
`define multu 6'b011001
`define div   6'b011010
`define divu  6'b011011
`define sll   6'b000000
`define srl   6'b000010
`define sra   6'b000011
`define sllv  6'b000100
`define srlv  6'b000110
`define srav  6'b000111
`define and   6'b100100
`define or    6'b100101
`define xor   6'b100110
`define nor   6'b100111
`define slt   6'b101010
`define sltu  6'b101011
`define jr    6'b001000
`define jalr  6'b001001
`define mfhi  6'b010000
`define mflo  6'b010010
`define mthi  6'b010001
`define mtlo  6'b010011
`define mas   6'b011100
`define madd  6'b000000
`define maddu 6'b000001
`define msub  6'b000100
`define msubu 6'b000101

`define ADD4    2'd0
`define NPC     2'd1
`define JRPC    2'd2

`define DR  2'd0
`define AO  2'd1
`define PC  2'd2
`define MD  2'd3