module ledmux(
    input [1:0] leds_ctrl,
    input [6:0] score,
    output [6:0] leds_out
    );
	 
reg [6:0] leds_out_reg;

assign leds_out = leds_out_reg;

//`define ALL_OFF   0  // all leds off
//`define ALL_ON   1  // all leds on
//`define RESET_CODE   2  // error/reset code
//`define SCORE  3  // score

always @(leds_ctrl or score)
	case (leds_ctrl)
		0:	leds_out_reg = 7'b0000000;
		1:	leds_out_reg = 7'b1111111;
		2:	leds_out_reg = 7'b001100;	// 59 + 81 = 140, 000 1100
		3:	leds_out_reg = score;
		default: leds_out_reg = 7'b1010101;
	endcase
endmodule