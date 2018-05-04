`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:31:40 03/14/2018 
// Design Name: 
// Module Name:    div256_tb 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module div256_tb;

	// inputs
	reg clk;
	reg rst;
	
	// outputs
    wire slowen;
	
	// Instantiate the Unit Under Test (UUT)
	div256 uut (
		.clk(clk),
		.rst(rst),
		.slowenable(slowenable)
	);
		
	always #976563 clk = ~clk;
		
	initial begin
		// initialize inputs
		clk = 0;
		rst = 0;
		
		// Reset
		$display("%t - Resetting ===", $time);
		@(posedge clk); #5; rst = 1;
		if (slowenable == 0) $display("Success");
		@(posedge clk); #5; rst = 0;
		
		// 256 clks
		$display("Slowenable signal check ===");
		repeat(256) @(posedge clk);
		if (slowenable == 1) $display("Success");
		
		// Reset
		$display("%t - Resetting ===", $time);
		@(posedge clk); #5; rst = 1;
		if (slowenable == 0) $display("Success");
		@(posedge clk); #5; rst = 0;
		
		#1000;
		$finish;
	end

endmodule
