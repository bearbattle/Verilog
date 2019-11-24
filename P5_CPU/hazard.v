`timescale 1ns / 1ps

`include "const.v"

module StallController(
           //    input [31:0] IRD,
           //    input [31:0] IRE,
           //    input [31:0] IRM,
           output enPC,
           output enD,
           output FlushE
       );

reg stall_e;
reg stall_m;
reg stall_w;

wire stall;

assign stall = stall_e | stall_m | stall_w;

initial begin
    stall_e = 0;
    stall_m = 0;
    stall_w = 0;
end

always@(*) begin
    stall_e = 0;
    stall_m = 0;
    stall_w = 0;
    // E:A1
    if(D.A1D != 0 && E.A3E == D.A1D && E.TnewE > D.Tuse1D)
        stall_e = 1;
    // E:A2
    if(D.A2D != 0 && E.A3E == D.A2D && E.TnewE > D.Tuse2D)
        stall_e = 1;

    // M:A1
    if(D.A1D != 0 && M.A3M == D.A1D && M.TnewM > D.Tuse1D)
        stall_m = 1;
    // M:A2
    if(D.A2D != 0 && M.A3M == D.A2D && M.TnewM > D.Tuse2D)
        stall_m = 1;
end

assign enPC = ~stall;
assign enD = ~stall;
assign FlushE = stall;

endmodule

    module ForwardController(
        input [31:0] IRD,
        input [31:0] IRE,
        input [31:0] IRM,
        input [31:0] IRW,
        output reg [2:0] FRSDSel,
        output reg [2:0] FRTDSel,
        output reg [2:0] FRSESel,
        output reg [2:0] FRTESel,
        output reg [2:0] FRTMSel
    );

initial begin
    FRSDSel = 0;
    FRTDSel = 0;
    FRSESel = 0;
    FRTESel = 0;
    FRTMSel = 0;
end

