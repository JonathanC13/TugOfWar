`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:03:26 03/07/2018 
// Design Name: 
// Module Name:    Synchronizer 
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
module Synchronizer(
	input push,
	input clk,
	input rst,
	output sypush
    );
	reg regsypush;
		assign sypush = regsypush;
		
		always@(posedge clk or posedge rst)
			if (rst) regsypush <= 0;
			else regsypush <= push;
endmodule
