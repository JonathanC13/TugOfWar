`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:58:11 03/14/2018 
// Design Name: 
// Module Name:    MC 
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
module MC(input slowenable,
    input rout,
    input winrnd,
    input clk,
    input rst,
    output leds_on,
    output [1:0] leds_ctrl,
    output clear
    );

reg reg_leds_on;
reg [1:0] reg_leds_ctrl;
reg reg_clear;

reg [2:0] state;
reg [2:0] nxtstate;

assign leds_on = reg_leds_on;
assign leds_ctrl = reg_leds_ctrl;
assign clear = reg_clear;

`define reset		0
`define wait_a		1
`define wait_b		2
`define dark		3
`define play		4
`define gloat_a	5
`define gloat_b	6

`define ALL_OFF   0  // all leds off
`define ALL_ON   1  // all leds on
`define RESET_CODE   2  // error/reset code
`define SCORE  3  // score

always @(posedge clk or posedge rst)
	if ( rst ) state <= `reset;
	else state <= nxtstate;
	
// Next state logic
always @(state or rst or slowenable or winrnd or rout)
	case (state)
		`reset:
			if (!rst) nxtstate <= `wait_a; else nxtstate <= `reset;
		`wait_a:
			if (slowenable) nxtstate <= `wait_b; else nxtstate <= `wait_a;
		`wait_b:
			if (slowenable) nxtstate <= `dark; else nxtstate <= `wait_b;
		`dark:
			if (winrnd) nxtstate <= `gloat_a;
			else if (slowenable && rout) nxtstate <= `play;
			else nxtstate <= `dark;
		`play:
			if (winrnd) nxtstate <= `gloat_a; else nxtstate <= `play;
		`gloat_a:
			if (slowenable) nxtstate <= `gloat_b; else nxtstate <= `gloat_a;
		`gloat_b:
			if (slowenable) nxtstate <= `dark; else nxtstate <= `gloat_b;
		default: nxtstate <= `reset;
	endcase

// Output logic	
always @(state)
	case(state)
		`reset:
			begin
				reg_leds_on <= 1;
				reg_clear <= 1;
				reg_leds_ctrl <= `RESET_CODE;
			end
		`wait_a:
			begin
				reg_leds_on <= 1;
				reg_clear <= 1;
				reg_leds_ctrl <= `ALL_ON;
			end
		`wait_b:
			begin
				reg_leds_on <= 1;
				reg_clear <= 1;
				reg_leds_ctrl <= `ALL_ON;
			end
		`dark:
			begin
				reg_leds_on <= 0;
				reg_clear <= 0;
				reg_leds_ctrl <= `ALL_OFF;
			end
		`play:
			begin
				reg_leds_on <= 1;
				reg_clear <= 0;
				reg_leds_ctrl <= `SCORE;
			end
		`gloat_a:
			begin
				reg_leds_on <= 1;
				reg_clear <= 1;
				reg_leds_ctrl <= `SCORE;
			end
		`gloat_b:
			begin
				reg_leds_on <= 1;
				reg_clear <= 1;
				reg_leds_ctrl <= `SCORE;
			end
		default:
			begin
				reg_leds_on <= 0;
				reg_clear <= 1;
				reg_leds_ctrl <= `RESET_CODE;
			end		
	endcase

endmodule
