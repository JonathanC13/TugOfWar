`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:59:46 03/14/2018 
// Design Name: 
// Module Name:    LFSR_TB 
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
module LFSR_tb;

	// Inputs
	reg slowenable;
	reg rst;

	// Outputs
	wire rout;

	// Instantiate the Unit Under Test (UUT)
	LFSR uut (
		.slowenable(slowenable), 
		.rst(rst),
		.rout(rout)
	);
	
	always #1 slowenable = ~slowenable;

	initial begin
		// Initialize Inputs
		rst = 0;
		slowenable = 0;
		
		#20; rst = 1;
		#20; rst = 0;

		// Wait 100 ns for global reset to finish
		#100000000;
        
		// Add stimulus here

	end
      
endmodule
