//shift_8 example(.RESET(), .MODE(), .CLK(), .IN(), .PIN(), .OUT(), .POUT())
module shift_8
(
	input  logic RESET,
	input  logic [1:0]MODE, //Mode Select
		/**
		 * 0 = Hold
		 * 1 = Right Shift
		 * 2 = Left Shift
		 * 3 = Parallel Load
		 **/
	input  logic CLK,
	input  logic IN,			//Shift Input
	input  logic [7:0]PIN,	//Parallel Input
	output logic OUT,			//Shift Output
	output logic [7:0]POUT  //Parallel Output
);


//	logic [7:0]R;			//Frankly, shouldn't need this either
//	logic [7:0]R_next;	//Shouldn't need this

	always_ff @ (posedge CLK)
		begin
			unique case(MODE)
			
				//Hold 
				2'b00: 
				begin
					POUT <= POUT;
					OUT <= POUT[0];	//By default, output Right-handed LSB (hacky fix)
				end
				
				//Right Shift
				2'b01:
				begin
					OUT     <= POUT[0];
					POUT[0] <= POUT[1];
					POUT[1] <= POUT[2];
					POUT[2] <= POUT[3];
					POUT[3] <= POUT[4];
					POUT[4] <= POUT[5];
					POUT[5] <= POUT[6];
					POUT[6] <= POUT[7];
					POUT[7] <= IN;
				end
				
				//Left Shift
				2'b10:
				begin
					OUT     <= POUT[7];
					POUT[7] <= POUT[6];
					POUT[6] <= POUT[5];
					POUT[5] <= POUT[4];
					POUT[4] <= POUT[3];
					POUT[3] <= POUT[2];
					POUT[2] <= POUT[1];
					POUT[1] <= POUT[0];
					POUT[0] <= IN;
				end
				
				//Parallel Load
				2'b11:
				begin
					POUT <= PIN;
					OUT <= PIN[0];	//OUT defaults to Right-handed LSB (hacky)
				end			
			endcase
	
			if (RESET)
			begin
					OUT     <= 1'b0;
					POUT[0] <= 1'b0;
					POUT[1] <= 1'b0;
					POUT[2] <= 1'b0;
					POUT[3] <= 1'b0;
					POUT[4] <= 1'b0;
					POUT[5] <= 1'b0;
					POUT[6] <= 1'b0;
					POUT[7] <= 1'b0;  
				
			end
			
		end			 
endmodule
