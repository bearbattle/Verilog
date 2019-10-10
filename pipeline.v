module pipeline(
    input clk,
    input [31:0] A1,
    input [31:0] A2,
    input [31:0] B1,
    input [31:0] B2,
    output reg [31:0] C = 0);

reg [31:0] buff[1:0];
integer i;

initial begin
    for(i = 0; i < 2; i++)
        buff[i] = 0;
end

always @(posedge clk) begin
    buff[0] <= A1 * B1;
    buff[1] <= A2 * B2;
    C <= buff[0] + buff[1];
end
endmodule
