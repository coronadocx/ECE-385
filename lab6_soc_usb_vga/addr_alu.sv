//addr_alu example(.IR, .SR1, .PC, .ADDR1MUX, .ADDR2MUX, .ADDR_OUT);
module addr_alu
(
	input  logic [15:0] IR, SR1, PC,
	input  logic        ADDR1MUX,
	input  logic [1:0]  ADDR2MUX,
	output logic [15:0] ADDR_OUT
);

    logic [15:0] ir6, ir9, ir11;
	 logic [15:0] ADDR1, ADDR2;
	 
	 always_comb
	 begin
	     //Sign Extensions
		  ir6  = {{10{IR[5]}}, IR[5:0]};
		  ir9  = {{7{IR[8]}}, IR[8:0]};
		  ir11 = {{5{IR[10]}}, IR[10:0]};
		  
	     //ADDR1MUX
		  ADDR1 = (ADDR1MUX) ? SR1 : PC;
		  
		  //ADDR2MUX
		  case (ADDR2MUX)
		      //ZERO
		      2'b00: ADDR2 = 16'h0000;
				
				//offset6
				2'b01: ADDR2 = ir6;
				
				//PCoffset9
				2'b10: ADDR2 = ir9;
				
				//PCoffset11
				2'b11: ADDR2 = ir11;
				
				//Default to Garbage
				default: ADDR2 = 16'bXXXXXXXXXXXXXXXX;
		  endcase 
		  
		  //Add the mux results and pass as the output
		  ADDR_OUT = ADDR1 + ADDR2;
	 end

endmodule
