`timescale 1ns / 1ps

module cpu_tb;

	// Inputs
	reg clk;
	reg reset;

	// Instantiate the Unit Under Test (UUT)
	mips uut (
		.clk(clk), 
		.reset(reset)
	);

always #2 clk = ~clk;

	initial begin
		$dumpvars(0, uut);
		// Initialize Inputs
		clk <= 0;
		reset <= 1;

		// Wait 100 ns for global reset to finish
		#10;
      
		// Add stimulus here
		reset <= 0;
		#15000;
		$finish;
	end
      
endmodule

