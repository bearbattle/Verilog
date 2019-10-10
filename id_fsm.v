module id_fsm(
    input clk,
    input [7:0] char,
    output reg out);

reg stat[1:0] = 0;
out = 0;

always @(posedge clk) begin
    case(stat)
        2'd0: begin
            if(char >= 'A' && char <= 'z') begin
                stat = 2'd2;
                out = 0;
            end
            else begin
                stat = 2'd0;
                out = 0;
            end
        end
        2'd1: begin
            if(char >= 'A' && char <= 'z') begin
                stat = 2'd2;
                out = 0;
            end
            else if(char >= '0' && char <= '9') begin
                stat = 2'd1;
                out = 1;
            end
            else begin
                stat = 2'd0;
                out = 0;
            end
        end
        2'd2: begin
            if(char >= 'A' && char <= 'z') begin
                stat = 2'd2;
                out = 0;
            end
            else if(char >= '0' && char <= '9') begin
                stat = 2'd1;
                out = 1;
            end
            else begin
                stat = 2'd0;
                out = 0;
            end
        end
    endcase
end
endmodule
