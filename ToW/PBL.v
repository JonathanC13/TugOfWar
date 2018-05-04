`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:56:21 03/07/2018 
// Design Name: 
// Module Name:    PBL 
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
module PBL(
    input pbl,
    input pbr,
    input clr,
    input rst,
    output push,
    output tie,
    output right
    );

wire qr, ql, triggerR, triggerL;

assign triggerR = pbr & ~ql;
assign triggerL = pbl & ~qr;

RSLatch latchR (triggerR, clr, rst, qr);
RSLatch latchL (triggerL, clr, rst, ql);

assign push = qr | ql;
assign tie = qr & ql;
assign right = qr; 

endmodule