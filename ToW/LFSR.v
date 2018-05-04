`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:02:35 03/14/2018 
// Design Name: 
// Module Name:    LFSR 
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
module LFSR(slowenable, rst, rout);
	input slowenable;
	input rst;
	output rout;
	
	reg [9:0] lfsr;
	
		assign rout = lfsr[9];
		
		always@(posedge slowenable or posedge rst)
			if (rst) lfsr[9:0] <= 1;
			else
				begin
					lfsr[8:0] <= lfsr[9:1];
					lfsr[9] <= lfsr[0]^lfsr[3];
				end
endmodule
