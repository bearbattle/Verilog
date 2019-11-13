`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:19:50 11/13/2019
// Design Name:   mips
// Module Name:   C:/Users/chao4/Desktop/ISE/P4_CPU/cpu_tb.v
// Project Name:  P4_CPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mips
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cpu_tb;

	// Inputs
	reg clk;
	reg reset;

	// Instantiate the Unit Under Test (UUT)
	mips uut (
		.clk(clk), 
		.reset(reset)
	);

always #10 clk = ~clk;

	initial begin
		$dumpvars(0, uut);
		// Initialize Inputs
		clk <= 0;
		reset <= 1;

		// Wait 100 ns for global reset to finish
		#100;
      
		// Add stimulus here
		reset <= 0;
		#2000;
		$finish;
	end
      
endmodule

