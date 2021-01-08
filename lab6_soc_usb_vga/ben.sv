
//ben_unit ben(.Clk, .Reset, .LD_BEN, .LD_CC, .IR, .BUS_DATA, .BEN)
module ben_unit
(
	input  logic        Clk, Reset, LD_BEN, LD_CC,
	input  logic [15:0] IR,BUS_DATA,
	output logic        BEN
);

    logic N,Z,P;
    logic N_next, Z_next, P_next;
	 logic BEN_next;
	 logic [2:0]status;
	 
    always_ff @ (posedge Clk)
	 begin
	     //Synchronus Reset
	     if(Reset)
		  begin
		      BEN <= 1'b0;
				N   <= 1'b0;
				Z   <= 1'b0;
				P   <= 1'b0;
		  end
		  
		  //Normal Operation
		  else
		  begin
		      BEN <= BEN_next;
				N   <= N_next;
				Z   <= Z_next;
				P   <= P_next;
		  end
	 end
	 
	 always_comb
	 begin
	     //Defaults
		  N_next = N;
		  Z_next = Z;
		  P_next = P;
		  
		  BEN_next = BEN;
		  status = 3'bXXX;    //Default to X
		  
		  //Determine NZP - might be buggy
		  if (BUS_DATA[15] == 1'b1)
		      status = 3'b100;
		  else if (BUS_DATA == 16'h0000)
			   status = 3'b010;
		  else if (BUS_DATA[15] == 0)
		      status = 3'b001;
		  
	
		  //Update NZP
		  if (LD_CC)
		  begin
		      N_next = status[2];
				Z_next = status[1];
				P_next = status[0];
		  end
		  
		  
		  //Update BEN
		  if (LD_BEN)
		      BEN_next = ((IR[11] & N) + (IR[10] & Z) + (IR[9] & P));
	 end
	 

endmodule
