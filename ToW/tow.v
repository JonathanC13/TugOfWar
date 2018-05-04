`timescale 1ns / 1ps

module tow(
    input pbr,
    input pbl,
    input CLK_I,
    input rst,
    output [6:0] Led,
	output speaker,
	output vol,
	output slowenable,
	output shutdown
    );
//Complete wire signals needed below ???

	wire [1:0] leds_ctrl;
	wire [6:0] score;
	wire slowenable;
	wire rout;
	wire winrnd;
	wire leds_on;
	wire clr;
	wire push;
	wire tie;
	wire right;
	wire sypush;
	
	wire soundenable;

//Slower Clock from 100Mhz to 500Hz -Given DO NOT remove 
	clk_div createCLKdivide(.CLK_I(CLK_I),.rst(rst), .clk(clk));

//----------------------------------------------------------------------
//Instantiate PBL Sync OPP 

	PBL pushbuttonlatch (.pbr(pbr), .pbl(pbl), .clr(clr), .rst(rst), .push(push), .tie(tie), .right(right));
		
	Synchronizer sync (.push(push), .clk(clk), .rst(rst), .sypush(sypush));
		
	OPP opp (.sypush(sypush), .clk(clk), .rst(rst), .winrnd(winrnd));

//----------------------------------------------------------------------
//Instantiate scorer Led_Mux pushCounter

	scorer Scorer(.winrnd(winrnd), .right(right), .tie(tie), .leds_on(leds_on), .clk(clk), .rst(rst), .score(score));

	ledmux LED_MUX (.leds_ctrl(leds_ctrl), .score(score), .leds_out(Led));

	

//----------------------------------------------------------------------
//Div256 LFSR MC speed_controller
	div256 createSlow(.clk(clk), .rst(rst), .slowenable(slowenable));
	 
	LFSR random(.slowenable(slowenable), .rst(rst), .rout(rout)); 
	 
	MC masterController(.slowenable(slowenable),.rout(rout),.winrnd(winrnd),.clk(clk),.rst(rst),. leds_on(leds_on),.leds_ctrl(leds_ctrl),.clear(clr));

//----------------------------------------------------------------------
	
	musicPlayer(.leds_ctrl(leds_ctrl), .CLK_I(CLK_I), .score(score), .soundenable(soundenable), .vol(vol), .speaker(speaker), .shutdown(shutdown));
	
endmodule
