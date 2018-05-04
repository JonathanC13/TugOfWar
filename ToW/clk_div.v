//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:48:15 12/04/2014 
// Design Name: 
// Module Name:    clk_div 
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
module clk_div(CLK_I,rst, clk );

// input port
input CLK_I,rst;
//outout port
output reg clk;

// counter size calculation according to input and output frequencies
parameter sys_clk = 100000000;	// 100 MHz clock input
parameter clk_out = 500;	// 500 Hz clock output
//parameter max = sys_clk / (2*clk_out); // max-counter size
parameter max = sys_clk / (2*clk_out); // max-counter size

reg [22:0]counter = 0; // 1-bit counter size

always@(posedge CLK_I or posedge rst) begin
	if(rst)
	begin
	   counter <= 0;
		clk <= 0;
	end
	else if (counter == max-1)
		begin
		counter <= 0;
		clk <= ~clk;
		end
	else
		begin
		counter <= counter + 1'd1;
		end
	end

endmodule
