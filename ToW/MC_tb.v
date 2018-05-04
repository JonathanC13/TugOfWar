`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:00:12 03/14/2018 
// Design Name: 
// Module Name:    MC_tb 
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
module MC_tb;

	// Inputs
	reg slowenable;
	reg rout;
	reg winrnd;
	reg clk;
	reg rst;

	// Outputs
	wire leds_on;
	wire [1:0] leds_ctrl;
	wire clear;

	// Instantiate the Unit Under Test (UUT)
	MC uut (
		.slowenable(slowenable), 
		.rout(rout), 
		.winrnd(winrnd), 
		.clk(clk), 
		.rst(rst), 
		.leds_on(leds_on), 
		.leds_ctrl(leds_ctrl), 
		.clear(clear)
	);
	
	always #5 clk = ~clk;

	initial begin
		// Initialize Inputs
		slowenable = 0;
		rout = 0;
		winrnd = 0;
		clk = 0;
		rst = 0;
		
		// Reset
		$display("%t - Resetting ===", $time);
		@(posedge clk); #5; rst = 1;
		if (leds_on==1 & clear==1 & leds_ctrl==2) $display("Success");
		
		// reset 0 to move to Wait_a
		@(posedge clk); #5; rst = 0;
		repeat(5) @(posedge clk);
		$display("Reset LOW ===");
		if (leds_on==1 & clear==1 & leds_ctrl==1) $display("Success");
		repeat(5) @(posedge clk);
		
		// In Wait_a move to Wait_b
		$display("At state Wait_a to Wait_b ===");
		#1 slowenable = 1;
		repeat(5) @(posedge clk);
		if (leds_on==1 & clear==1 & leds_ctrl==1) $display("Success");
		#1 slowenable = 0;
		repeat(5) @(posedge clk); 

		// In Wait_b move to Dark/Random
		$display("At state Wait_b move to Dark/Random ===");
		#1 slowenable = 1;
		repeat(5) @(posedge clk);
		if (leds_on==0 & clear==0 & leds_ctrl==0) $display("Success");
		#1 slowenable = 0;
		repeat(5) @(posedge clk); 
		
		
		// In Dark/Random move to Play
		$display("At state Dark/Random move to Play ===");
		#1 slowenable = 1; rout = 1;
		repeat(5) @(posedge clk);
		if (leds_on==1 & clear==0 & leds_ctrl==3) $display("Success");
		#1 slowenable = 0; rout = 0;
		repeat(5) @(posedge clk); 
		
		// In Play move to Gloat_a
		$display("At state Play move to Gloat_a ===");
		#1 winrnd = 1;
		repeat(5) @(posedge clk);
		if (leds_on==1 & clear==1 & leds_ctrl==3) $display("Success");
		#1 winrnd = 0;
		repeat(5) @(posedge clk); 
		
		// In Gloat_a move to Gloat_b
		$display("At state Gloat_a move to Gloat_b ===");
		#1 slowenable = 1;
		repeat(5) @(posedge clk);
		if (leds_on==1 & clear==1 & leds_ctrl==3) $display("Success");
		#1 slowenable = 0;
		repeat(5) @(posedge clk); 
		
		// In Gloat_b move to Dark/Random
		$display("At state Gloat_b move to Dark/Random ===");
		#1 slowenable = 1;
		repeat(5) @(posedge clk);
		if (leds_on==0 & clear==0 & leds_ctrl==0) $display("Success");
		#1 slowenable = 0;
		repeat(5) @(posedge clk); 
		
		// In Dark/Random move to Gloat_a
		$display("At state Dark/Random move to Gloat_a ===");
		#1 winrnd = 1;
		repeat(5) @(posedge clk);
		if (leds_on==1 & clear==1 & leds_ctrl==3) $display("Success");
		#1 winrnd = 0;
		repeat(5) @(posedge clk); 

		#1000;
		$finish;
		
	end
      
endmodule


