//reg_file example(.Clk, .Reset, .DRMUX, .SR1MUX, .LD_REG, .BUS_DATA, .IR, .SR1_OUT, .SR2_OUT)
module reg_file
(
	input  logic 		  Clk,Reset,
	input  logic 		  DRMUX,		//Control signals
						     SR1MUX,
						     LD_REG,

	input  logic [15:0] BUS_DATA,	//Input signals
						     IR,
	
	output logic [15:0] SR1_OUT,
						     SR2_OUT
);

	logic [3:0]  DR,SR1,SR2;
	logic [15:0] REG_IN;
	logic [15:0] REG_ARR [8];

	always_ff @ (posedge Clk)
	begin
		if(Reset)
		begin
			for(integer i=0; i<8;i=i+1)
			begin
				REG_ARR[i] <= 16'h0000;
			end
		end
		
		else
		begin
			REG_ARR[DR] <= REG_IN;
		end
	end
	
	always_comb
	begin
		//Figure out DR
		DR = (DRMUX == 1) ? 3'b111 : IR[11:9];
		
		//Figure out SR1
		SR1 = (SR1MUX == 1) ? IR[8:6] : IR[11:9];
		
		//Figure out SR2(?)
		SR2 = IR[2:0];
		
		//Assign Input
		REG_IN = (LD_REG) ? BUS_DATA : REG_ARR[DR];
		
		
		//Assign Output									//XXX - This might be buggy, not sure if it can read/write at the same time
		SR1_OUT = REG_ARR[SR1];
		SR2_OUT = REG_ARR[SR2];
	end
endmodule