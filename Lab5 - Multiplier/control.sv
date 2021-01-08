/** - NOTES
 * Should start in add state, not shift state
 * Only add when LSB is 1
 * 
 **/







//control_unit CU(.RESET, .CLK, .RUN, .CLEARA_LOADB, .B0(B0), .SUB(sub), .CLEAR(clear), .MODE_A(mode_a), .MODE_B(mode_b));		//TODO - create control unit

module control_unit
(
	input  logic RESET, CLK, RUN, CLEARA_LOADB, B0,
	output logic SUB, CLEAR,
	output logic [1:0]MODE_A,
	output logic [1:0]MODE_B
);
	logic [3:0]counter; //0-7
	logic [3:0]next_counter;
	enum logic [3:0] {Rest,Clear,Shift, Check,Add, Hold, Again, Preclear} current_state, next_state;


	always_ff @ (posedge CLK)
	begin
		//Synchronus Reset
		if (RESET)
			current_state <= Rest;
		else
			current_state <= next_state;
			
		counter <= next_counter;
	end

	
	
	
	always_comb
		begin
			next_state = current_state;
			next_counter = counter;
			
			
			unique case (current_state)
			Rest:
			begin
				//Update
				if (RUN)
				begin
					next_state = Check;
					next_counter = 4'h0;
				end
				
				else if (CLEARA_LOADB) next_state = Clear;
				
				//Output
				SUB    = 1'b0;
				CLEAR  = 1'b0;
				MODE_A = 2'b00;		//Registers in Hold state
				MODE_B = 2'b00;
			end
			
			Clear:
			begin
				//Update
				next_state = Rest;
				
				//Output
				SUB    = 1'b0;
				CLEAR  = 1'b1;
				MODE_A = 2'b11;		//Parallel load the clear
				MODE_B = 2'b11;		//Parallel load the signal
			end
			
			Shift:
			begin
				next_state = Check;
				

				SUB    = 1'b0;
				CLEAR  = 1'b0;
				MODE_A = 1'b01;
				MODE_B = 1'b01;

			end
			
			Check:
			begin
								//Update
				if (counter == 4'h8) next_state = Hold;
				else if (B0) next_state = Add;
				else next_state = Shift;
				next_counter = counter + 4'h1;			//Increment shift counter

				
				//Output
				SUB    = 1'b0;
				CLEAR  = 1'b0;
				MODE_A = 2'b00;		//Registers in Right Shift state
				MODE_B = 2'b00;
			end
			
			
			//Add State
			Add:
			begin
				//Update
				next_state = Shift;
				
				//Output
				if (counter == 4'h8) SUB = 1'b1;
				else SUB = 1'b0;
				
				MODE_A = 2'b11;						//A will have something added no matter what
				MODE_B = 2'b00;
				CLEAR  = 1'b0;
			end
			
			
			//Hold State
			Hold:
			begin
				//Update
				if (~RUN) next_state = Again;
				
				//Output
				SUB    = 1'b0;
				CLEAR  = 1'b00;
				MODE_A = 2'b00;		//Registers in Hold state
				MODE_B = 2'b00;
			end
			
			Again:
			begin
				//Update
				if (RUN)
				begin
					next_state = Preclear;
					next_counter = 4'h0;
				end
				
				else if (CLEARA_LOADB) next_state = Clear;

				
				//Output
				SUB    = 1'b0;
				CLEAR  = 1'b0;
				MODE_A = 2'b00;		//Registers in Hold state
				MODE_B = 2'b00;
			end
			
			Preclear:
			begin
				next_state = Check;
				SUB    = 1'b0;
				CLEAR  = 1'b1;
				MODE_A = 2'b11;
				MODE_B = 2'b00;
			end
			
			endcase
			
		end

endmodule
