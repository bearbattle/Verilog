`timescale 1ns / 1ps

module mux_2_6(
           input sel,
           input [5:0] option0,
           input [5:0] option1,
           output reg [5:0] result
       );

always @(*) begin
    if(sel)
        result <= option1;
    else
        result <= option0;
end

endmodule


    module mux_4_6(
        input [1:0] sel,
        input [5:0] option0,
        input [5:0] option1,
        input [5:0] option2,
        input [5:0] option3,
        output reg [5:0] result
    );

always @(*) begin
    case (sel)
        2'b00:
            result <= option0;
        2'b01:
            result <= option1;
        2'b10:
            result <= option2;
        2'b11:
            result <= option3;
        default:
            result <= 6'd0;
    endcase
end

endmodule //

    module mux_2_32(
    );

endmodule //

    module mux_4_32(
    );

endmodule //
