`timescale 1ns / 1ps

`include "const.v"

module StallController(
           input [31:0] IRD,
           input [31:0] IRE,
           input [31:0] IRM,
           output enPC,
           output enD,
           output FlushE
       );

wire stall_b, stall_b_c_r, stall_b_c_i, stall_b_l_E, stall_b_l_M;
wire stall_c_r;
wire stall_c_i;
wire stall_l;
wire stall_s;

wire stall;

assign stall_b_c_r = (IRD[`OP] == `beq) && (IRE[`OP] == `R) && ((IRD[`RS] == IRE[`RD]) || (IRD[`RT] == IRE[`RD]));
assign stall_b_c_i = (IRD[`OP] == `beq) && ((IRE[`OP] == `ori) || (IRE[`OP] == `lui)) && ((IRD[`RS] == IRE[`RT]) || (IRD[`RT] == IRE[`RT]));
assign stall_b_l_E = (IRD[`OP] == `beq) && (IRE[`OP] == `R) && ((IRD[`RS] == IRE[`RD]) || (IRD[`RT] == IRE[`RD]));
assign stall_b_l_M = (IRD[`OP] == `beq) && (IRM[`OP] == `R) && ((IRM[`RS] == IRE[`RD]) || (IRM[`RT] == IRE[`RD]));
assign stall_b = stall_b_c_r || stall_b_c_i || stall_b_l_E || stall_b_l_M;

assign stall_c_r = ( (IRD[`OP] == `R) ) &&
       ((IRE[`OP] == `lw) && ((IRE[`RT] == IRD[`RS]) || (IRE[`RT] == IRD[`RT])));

assign stall_c_i = ((IRD[`OP] == `ori) || (IRD[`OP] == `lui)) &&
       ((IRE[`OP] == `lw) && ((IRE[`RT] == IRD[`RS]) ));

assign stall_l = (IRD[`OP] == `lw) &&
       ((IRE[`OP] == `lw) && (IRE[`RT] == IRE[`RS]));

assign stall_s = (IRD[`OP] == `sw) &&
       ((IRE[`OP] == `lw) && (IRE[`RT] == IRE[`RS]));

assign stall = stall_b || stall_c_r || stall_c_i || stall_l || stall_s;

assign enPC = ~stall;
assign enD = ~stall;
assign FlushE = stall;

endmodule

    module forward(
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

    if(IRD[`OP] == `beq || (IRD[`OP] == `R && IRD[`FT] == `jr)) begin
        case (IRW[`OP]) // MEM/WB
            `R: begin
                if(IRW[`FT] != `jr && IRM[`RD] == IRD[`RS]) //cal_r
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

    // IF/ID | rt | beq, jr | FRTDSel

    if(IRD[`OP] == `beq || //beq
            (IRD[`OP] == `R && IRD[`FT] == `jr)) begin //jr
        case (IRW[`OP]) // MEM/WB
            `R: begin
                if(IRW[`FT] != `jr && IRM[`RD] == IRD[`RT]) //cal_r
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

    // ID/EX | rs | cal_r, cal_i, ld, st | FRSESel

    if((IRE[`OP] == `R && IRE[`FT] != `jr) ||   //cal_r
            IRE[`OP] == `ori || IRE[`OP] == `lui || //cal_i
            IRE[`OP] == `lw ||                      //ld
            IRE[`OP] == `sw) begin                  //st
        case (IRW[`OP]) // MEM/WB
            `R: begin
                if(IRW[`FT] != `jr && IRM[`RD] == IRE[`RS]) //cal_r
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

    // ID/EX | rt | cal_r, st | FRTESel

    if((IRE[`OP] == `R && IRE[`FT] != `jr) ||   //cal_r
            //IRE[`OP] == `ori || IRE[`OP] == `lui || //cal_i
            //IRE[`OP] == `lw ||                      //ld
            IRE[`OP] == `sw) begin                  //st
        case (IRW[`OP]) // MEM/WB
            `R: begin
                if(IRW[`FT] != `jr && IRM[`RD] == IRE[`RT]) //cal_r
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

    //EX/MEM | rt | st | FRTMSel

    if(//(IRE[`OP] == `R && IRE[`FT] != `jr) ||   //cal_r
            //IRE[`OP] == `ori || IRE[`OP] == `lui || //cal_i
            //IRE[`OP] == `lw ||                      //ld
            IRE[`OP] == `sw) begin                  //st
        case (IRW[`OP]) // MEM/WB
            `R: begin
                if(IRW[`FT] != `jr && IRM[`RD] == IRE[`RT]) //cal_r
                    FRTMSel = 1;
            end
            `ori: begin
                if(IRW[`RT] == IRE[`RT]) //cal_i: ori
                    FRTMSel = 1;
            end
            `lui: begin
                if(IRW[`RT] == IRE[`RT]) //cal_i: lui
                    FRTMSel = 1;
            end
            `lw: begin
                if(IRW[`RT] == IRE[`RT]) //lw
                    FRTMSel = 1;
            end
            `jal: begin //jal
                if(5'd31 == IRE[`RT])
                    FRTMSel = 2;
            end
        endcase
    end

end

endmodule
