module testbench();
	timeunit 10ns;
	timeprecision 1ns;

//////TopLevel Signals//////
	//Input
   logic [15:0] S;
	logic        Clk, Reset, Run, Continue;
	
	//Output
	logic [11:0] LED;
//	logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
	logic        CE, UB, LB, OE, WE;
	logic [19:0] ADDR;
	
	//Inout
	wire [15:0]  Data;

//////Additional Waveforms//////
	logic [15:0] PC,MAR,MDR,IR;        //slc3
	logic [15:0] Registers [8];

	
	lab6_toplevel toplevel(.*, .HEX0(), .HEX1(), .HEX2(), .HEX3(), .HEX4(), .HEX5(), .HEX6(), .HEX7());
	
	always
	begin : CLOCK_GENERATOR
		#1 Clk = ~Clk;
	end
	
	initial Clk = 0;
	
	always @ *
	begin : INTERNAL_SIGNALS
		//slc3 Signals
		PC    = toplevel.my_slc.PC;
		MAR   = toplevel.my_slc.MAR;
		MDR   = toplevel.my_slc.MDR;
		IR    = toplevel.my_slc.IR;		
		
		Registers = toplevel.my_slc.d0.rf.REG_ARR;
			
		//Datapath Signals
//		PCi  = toplevel.my_slc.d0.PC;
//		MARi = toplevel.my_slc.d0.MAR;
//		MDRi = toplevel.my_slc.d0.MDR;
//		IRi  = toplevel.my_slc.d0.IR;
	end
	
	always @ *
	begin
		if(IR[15:12] == 4'b1101)
		begin
			#2 Continue = 0; //press it after 1 cycle
			#3 Continue = 1; //release it after 1ish cycle
		end
	end
	
	
	initial
	begin : TEST
////////////////////////Switch Initialization///////////////////////
	    S = 16'h0003;
		
		//Active-high control switches
		Reset = 1'b1; Run = 1'b1; Continue = 1'b1;

////////////////////////Testing/////////////////////////////////////
		//Reset to start things off
		#2 Reset = 1'b0;
		#4 Reset = 1'b1;
		
		//See what happens when you just hit run
		#2 Run = 1'b0;
		#2 Run = 1'b1;
		
		
	end
	
endmodule
