//register example(.Clk, .Reset, .WE, .data_IN, .data_OUT)
module register
(
	input  logic Clk, Reset, WE,
	input  logic [15:0]data_IN,
	output logic [15:0]data_OUT
);

	logic [15:0]next_data;
	
	always_ff @ (posedge Clk)
	begin
		if (Reset) data_OUT <= 16'h0000;
		else data_OUT <= next_data;
	end
	
	assign next_data = (WE) ? data_IN : data_OUT;
endmodule
