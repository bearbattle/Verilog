`timescale 1ns / 1ps

module regD(
           input clk,
           input enD,
           input FlushD,
           input [31:0] Instruction,
           input [31:0] PC4,
           output reg [5:0] opcode,
           output reg [5:0] funct,
           output reg [4:0] rs,
           output reg [4:0] rt,
           output reg [4:0] rd,
           output reg [15:0] imm16,
           output reg [25:0] imm26,
           output reg [31:0] PC4D
       );
initial begin
    opcode = 0;
    funct = 0;
    rs = 0;
    rt = 0;
    rd = 0;
    imm16 = 0;
    imm26 = 0;
    PC4D = 0;
end

always @(posedge clk or posedge FlushD) begin
    if(enD) begin
        {opcode, rs, rt, rd} = Instruction[31:11];
        funct = Instruction[5:0];
        imm16 = Instruction[15:0];
        imm26 = Instruction[25:0];
        PC4D = PC4;
    end
    if(FlushD) begin
        opcode = 0;
        funct = 0;
        rs = 0;
        rt = 0;
        rd = 0;
        imm16 = 0;
        imm26 = 0;
        PC4D = 0;
    end
end


endmodule


    module regE(
        input clk,
        input FlushE,
        input RFWr,
        input [1:0] RFWDSel,
        input DMWr,
        input [1:0] DstSel,
        input [1:0] ALUOp,
        input ALUBSel,
        input [31:0] D32,
        input [31:0] PC4,
        input [4:0] rs,
        input [4:0] rt,
        input [4:0] rd,
        input [31:0] RD1,
        input [31:0] RD2,
        output reg RFWrE,
        output reg [1:0] RFWDSelE,
        output reg DMWrE,
        output reg DstSelE,
        output reg [1:0] ALUOpE,
        output reg ALUBSelE,
        output reg [31:0] D32E,
        output reg [31:0] V1,
        output reg [31:0] V2,
        output reg [31:0] PC4E
    );

initial begin
    RFWrE = 0;
    RFWDSelE = 0;
    DMWrE = 0;
    DstSelE = 0;
    ALUOpE = 0;
    ALUBSelE = 0;
    D32E = 0;
    V1 = 0;
    V2 = 0;
    PC4E = 0;
end

always @(posedge clk or posedge FlushE) begin
    RFWrE = RFWr;
    RFWDSelE = RFWDSel;
    DMWrE = DMWr;
    DstSelE = DstSel;
    ALUOpE = ALUOp;
    ALUBSelE = ALUBSel;
    D32E = D32;
    V1 = RD1;
    V2 = RD2;
    PC4E = PC4;
    if(FlushE) begin
        RFWrE = 0;
        RFWDSelE = 0;
        DMWrE = 0;
        DstSelE = 0;
        ALUOpE = 0;
        ALUBSelE = 0;
        D32E = 0;
        V1 = 0;
        V2 = 0;
        PC4E = 0;
    end
end

endmodule

    module regM(
        input clk,
        input RFWr,
        input [1:0] RFWDSel,
        input DMWr,
        input [4:0] Dst,
        input [31:0] D32,
        input [31:0] ALUC,
        input [31:0] V2,
        input [31:0] PC4,
        output reg RFWrM,
        output reg [1:0] RFWDSelM,
        output reg DMWrM,
        output reg [4:0] DstM,
        output reg [31:0] D32M,
        output reg [31:0] AOM,
        output reg [31:0] V2M,
        output reg [31:0] PC4M
    );

initial begin
    RFWrM = 0;
    RFWDSelM = 0;
    DMWrM = 0;
    DstM = 0;
    D32M = 0;
    AOM = 0;
    V2M = 0;
    PC4M = 0;
end

always @(posedge clk) begin
    RFWrM = RFWr;
    RFWDSelM = RFWDSel;
    DMWrM = DMWr;
    DstM = Dst;
    D32M = D32;
    AOM = ALUC;
    V2M = V2;
    PC4M = PC4;
end

endmodule // regM

          module regW(
              input clk,
              input RFWr,
              input [1:0] RFWDSel,
              input [31:0] D32,
              input [31:0] AO,
              input [31:0] V2,
              input [31:0] PC4,
              output reg RFWrW,
              output reg RFWDSelW,
              output reg [31:0] D32W,
              output reg [31:0] AOW,
              output reg [31:0] PC4W
          );

initial begin
    RFWrW = 0;
    RFWDSelW = 0;
    D32W = 0;
    AOW = 0;
    PC4W = 0;
end

always @(posedge clk ) begin
    RFWrW = RFWr;
    RFWDSelW = RFWDSel;
    D32W = D32;
    AOW = AO;
    PC4W = PC4;
end

endmodule // regW
