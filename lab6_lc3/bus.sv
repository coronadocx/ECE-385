module bus
(
	input  logic GatePC,
				 GateMDR,
				 GateALU,
				 GateMARMUX,
				 
	input  logic [15:0]PC,MDR,ALU,MAR,
	output logic [15:0]BUS_DATA
);

	logic [3:0] select;
	always_comb
	begin
		select = {GateMARMUX, GateALU, GateMDR, GatePC};

		unique case(select)
			//PC Driver
			4'b0001: BUS_DATA = PC;
			
			//MDR Driver
			4'b0010: BUS_DATA = MDR;
			
			//ALU Driver
			4'b0100: BUS_DATA = ALU;
			
			//MAR Driver
			4'b1000: BUS_DATA = MAR;
			
			//Default to INVALID
			default: BUS_DATA = 16'bXXXXXXXXXXXXXXXX;
		endcase
		
	end
endmodule