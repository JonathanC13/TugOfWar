`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:58:40 03/14/2018 
// Design Name: 
// Module Name:    div256 
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
module div256(clk, rst, slowenable);
	input clk;
	input rst;
	output slowenable;

	reg [7:0] count;

		always@(posedge clk or posedge rst)
			if (rst) count <= 0;
			else count <= count + 1;
			
		assign slowenable = &count;
		
endmodule
