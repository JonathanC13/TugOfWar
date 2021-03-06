// Scorer testbench example
// Gord Allan, Carleton University, Feb 2004

`timescale 1ns/1ns

module scorer_tb;
	
	reg  leds_on,winrnd, rst, right, clk;		// all inputs to the device are regs
	wire [6:0] score;							// output from the device is a wire
	

	
	// THE GOLDEN 2 RULES of testbenches!
	//	1) Never change an input on a clock edge
	//	2) Only look at outputs when they are valid

	reg [6:0] score_reg;						// a SAMPLED version of the device output
	always @(posedge clk or posedge rst)
		if(rst) score_reg <= 0;
		else 	score_reg <= score;

	// set up a clock that toggles every 10 ns
	always #20 clk <= ~clk;
	
	// write the main sequence of the test
	initial begin
		// initialize all inputs
		clk = 0;		rst = 0;
		right = 0;	leds_on = 0;	winrnd = 0;
		
		// to follow rule 1, we wait until the clock edge, 
		// and then move just past it before modifying the input
		
		// EVEN with the reset the system we must follow RULE 1
		@(posedge clk); #1;		// waits for a clock edge, then moves just past it
		rst = 1;				// put the system in reset
		
		// =======================
		@(posedge clk); #1;		
		rst = 0;									// remove the system from reset
		right = 0;	leds_on = 0;	winrnd = 0;		// FIRST test setup
		$display("%t - Setting up for first test. @ next clock edge Score should be 7'b0001000", $time);
		
		

		// =======================
		//@(posedge clk); #1;
		// Check the result from the last test
		//if(score_reg == 7'b0001000) $display("%t - SUCCESS. Score was %b", $time, score_reg);
		//else						$display("%t - ERROR. Score was %b", $time, score_reg);
		
		// setup inputs for next test
		//$display("%t - Setting up for Left jumping the light.", $time);
		//right = 0;	leds_on = 0;	winrnd = 1;		
		
    	//@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		//right = 0;	leds_on = 0;	winrnd = 0;		
        //wait(score_reg == 7'b0000100); $display("%t - SUCCESS. Score was %b", $time, score_reg);

		// =======================
		
		// For an all edge adequate test suite. The test paths could be:
			// t1 = {N, R1, R2, R3, WR}			with right pushes
			// t2 = {N, R1, R2, R3, WR}			with left jumping
			// t3 = {N, R1, R2, R3, R2, R1}		R2 -> R1 with left pushes
			// t3 = {N, R1, R2, R3, R2, R1}		R2 -> R1 with right jumping
			// t4 = {N, R1, R2, R3, R1}			left push, favour losing player
			
			// t5 = {N, L1, L2, L3, WL}			with left pushes
			// t6 = {N, L1, L2, L3, WL}			with right jumping
			// t7 = {N, L1, L2, L3, L2, L1}		L2 -> L1 with right pushes
			// t8 = {N, L1, L2, L3, L2, L1}		L2 -> L1 with left jumping
			// t9 = {N, L1, L2, L3, L1}			right push, favour losing player
			
			// The all transistion adequate test suite = {t1, t2, t3, t4, t5, t6, t7, t8, t9}
			
			//1Possible test path = {N (L PUSH), L1(R PUSH), N (R JUMP), L1 (L JUMP), 
			//2							N (L PUSH), L1 (L PUSH), L2 (R PUSH), L1 (R JUMP), L2 (L JUMP), L1 (L PUSH), 
			//3								L2 (L PUSH), L3 (L JUMP), L2 (R JUMP), L3 (R PUSH), L1 (L PUSH), L2 (L PUSH), L3 (L PUSH), WL,
			//4									RESET, N (R PUSH), R1 (L PUSH), N (L JUMP), R1 (R JUMP), 
			//5										N (R PUSH), R1 (R PUSH), R2 (L PUSH), R1 (L JUMP), R2 (R JUMP), R1 (R PUSH),
			//6											R2 (R PUSH), R3 (R JUMP), R2 (L JUMP), R3 (L PUSH), R1 (R PUSH), R2 (R PUSH), R3 (R PUSH), WR}
			//										
										
							
											
		
		// continue on from here
		// you must test at least the following cases...
		// 	left pushing first from L2
		// 	right pushing first from L2
		// 	left pushing first from R3
		// 	right jumping the light from R3, 
		// 	right pushing first from R3
		
		//	At state N, left push, start				=========================== 1 ===========================
		
		@(posedge clk); #1;
		// Check the result from the last test
		if(score_reg == 7'b0001000) $display("%t - SUCCESS. Score was %b", $time, score_reg);
		else						$display("%t - ERROR. Score was %b", $time, score_reg);
		
		// setup inputs for next test
		$display("%t - Setting up for left pushing.", $time);
		right = 0;	leds_on = 1;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0010000); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state N, left push, end, now state L1	===========================
		
		
		//	At state L1, right push, start				===========================
		
		@(posedge clk); #1;
		$display("%t - Setting up for right pushing.", $time);
		right = 1;	leds_on = 1;	winrnd = 1;	
		
		@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0001000); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state L1, right push, end, now state N	===========================
		
		//	At state N, right jump, start				===========================
		
		@(posedge clk); #1;
		$display("%t - Setting up for right jumping.", $time);
		right = 1;	leds_on = 0;	winrnd = 1;	
		
		@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0010000); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state N, right jump, end, now state L1	===========================
		
		//	At state L1, left jump, start				===========================
		
		@(posedge clk); #1;
		$display("%t - Setting up for left jumping.", $time);
		right = 0;	leds_on = 0;	winrnd = 1;	
		
		@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0001000); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state L1, left jump, end, now state N	===========================
		
		//	At state N, left push, start				=========================== 2 ===========================
		
		@(posedge clk); #1;
		// setup inputs for next test
		$display("%t - Setting up for left pushing.", $time);
		right = 0;	leds_on = 1;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0010000); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state N, left push, end, now state L1	===========================
		
		//	At state L1, left push, start				===========================
		
		@(posedge clk); #1;
		// setup inputs for next test
		$display("%t - Setting up for left pushing.", $time);
		right = 0;	leds_on = 1;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0100000); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state L1, left push, end, now state L2	===========================
		
		//	At state L2, right push, start				===========================
		
		@(posedge clk); #1;
		// setup inputs for next test
		$display("%t - Setting up for right pushing.", $time);
		right = 1;	leds_on = 1;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0010000); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state L2, right push, end, now state L1	===========================
		
		//	At state L1, right jump, start				===========================
		
		@(posedge clk); #1;
		// setup inputs for next test
		$display("%t - Setting up for right jumping.", $time);
		right = 1;	leds_on = 0;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0100000); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state L1, right jump, end, now state L2	===========================
		
		//	At state L2, left jump, start				===========================
		
		@(posedge clk); #1;
		// setup inputs for next test
		$display("%t - Setting up for left jumping.", $time);
		right = 0;	leds_on = 0;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0010000); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state L2, left jump, end, now state L1	===========================
		
		//	At state L1, left push, start				===========================
		
		@(posedge clk); #1;
		// setup inputs for next test
		$display("%t - Setting up for left push.", $time);
		right = 0;	leds_on = 1;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0100000); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state L1, left push, end, now state L2	===========================
		
		//	At state L2, left push, start				=========================== 3 ===========================
		
		@(posedge clk); #1;
		// setup inputs for next test
		$display("%t - Setting up for left push.", $time);
		right = 0;	leds_on = 1;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b1000000); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state L2, left push, end, now state L3	===========================
		
		//	At state L3, left jump, start				===========================
		
		@(posedge clk); #1;
		// setup inputs for next test
		$display("%t - Setting up for left jumping.", $time);
		right = 0;	leds_on = 0;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0100000); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state L3, left jump, end, now state L2	===========================
		
		//	At state L2, right jump, start				===========================
		
		@(posedge clk); #1;
		// setup inputs for next test
		$display("%t - Setting up for right jumping.", $time);
		right = 1;	leds_on = 0;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b1000000); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state L2, right jump, end, now state L3	===========================
		
		//	At state L3, right push, start				===========================
		
		@(posedge clk); #1;
		// setup inputs for next test
		$display("%t - Setting up for right push.", $time);
		right = 1;	leds_on = 1;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0010000); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state L3, right push, end, now state L1	===========================
		
		//	At state L1, left push, start				===========================
		
		@(posedge clk); #1;
		// setup inputs for next test
		$display("%t - Setting up for left push.", $time);
		right = 0;	leds_on = 1;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0100000); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state L1, left push, end, now state L2	===========================
		
		//	At state L2, left push, start				===========================
		
		@(posedge clk); #1;
		// setup inputs for next test
		$display("%t - Setting up for left push.", $time);
		right = 0;	leds_on = 1;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b1000000); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state L2, left push, end, now state L3	===========================
		
		//	At state L3, left push, start				===========================
		
		@(posedge clk); #1;
		// setup inputs for next test
		$display("%t - Setting up for left push.", $time);
		right = 0;	leds_on = 1;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b1110000); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state L3, left push, end, now state WL	===========================
		
		// RESET to state N, start						=========================== 4 ===========================
		
		@(posedge clk); #1;		// waits for a clock edge, then moves just past it
		rst = 1;				// put the system in reset
		
		// =======================
		@(posedge clk); #1;		
		rst = 0;									// remove the system from reset
		right = 0;	leds_on = 0;	winrnd = 0;		// FIRST test setup
		$display("%t - Setting up for first test. @ next clock edge Score should be 7'b0001000", $time);
		
		
		// RESET to state N, end						===========================
		
		//	At state N, right push, start				===========================
		
		@(posedge clk); #1;
		if(score_reg == 7'b0001000) $display("%t - SUCCESS. Score was %b", $time, score_reg);
		else						$display("%t - ERROR. Score was %b", $time, score_reg);
		// setup inputs for next test
		$display("%t - Setting up for right push.", $time);
		right = 1;	leds_on = 1;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0000100); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state N, right push, end, now state R1	===========================
		
		//	At state R1, left push, start				===========================
		
		@(posedge clk); #1;
		// setup inputs for next test
		$display("%t - Setting up for left push.", $time);
		right = 0;	leds_on = 1;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0001000); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state R1, left push, end, now state N	===========================
		
		//	At state N, left jump, start				===========================
		
		@(posedge clk); #1;
		// setup inputs for next test
		$display("%t - Setting up for left jump.", $time);
		right = 0;	leds_on = 0;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0000100); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state N, left jump, end, now state R1	===========================
		
		//	At state R1, right jump, start				===========================
		
		@(posedge clk); #1;
		// setup inputs for next test
		$display("%t - Setting up for right jump.", $time);
		right = 1;	leds_on = 0;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0001000); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state R1, right jump, end, now state N	===========================
		
		//	At state N, right push, start				=========================== 5 ===========================
		
		@(posedge clk); #1;
		// setup inputs for next test
		$display("%t - Setting up for right push.", $time);
		right = 1;	leds_on = 1;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0000100); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state N, right push, end, now state R1	===========================
		
		//	At state R1, right push, start				===========================
		
		@(posedge clk); #1;
		// setup inputs for next test
		$display("%t - Setting up for right push.", $time);
		right = 1;	leds_on = 1;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0000010); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state R1, right push, end, now state R2	===========================
		
		//	At state R2, left push, start				===========================
		
		@(posedge clk); #1;
		// setup inputs for next test
		$display("%t - Setting up for left push.", $time);
		right = 0;	leds_on = 1;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0000100); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state R2, left push, end, now state R1	===========================
		
		//	At state R1, left jump, start				===========================
		
		@(posedge clk); #1;
		// setup inputs for next test
		$display("%t - Setting up for left jump.", $time);
		right = 0;	leds_on = 0;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0000010); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state R1, left jump, end, now state R2	===========================
		
		//	At state R2, right jump, start				===========================
		
		@(posedge clk); #1;
		// setup inputs for next test
		$display("%t - Setting up for right jump.", $time);
		right = 1;	leds_on = 0;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0000100); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state R2, right jump, end, now state R1	===========================
		
		//	At state R1, right push, start				===========================
		
		@(posedge clk); #1;
		// setup inputs for next test
		$display("%t - Setting up for right push.", $time);
		right = 1;	leds_on = 1;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0000010); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state R1, right push, end, now state R2	===========================
		
		//	At state R2, right push, start				=========================== 6 ===========================
		
		@(posedge clk); #1;
		// setup inputs for next test
		$display("%t - Setting up for right push.", $time);
		right = 1;	leds_on = 1;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0000001); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state R2, right push, end, now state R3	===========================
		
		//	At state R3, right jump, start				===========================
		
		@(posedge clk); #1;
		// setup inputs for next test
		$display("%t - Setting up for right jump.", $time);
		right = 1;	leds_on = 0;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0000010); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state R3, right jump, end, now state R2	===========================
		
		//	At state R2, left jump, start				===========================
		
		@(posedge clk); #1;
		// setup inputs for next test
		$display("%t - Setting up for left jump.", $time);
		right = 0;	leds_on = 0;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0000001); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state R2, left jump, end, now state R3	===========================
		
		//	At state R3, left push, start				===========================
		
		@(posedge clk); #1;
		// setup inputs for next test
		$display("%t - Setting up for left push.", $time);
		right = 0;	leds_on = 1;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0000100); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state R3, left push, end, now state R1	===========================
		
		//	At state R1, right push, start				===========================
		
		@(posedge clk); #1;
		// setup inputs for next test
		$display("%t - Setting up for right push.", $time);
		right = 1;	leds_on = 1;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0000010); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state R1, right push, end, now state R2	===========================
		
		//	At state R2, right push, start				===========================
		
		@(posedge clk); #1;
		// setup inputs for next test
		$display("%t - Setting up for right push.", $time);
		right = 1;	leds_on = 1;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0000001); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state R2, right push, end, now state R3	===========================
		
		//	At state R3, right push, start				===========================
		
		@(posedge clk); #1;
		// setup inputs for next test
		$display("%t - Setting up for right push.", $time);
		right = 1;	leds_on = 1;	winrnd = 1;		
		
    	@(posedge clk); #1;//set the values back to zero to simulate the button being pressed not held
		right = 0;	leds_on = 0;	winrnd = 0;		
        wait(score_reg == 7'b0000111); $display("%t - SUCCESS. Score was %b", $time, score_reg);
		
		//	At state R3, right push, end, now state WR	===========================
		
		
		@(posedge clk); #1;		// waits for a clock edge, then moves just past it
		rst = 1;				// put the system in reset
		
		// =======================
		@(posedge clk); #1;		
		rst = 0;									// remove the system from reset
		right = 0;	leds_on = 0;	winrnd = 0;		// FIRST test setup
		$display("%t - Setting up for first test. @ next clock edge Score should be 7'b0001000", $time);
		
		
		//=========================== END ===========================
		
		$finish;
	end

// every time the clock falls, print out the value of the score
always @(posedge clk) $display("%t - CLKSAMPLE: Score sampled to be %d", $time, score_reg);

// set up statements to inform you when inputs change 
always @(rst) $display("%t - DATAMONITOR: rst signal changed to %b", $time, rst);

// and finally instantiate the device under test (DUT) 
scorer scorerinst (.clk(clk), .rst(rst), .leds_on(leds_on), .right(right), .winrnd(winrnd), .score(score));

endmodule