always @(*) begin
    FRSDSel = 0;
    FRTDSel = 0;
    FRSESel = 0;
    FRTESel = 0;
    FRTMSel = 0;

    // IF/ID | rs | beq, jr | FRSDSel

    if(IRD[`RS] != 5'b0) begin
        if(IRD[`OP] == `beq || (IRD[`OP] == `R && IRD[`FT] == `jr)) begin
            case (IRW[`OP]) // MEM/WB
                `R: begin
                    if(IRW[`FT] != `jr && IRW[`RD] == IRD[`RS]) //cal_r
                        FRSDSel = 1;
                end
                `ori: begin
                    if(IRW[`RT] == IRD[`RS]) //cal_i: ori
                        FRSDSel = 1;
                end
                `lui: begin
                    if(IRW[`RT] == IRD[`RS]) //cal_i: lui
                        FRSDSel = 1;
                end
                `lw: begin
                    if(IRW[`RT] == IRD[`RS]) //lw
                        FRSDSel = 1;
                end
                `jal: begin //jal
                    if(5'd31 == IRD[`RS])
                        FRSDSel = 2;
                end
            endcase

            case(IRM[`OP]) // EX/MEM
                `R: begin
                    if(IRM[`FT] != `jr && IRM[`RD] == IRD[`RS]) //cal_r
                        FRSDSel = 3;
                end
                `ori: begin
                    if(IRM[`RT] == IRD[`RS]) //cal_i: ori
                        FRSDSel = 3;
                end
                `lui: begin
                    if(IRM[`RT] == IRD[`RS]) //cal_i: lui
                        FRSDSel = 3;
                end
                `jal: begin
                    if(5'd31 == IRD[`RS]) //jal
                        FRSDSel = 4;
                end
            endcase
        end
    end

    // IF/ID | rt | beq | FRTDSel

    if(IRD[`RT] != 5'b0) begin
        if(IRD[`OP] == `beq) begin //jr
            case (IRW[`OP]) // MEM/WB
                `R: begin
                    if(IRW[`FT] != `jr && IRW[`RD] == IRD[`RT]) //cal_r
                        FRTDSel = 1;
                end
                `ori: begin
                    if(IRW[`RT] == IRD[`RT]) //cal_i: ori
                        FRTDSel = 1;
                end
                `lui: begin
                    if(IRW[`RT] == IRD[`RT]) //cal_i: lui
                        FRTDSel = 1;
                end
                `lw: begin
                    if(IRW[`RT] == IRD[`RT]) //lw
                        FRTDSel = 1;
                end
                `jal: begin
                    if(5'd31 == IRD[`RT])//jal
                        FRTDSel = 2;
                end
            endcase

            case(IRM[`OP]) // EX/MEM
                `R: begin
                    if(IRM[`FT] != `jr && IRM[`RD] == IRD[`RT]) //cal_r
                        FRTDSel = 3;
                end
                `ori: begin
                    if(IRM[`RT] == IRD[`RT]) //cal_i: ori
                        FRTDSel = 3;
                end
                `lui: begin
                    if(IRM[`RT] == IRD[`RT]) //cal_i: lui
                        FRTDSel = 3;
                end
                `jal: begin
                    if(5'd31 == IRD[`RT]) //jal
                        FRTDSel = 4;
                end
            endcase
        end
    end

    // ID/EX | rs | cal_r, cal_i, ld, st | FRSESel

    if(IRE[`RS] != 5'b0) begin
        if((IRE[`OP] == `R && IRE[`FT] != `jr) ||   //cal_r
                IRE[`OP] == `ori || IRE[`OP] == `lui || //cal_i
                IRE[`OP] == `lw ||                      //ld
                IRE[`OP] == `sw) begin                  //st
            case (IRW[`OP]) // MEM/WB
                `R: begin
                    if(IRW[`FT] != `jr && IRW[`RD] == IRE[`RS]) //cal_r
                        FRSESel = 1;
                end
                `ori: begin
                    if(IRW[`RT] == IRE[`RS]) //cal_i: ori
                        FRSESel = 1;
                end
                `lui: begin
                    if(IRW[`RT] == IRE[`RS]) //cal_i: lui
                        FRSESel = 1;
                end
                `lw: begin
                    if(IRW[`RT] == IRE[`RS]) //lw
                        FRSESel = 1;
                end
                `jal: begin //jal
                    if(5'd31 == IRE[`RS])
                        FRSESel = 2;
                end
            endcase

            case(IRM[`OP]) // EX/MEM
                `R: begin
                    if(IRM[`FT] != `jr && IRM[`RD] == IRE[`RS]) //cal_r
                        FRSESel = 3;
                end
                `ori: begin
                    if(IRM[`RT] == IRE[`RS]) //cal_i: ori
                        FRSESel = 3;
                end
                `lui: begin
                    if(IRM[`RT] == IRE[`RS]) //cal_i: lui
                        FRSESel = 3;
                end
                `jal: begin
                    if(5'd31 == IRE[`RS]) //jal
                        FRSESel = 4;
                end
            endcase
        end
    end

    // ID/EX | rt | cal_r, st | FRTESel

    if(IRE[`RT] != 5'b0) begin
        if((IRE[`OP] == `R && IRE[`FT] != `jr) ||   //cal_r
                //IRE[`OP] == `ori || IRE[`OP] == `lui || //cal_i
                //IRE[`OP] == `lw ||                      //ld
                IRE[`OP] == `sw) begin                  //st
            case (IRW[`OP]) // MEM/WB
                `R: begin
                    if(IRW[`FT] != `jr && IRW[`RD] == IRE[`RT]) //cal_r
                        FRTESel = 1;
                end
                `ori: begin
                    if(IRW[`RT] == IRE[`RT]) //cal_i: ori
                        FRTESel = 1;
                end
                `lui: begin
                    if(IRW[`RT] == IRE[`RT]) //cal_i: lui
                        FRTESel = 1;
                end
                `lw: begin
                    if(IRW[`RT] == IRE[`RT]) //lw
                        FRTESel = 1;
                end
                `jal: begin //jal
                    if(5'd31 == IRE[`RT])
                        FRTESel = 2;
                end
            endcase

            case(IRM[`OP]) // EX/MEM
                `R: begin
                    if(IRM[`FT] != `jr && IRM[`RD] == IRE[`RT]) //cal_r
                        FRTESel = 3;
                end
                `ori: begin
                    if(IRM[`RT] == IRE[`RT]) //cal_i: ori
                        FRTESel = 3;
                end
                `lui: begin
                    if(IRM[`RT] == IRE[`RT]) //cal_i: lui
                        FRTESel = 3;
                end
                `jal: begin
                    if(5'd31 == IRE[`RT]) //jal
                        FRTESel = 4;
                end
            endcase
        end
    end

    //EX/MEM | rt | st | FRTMSel

    if(IRM[`RT] != 5'b0) begin
        if(//(IRE[`OP] == `R && IRE[`FT] != `jr) ||   //cal_r
            //IRE[`OP] == `ori || IRE[`OP] == `lui || //cal_i
            //IRE[`OP] == `lw ||                      //ld
            IRM[`OP] == `sw) begin                  //st
            case (IRW[`OP]) // MEM/WB
                `R: begin
                    if(IRW[`FT] != `jr && IRM[`RD] == IRM[`RT]) //cal_r
                        FRTMSel = 1;
                end
                `ori: begin
                    if(IRW[`RT] == IRM[`RT]) //cal_i: ori
                        FRTMSel = 1;
                end
                `lui: begin
                    if(IRW[`RT] == IRM[`RT]) //cal_i: lui
                        FRTMSel = 1;
                end
                `lw: begin
                    if(IRW[`RT] == IRM[`RT]) //lw
                        FRTMSel = 1;
                end
                `jal: begin //jal
                    if(5'd31 == IRM[`RT])
                        FRTMSel = 2;
                end
            endcase
        end
    end

end

endmodule
