module pc_unit
(
	input  logic Clk, Reset, LD_PC,
	input  logic [1:0]PCMUX,
	input  logic [15:0]BUS_DATA, ADDR_OUT,
	output logic [15:0]PC_OUT
);
	logic [15:0]PC_PLUS, PC_NEXT;
	
	register pc_reg(.Clk, .Reset, .WE(LD_PC), .data_IN(PC_NEXT), .data_OUT(PC_OUT));
	
	
	always_comb
	begin		
		//Determine PC+1
		PC_PLUS = PC_OUT + 16'h0001;
		
		//Determine output of PCMUX
		unique case(PCMUX)
			2'b00:   PC_NEXT = PC_PLUS;
			2'b01:	PC_NEXT = BUS_DATA;
			2'b10:   PC_NEXT = ADDR_OUT;	//Address Adder, not to be confused with ALU
			default: PC_NEXT = 16'bXXXXXXXXXXXXXXXX; 	//Scream if something ain't right
		endcase
	end
endmodule
