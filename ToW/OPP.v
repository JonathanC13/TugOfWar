`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:09:08 03/07/2018 
// Design Name: 
// Module Name:    OPP 
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
module OPP(
	input sypush,
	input rst,
	input clk,
	output winrnd
    );
	 
	reg regwinrnd;
	
		assign winrnd = ~regwinrnd & sypush;
		
		always@(posedge clk or posedge rst)
			if (rst) regwinrnd <= 1;
			else regwinrnd <= sypush;

endmodule
