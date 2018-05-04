
module tow_tb;

	// Inputs
	reg pbr;
	reg pbl;
	reg clk;
	reg rst;

	// Outputs
	wire [6:0] leds_out;

	// Instantiate the Unit Under Test (UUT)
	tow uut (
		.pbr(pbr), 
		.pbl(pbl), 
		.clk(clk), 
		.rst(rst), 
		.Led(leds_out)
	);
	
	always #976563 clk = ~clk;

	initial begin
		// Initialize Inputs
		pbr = 0;
		pbl = 0;
		clk = 0;
		rst = 0;
		
		// Reset
		$display("%t - Resetting ", $time);
		@(posedge clk); #976563; rst = 1;
		@(posedge clk); #976563; rst = 0;
		
		// At N to R1
		// Right Push (not jump the gun)
		wait(leds_out == 7'b0000000); // wait for the dark state
		wait(leds_out != 7'b0000000); // wait for play state

		$display("Right pushes first (at correct time)");
		#1 pbr = 1; pbl = 0;
		repeat(5) @(posedge clk); // wait for a slowenable signal to trigger
		#1 pbr = 0; pbl = 0; // reset back to 0
		
		// to R2
		// Right Push (not jump the gun)
		wait(leds_out == 7'b0000000); // wait for the dark state
		wait(leds_out != 7'b0000000); // wait for play state
		$display("Right pushes first (at correct time)");
		
		#1 pbr = 1; pbl = 0;
		repeat(5) @(posedge clk); // wait for a slowenable signal to trigger
		#1 pbr = 0; pbl = 0; // reset back to 0

	// to R3
		// Right Push (not jump the gun)
		wait(leds_out == 7'b0000000); // wait for the dark state
		wait(leds_out != 7'b0000000); // wait for play state
		$display("Right pushes first (at correct time)");
		#1 pbr = 1; pbl = 0;
		repeat(5) @(posedge clk); // wait for a slowenable signal to trigger
		#1 pbr = 0; pbl = 0; // reset back to 0


		// Four transitions from R3: Right jump the gun. Left push on time, Reset, Right push for win state
		
		// Right jump the gun
		wait(leds_out == 7'b0000000); // wait for the dark state
		$display("Right pushes at wrong time");
		#1 pbr = 1; pbl = 0;
		repeat(5) @(posedge clk); // wait for a slowenable signal to trigger
		#1 pbr = 0; pbl = 0; // reset back to 0
		
		// back to R3
		// Right Push (not jump the gun)
		wait(leds_out == 7'b0000000); // wait for the dark state
		wait(leds_out != 7'b0000000); // wait for play state
		$display("Right pushes first (at correct time)");
		#1 pbr = 1; pbl = 0;
		repeat(5) @(posedge clk); // wait for a slowenable signal to trigger
		#1 pbr = 0; pbl = 0; // reset back to 0
		
		// Left push on time
		wait(leds_out == 7'b0000000); // wait for the dark state
		wait(leds_out != 7'b0000000); // wait for play state
		$display("Left pushes first (at correct time)");
		#1 pbr = 0; pbl = 1;
		repeat(5) @(posedge clk); // wait for a slowenable signal to trigger
		#1 pbr = 0; pbl = 0; // reset back to 0
		
		// at R1, move to R2
		// Right Push (not jump the gun)
		wait(leds_out == 7'b0000000); // wait for the dark state
		wait(leds_out != 7'b0000000); // wait for play state
		$display("Right pushes first (at correct time)");
		#1 pbr = 1; pbl = 0;
		repeat(5) @(posedge clk); // wait for a slowenable signal to trigger
		#1 pbr = 0; pbl = 0; // reset back to 0
		
		// move to R3
		// Right Push (not jump the gun)
		wait(leds_out == 7'b0000000); // wait for the dark state
		wait(leds_out != 7'b0000000); // wait for play state
		$display("Right pushes first (at correct time)");
		#1 pbr = 1; pbl = 0;
		repeat(5) @(posedge clk); // wait for a slowenable signal to trigger
		#1 pbr = 0; pbl = 0; // reset back to 0
		
		// reset to N
		wait(leds_out == 7'b0000000); // wait for the dark state
		$display("%t - Resetting ", $time);
		@(posedge clk); #976563; rst = 1;
		@(posedge clk); #976563; rst = 0;
		
		// To R1
		// Right Push (not jump the gun)
		wait(leds_out == 7'b0000000); // wait for the dark state
		wait(leds_out != 7'b0000000); // wait for play state
		$display("Right pushes first (at correct time)");
		#1 pbr = 1; pbl = 0;
		repeat(5) @(posedge clk); // wait for a slowenable signal to trigger
		#1 pbr = 0; pbl = 0; // reset back to 0
		
		// To R2
		// Right Push (not jump the gun)
		wait(leds_out == 7'b0000000); // wait for the dark state
		wait(leds_out != 7'b0000000); // wait for play state
		$display("Right pushes first (at correct time)");
		#1 pbr = 1; pbl = 0;
		repeat(5) @(posedge clk); // wait for a slowenable signal to trigger
		#1 pbr = 0; pbl = 0; // reset back to 0
		
		// To R3
		// Right Push (not jump the gun)
		wait(leds_out == 7'b0000000); // wait for the dark state
		wait(leds_out != 7'b0000000); // wait for play state
		$display("Right pushes first (at correct time)");
		#1 pbr = 1; pbl = 0;
		repeat(5) @(posedge clk); // wait for a slowenable signal to trigger
		#1 pbr = 0; pbl = 0; // reset back to 0
		
		// to Right WIN state
		// Right Push (not jump the gun)
		wait(leds_out == 7'b0000000); // wait for the dark state
		wait(leds_out != 7'b0000000); // wait for play state
		$display("Right pushes first (at correct time)");
		#1 pbr = 1; pbl = 0;
		repeat(5) @(posedge clk); // wait for a slowenable signal to trigger
		#1 pbr = 0; pbl = 0; // reset back to 0
	
		
		// =========================== Right should have won

		// reset to N to test left pushes
		
		wait(leds_out == 7'b0000000); // wait for the dark state
		$display("%t - Resetting ", $time);
		@(posedge clk); #976563; rst = 1;
		@(posedge clk); #976563; rst = 0;
		

		// Left Push (not jump the gun)
		wait(leds_out == 7'b0000000); // wait for the dark state
		wait(leds_out != 7'b0000000); // wait for play state
		$display("Left pushes first (at correct time)");
		#1 pbr = 0; pbl = 1;
		repeat(5) @(posedge clk); // wait for a slowenable signal to trigger
		#1 pbr = 0; pbl = 0; // reset back to 0
		
		// Left Push (not jump the gun)
		wait(leds_out == 7'b0000000); // wait for the dark state
		wait(leds_out != 7'b0000000); // wait for play state
		$display("Left pushes first (at correct time)");
		#1 pbr = 0; pbl = 1;
		repeat(5) @(posedge clk); // wait for a slowenable signal to trigger
		#1 pbr = 0; pbl = 0; // reset back to 0

		// Left Push (not jump the gun)
		wait(leds_out == 7'b0000000); // wait for the dark state
		wait(leds_out != 7'b0000000); // wait for play state
		$display("Left pushes first (at correct time)");
		#1 pbr = 0; pbl = 1;
		repeat(5) @(posedge clk); // wait for a slowenable signal to trigger
		#1 pbr = 0; pbl = 0; // reset back to 0


		//  Four transitions from R3: Left jump the gun. Right push on time, Reset, Left push for win state

		// Left jump the gun
		wait(leds_out == 7'b0000000); // wait for the dark state
		$display("Left pushes at wrong time");
		#1 pbr = 0; pbl = 1;
		repeat(5) @(posedge clk); // wait for a slowenable signal to trigger
		#1 pbr = 0; pbl = 0; // reset back to 0
		
		// back to L3
		//Left Push (not jump the gun)
		wait(leds_out == 7'b0000000); // wait for the dark state
		wait(leds_out != 7'b0000000); // wait for play state
		$display("Left pushes first (at correct time)");
		#1 pbr = 0; pbl = 1;
		repeat(5) @(posedge clk); // wait for a slowenable signal to trigger
		#1 pbr = 0; pbl = 0; // reset back to 0
		
		// Right push on time
		wait(leds_out == 7'b0000000); // wait for the dark state
		wait(leds_out != 7'b0000000); // wait for play state
		$display("Right pushes first (at correct time)");
		#1 pbr = 1; pbl = 0;
		repeat(5) @(posedge clk); // wait for a slowenable signal to trigger
		#1 pbr = 0; pbl = 0; // reset back to 0
		
		// at L1, move to L2
		// Left Push (not jump the gun)
		wait(leds_out == 7'b0000000); // wait for the dark state
		wait(leds_out != 7'b0000000); // wait for play state
		$display("Left pushes first (at correct time)");
		#1 pbr = 0; pbl = 1;
		repeat(5) @(posedge clk); // wait for a slowenable signal to trigger
		#1 pbr = 0; pbl = 0; // reset back to 0
		
		// move to L3		
		// Left Push (not jump the gun)
		wait(leds_out == 7'b0000000); // wait for the dark state
		wait(leds_out != 7'b0000000); // wait for play state
		$display("Left pushes first (at correct time)");
		#1 pbr = 0; pbl = 1;
		repeat(5) @(posedge clk); // wait for a slowenable signal to trigger
		#1 pbr = 0; pbl = 0; // reset back to 0
		
		// reset to N
		wait(leds_out == 7'b0000000); // wait for the dark state
		$display("%t - Resetting ", $time);
		@(posedge clk); #976563; rst = 1;
		@(posedge clk); #976563; rst = 0;
		
		// To L1
		// Left Push (not jump the gun)
		wait(leds_out == 7'b0000000); // wait for the dark state
		wait(leds_out != 7'b0000000); // wait for play state
		$display("Left pushes first (at correct time)");
		#1 pbr = 0; pbl = 1;
		repeat(5) @(posedge clk); // wait for a slowenable signal to trigger
		#1 pbr = 0; pbl = 0; // reset back to 0
		
		// To L2
		// left Push (not jump the gun)
		wait(leds_out == 7'b0000000); // wait for the dark state
		wait(leds_out != 7'b0000000); // wait for play state
		$display("Left pushes first (at correct time)");
		#1 pbr = 0; pbl = 1;
		repeat(5) @(posedge clk); // wait for a slowenable signal to trigger
		#1 pbr = 0; pbl = 0; // reset back to 0
		
		// To L3
		// Left Push (not jump the gun)
		wait(leds_out == 7'b0000000); // wait for the dark state
		wait(leds_out != 7'b0000000); // wait for play state
		$display("Left pushes first (at correct time)");
		#1 pbr = 0; pbl = 1;
		repeat(5) @(posedge clk); // wait for a slowenable signal to trigger
		#1 pbr = 0; pbl = 0; // reset back to 0
		
		// to LEFT WIN state
		// Left Push (not jump the gun)
		wait(leds_out == 7'b0000000); // wait for the dark state
		wait(leds_out != 7'b0000000); // wait for play state
		$display("Right pushes first (at correct time)");
		#1 pbr = 0; pbl = 1;
		repeat(5) @(posedge clk); // wait for a slowenable signal to trigger
		#1 pbr = 0; pbl = 0; // reset back to 0
		
				
		// =========================== LEFT SHOULD HAVE WON


		wait(leds_out == 7'b0000000); // wait for the dark state
		$display("%t - Resetting ", $time);
		@(posedge clk); #976563; rst = 1;
		@(posedge clk); #976563; rst = 0;

		
		wait(leds_out == 7'b0000000); // wait for the dark state

		// Wait 100 ns for global reset to finish
		#100000;

	end
     
endmodule