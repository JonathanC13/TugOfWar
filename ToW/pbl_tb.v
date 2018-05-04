`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:28:07 03/07/2018 
// Design Name: 
// Module Name:    pbl_tb 
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
module PBL_tb;

	// Inputs
	reg pbl;
	reg pbr;
	reg clr;
	reg rst;

	// Outputs
	wire push;
	wire tie;
	wire right;

	// Instantiate the Unit Under Test (UUT)
	PBL uut (
		.pbl(pbl), 
		.pbr(pbr), 
		.clr(clr), 
		.rst(rst), 
		.push(push), 
		.tie(tie), 
		.right(right)
	);

	initial begin
		// Initialize Inputs
		pbl = 0;
		pbr = 0;
		clr = 0;
		rst = 0;

		#5;
		rst = 1; #10;
		rst = 0; #10;
		
		// test right push
		pbr = 1; pbl = 0; #10;
		pbr = 0; pbl = 0; clr = 1; #2; clr = 0;
		
		// test left push
		pbr = 0; pbl = 1; #10;
		pbr = 0; pbl = 0; clr = 1; #2; clr = 0;
		
		// test tie
		pbr = 1; pbl = 1; #10;
		pbr = 0; pbl = 0; clr = 1; #2; clr = 0;
		
		// test no push
		pbr = 0; pbl = 0; #10;
		pbr = 0; pbl = 0; clr = 1; #2; clr = 0;

	end
      
endmodule
