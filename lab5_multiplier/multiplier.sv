module multiplier
(
	input logic  RESET,
	input logic  CLK,
	input logic  RUN,
	input logic  CLEARA_LOADB,
	input logic  [7:0]S,
	
	output logic [6:0]AHEXU,
	output logic [6:0]AHEXL,
	output logic [6:0]BHEXU,
	output logic [6:0]BHEXL,
	output logic [7:0]AVAL,
	output logic [7:0]BVAL,
	output logic X
);
	//Wires
	logic sub,clear, a_b, X_next;
	logic [1:0]mode_a, mode_b;
	logic [8:0]nine_out;
	logic [7:0]a_out, b_out;//,AVAL, BVAL;
	logic [8:0]clearMUX_a;
	
	//Synced Wires
	logic RESET_S, RUN_S, CLEARA_LOADB_S;
	logic [7:0] S_S;
	
	//Control Unit
	control_unit CU(.RESET(RESET_S), .CLK, .RUN(RUN_S), .CLEARA_LOADB(CLEARA_LOADB_S), .B0(b_out[0]), .SUB(sub), .CLEAR(clear), .MODE_A(mode_a), .MODE_B(mode_b));		//TODO - create control unit
	
	//Adder
	nine_bit_adder adder(.A(a_out), .B(S_S), .SUB(sub), .SUM(nine_out));
		
	//Register A
	shift_8 reg_A(.RESET(RESET_S), .MODE(mode_a), .CLK, .IN(X), .PIN(clearMUX_a[7:0]), .OUT(a_b), .POUT(a_out));
	
	//Register B
	shift_8 reg_B(.RESET(RESET_S), .MODE(mode_b), .CLK, .IN(a_b), .PIN(S_S), .OUT(), .POUT(b_out));
	
	always_ff @ (posedge CLK)
	begin
		X <= X_next;
	end
	
	always_comb
	begin
		//Clear logic 			//TODO - decide if clear should also clear X
		unique case(clear)
			//Do not clear
			1'b0:
			begin 	
				clearMUX_a = nine_out;
				if (mode_a == 2'b11) X_next = nine_out[8];
				else X_next = X;
			end
			//Clear 
			1'b1:
			begin
				clearMUX_a = 9'b000000000;
				X_next = 1'b0;
			end
		endcase
		
		AVAL = a_out; 
		BVAL = b_out;
	end
	
	//Hex Driver Update
	HexDriver AhexL (.In0(AVAL[3:0]), .Out0(AHEXL));
	HexDriver AhexU (.In0(AVAL[7:4]), .Out0(AHEXU));
	
	HexDriver BhexL (.In0(BVAL[3:0]), .Out0(BHEXL));
	HexDriver BhexU (.In0(BVAL[7:4]), .Out0(BHEXU));
	
	//Synchronizers
	sync button_sync[2:0] (CLK, {~RESET, ~RUN, ~CLEARA_LOADB}, {RESET_S, RUN_S, CLEARA_LOADB_S});
	sync s_sync[7:0] (CLK, S, S_S);
		
	
	
	
	
endmodule