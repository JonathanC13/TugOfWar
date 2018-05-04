`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:51:14 03/07/2018 
// Design Name: 
// Module Name:    RSLatch 
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
module RSLatch(
    input trigger,
    input clr,
    input rst,
    output q
    );

wire qx;

assign qx = (trigger | q);
assign q = qx & ~(rst | clr); 

endmodule
