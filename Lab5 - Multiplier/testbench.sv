module testbench();
	timeunit 10ns;
	timeprecision 1ns;

/*	
	
	//Input
	logic CLK, IN, RESET;
	logic [1:0]MODE;
	logic [7:0]PIN;
	
	//Output
	logic OUT;
	logic [7:0]POUT;
	
	//Variables
	logic L = 1'b0;
	logic H = 1'b1;
	
	//Expected Results
// logic E_OUT;
//	logic [7:0]E_POUT;
//	integer errNO = 0;
	
	shift_8 register(.*);
	
	always
	begin : CLOCK_GENERATOR
		#1 CLK = ~CLK;
	end
	
	initial
	begin
		CLK = 0;
	end
	
	initial
	begin : TEST
		//Test halting
		MODE = 2'b00;
		IN = 1'b0;
		RESET = 1'b0;
		
		
//		//Test Parallel Load
//		PIN = {L,H,L,H,L,H,L,H};
//		#1 MODE = 2'b11;
//		#1 MODE = 2'b00;
		
		
		//Test Left Shift
		PIN ={H,H,H,H,H,H,H,H};
		IN = 1'b0;
		#2 MODE = 2'b11;
		#2 MODE = 2'b10;
		
		//Test Right Shift
		#10 MODE = 2'b01;
		
		#2 RESET = 1'b1;

	end
*/

	//Input
	logic RESET, CLK, RUN, CLEARA_LOADB;
	logic [7:0]S;
	
	//Output
	logic X;
	logic [6:0] AHEXU, AHEXL, BHEXU, BHEXL;
	logic [7:0] AVAL, BVAL;
	//logic [7:0]A,B;
	//logic [15:0]AB_data;
	
	multiplier test(.*);
	
	always
	begin : CLOCK_GENERATOR
		#1 CLK = ~CLK;
	end
	
	initial CLK = 0;
	
	initial
	begin : TEST
		/**
		 *	Gotta hit reset to start operation
		 * Takes 2 cycles do a register operation (S->CU->REG)
		 **/
		 
		#2 RESET = 1'b0;
		#2 RESET = 1'b1;
		
		
//		//CLEARA_LOADB
//		#2 S = 8'h07;
//		CLEARA_LOADB = 1'b1;
//		#2 CLEARA_LOADB = 1'b0;
//		
//		#4 RESET = 1'b1;
//		#2 RESET = 1'b0;
//		
//		#2 S = -8'd59;
//		CLEARA_LOADB = 1'b1;
//		#2 CLEARA_LOADB = 1'b0;
//		
//		#2 RESET = 1'b1;
//		#2 RESET = 1'b0;
//		
		
      //Cycle Test
		S = 8'd11;	//Multiplier
		#2 CLEARA_LOADB = 1'b0;
		#2 CLEARA_LOADB = 1'b1;
		#2 S = -8'd3;

		
		#2 RUN = 1'b0;
		#60 RUN = 1'b1;
		#2 RUN = 1'b0;
		#60 RUN = 1'b1;


		
/* 		//Hold Test
		#2 RESET = 1'b1;
		#2 RESET = 1'b0;
		#2 S = -8'd59;	//Multiplier
		#2 CLEARA_LOADB = 1'b1;
		#2 S = 8'd7;	//Multiplicand
		#2 CLEARA_LOADB = 1'b0;
		
		#2 RUN = 1'b1;
		#25 RUN = 1'b0;
		
		
		//RUN AGAIN TEST
		#2 RESET = 1'b1;
		#2 RESET = 1'b0;
		#2 S = -8'd1;	//Multiplier
		#2 CLEARA_LOADB = 1'b1;
		#2 S = 8'd1;	//Multiplicand
		#2 CLEARA_LOADB = 1'b0;
		
		#2 RUN = 1'b1;
		#25 RUN = 1'b0;
		
		#2 RUN = 1'b1;
		#25 RUN = 1'b0;	 */
	end
	
endmodule
