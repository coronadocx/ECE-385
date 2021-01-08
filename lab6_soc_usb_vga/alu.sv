//alu_unit example(.SR1, .SR2, .imm5, .ALUK, .SR2MUX, .ALU_OUT);
module alu_unit
(
    input  logic [15:0] SR1,SR2,
	 input  logic [4:0]  imm5,
	 input  logic [1:0]  ALUK,
	 input  logic        SR2MUX,
	 output logic [15:0] ALU_OUT 
);
    logic [15:0] B, imm16;
 
    always_comb
    begin
    	 //SEXT imm5
	     imm16 = {{11{imm5[4]}}, imm5};
	 
    	 //Select B according to SR2MUX signal
    	 B = (SR2MUX) ? imm16 : SR2;
		 
		 //Determine ALU output
		 unique case (ALUK)
		     //ADD
		     2'b00: ALU_OUT = SR1 + B;
			  
			  //AND 
			  2'b01: ALU_OUT = SR1 & B;
			  //NOT
			  2'b10: ALU_OUT = ~SR1;
			  //PASS A
			  2'b11: ALU_OUT = SR1;
			  
			  //Default to XXXX - let us know when this is operating and when it isn't
			  default: ALU_OUT = 16'bXXXXXXXXXXXXXXXX;
		 endcase
    end
endmodule
