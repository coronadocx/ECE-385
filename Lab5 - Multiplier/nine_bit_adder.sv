//nine_bit_adder example(.A(), .B(), .SUB(), .SUM())
module nine_bit_adder  //9 bit adder using 16 bit adders
(
	input logic  [7:0]A,
	input logic  [7:0]B,
	input logic  SUB,
	output logic [8:0]SUM
);

	logic [7:0]B_SELECT;
	logic [15:0]A_16;
	logic [15:0]B_16;
	logic [15:0]S_16;
	
	carry_select_adder csa(.A(A_16), .B(B_16), .CI(SUB), .SUM(S_16), .CO());
	
	always_comb
	begin
		//Selectively invert A based on SUB
		B_SELECT = B ^ {8{SUB}};
		
		//Sign extend A and B to 16 bits
		A_16 = {{8{A[7]}},A};
		B_16 = {{8{B_SELECT[7]}},B_SELECT};

		
		//Truncate the result of the addition back down to 9 bits
		SUM = S_16[8:0];		
	end
endmodule


module carry_select_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
	input 	logic			CI,
    output  logic[15:0]     SUM,
    output  logic           CO
);
	logic c0,c1,c2;

	byte_adder   fa0(.A(A[3:0]), .B(B[3:0]), .CIN(CI), .S(SUM[3:0]), .COUT(c0));
	carry_select cs0(.A(A[7:4]), .B(B[7:4]), .CIN(c0), .S(SUM[7:4]), .COUT(c1));
	carry_select cs1(.A(A[11:8]), .B(B[11:8]), .CIN(c1), .S(SUM[11:8]), .COUT(c2));
	carry_select cs2(.A(A[15:12]), .B(B[15:12]), .CIN(c2), .S(SUM[15:12]), .COUT(CO));

endmodule


module carry_select
(
	input  logic[3:0] A,
	input  logic[3:0] B,
	input  logic    CIN,
	output logic[3:0] S,
	output logic   COUT
);

	logic [3:0]s0;
	logic [3:0]s1;
	logic c0,c1;
	logic lo,hi;
	assign lo = 1'b0;
	assign hi = 1'b1;

	byte_adder fa0(.A(A), .B(B), .CIN(lo), .S(s0), .COUT(c0));
	byte_adder fa1(.A(A), .B(B), .CIN(hi), .S(s1), .COUT(c1));
	
	always_comb
		begin			
			COUT = (CIN & c1) | c0;
			
			case(CIN)
				0:
					S = s0;
				
				1:
					S = s1;
			endcase
		end

endmodule



module byte_adder
(
	input  logic [3:0]  A,
	input  logic [3:0]  B,
	input  logic        CIN,
	output logic [3:0]  S,
	output logic        COUT
	
);

	logic c0,c1,c2;
	
	full_adder a0(.A(A[0]), .B(B[0]), .CIN(CIN), .S(S[0]), .COUT(c0));
	full_adder a1(.A(A[1]), .B(B[1]), .CIN(c0), .S(S[1]), .COUT(c1));
	full_adder a2(.A(A[2]), .B(B[2]), .CIN(c1), .S(S[2]), .COUT(c2));
	full_adder a3(.A(A[3]), .B(B[3]), .CIN(c2), .S(S[3]), .COUT(COUT));
   
endmodule



module full_adder
(
	input logic	 A,
	input logic  B,
	input logic  CIN,
	output logic S,
	output logic COUT
);

	assign S    = A ^ B ^ CIN;
	assign COUT =  (A&B) | (A&CIN) | (B&CIN);


endmodule


