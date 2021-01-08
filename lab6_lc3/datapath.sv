/**
 *	PC, MAR, MDR, IR - DONE
 *	BUS              - DONE
 *	Reg_file         - TESTING
 *	ALU              - TESTING
 * ADDR             - TESTING
 *	CC nzp           - TESTING
 **/
 

module datapath
(	
	//Note: Some of these inputs may not be needed, the sources of these signals are in the blue notebook
	input  logic       Clk,Reset,
	
	//Gate control signals
	input  logic       GatePC,
				          GateMDR,
				          GateALU,
				          GateMARMUX,
	
	//Register Control Signals
	input  logic       LD_PC,
				          LD_MDR,
				          LD_MAR,
				          LD_IR,
				          LD_REG,	//For REG File
				          LD_CC,		//This is to update the result registers NZP
							            //Don't get it confused with the conditional part
							            //of the branch command
							
				          LD_BEN,	//Branch EN register
				         // LD_LED,	//Not sure if this is needed
				 
	//Data from memory 
	input  logic [15:0]MDR_In,
				 
	//MUX Control Signals
	input  logic [1:0] PCMUX,
	input  logic       DRMUX,
				          SR1MUX,
				          SR2MUX,
				          ADDR1MUX,
	input  logic [1:0] ADDR2MUX,
	input  logic [1:0] ALUK,	
	input  logic       MIO_EN,
	
	output logic [15:0]MAR,
							 MDR,
							 IR,
							 PC,
	output logic		 BEN		//Not set up rn
   //output logic [11:0]LED		//Not set up rn
);

	logic [15:0]BUS_DATA,
				   ALU_OUT,
				   SR1,
				   SR2,
				   ADDR_OUT;				

	//Bus
	bus main_bus(
				.GatePC, .GateMDR, .GateALU, .GateMARMUX,
				.PC, .MDR, .ALU(ALU_OUT), .MAR(ADDR_OUT),
				.BUS_DATA
				);

	//PC Unit
	pc_unit pc_u(.Clk, .Reset, .LD_PC, .PCMUX, .BUS_DATA, .ADDR_OUT, .PC_OUT(PC));
	
	//MDR
	mdr_unit mdr_u(.Clk, .Reset, .LD_MDR, .MIO_EN, .BUS_DATA, .MDR_In, .MDR);
	
	//MAR
	register mar_u(.Clk, .Reset, .WE(LD_MAR), .data_IN(BUS_DATA), .data_OUT(MAR));
	

	//IR
	register ir_u(.Clk, .Reset, .WE(LD_IR), .data_IN(BUS_DATA), .data_OUT(IR));
	
//////////////////////////////Week 2 Stuff////////////////////////////////////////////////////
	
	//Register File
	reg_file rf(.Clk, .Reset, .DRMUX, .SR1MUX, .LD_REG, .BUS_DATA, .IR, .SR1_OUT(SR1), .SR2_OUT(SR2));

	
	//ALU
   alu_unit alu(.SR1, .SR2, .imm5(IR[4:0]), .ALUK, .SR2MUX, .ALU_OUT);
	
	//ADDR ALU
	addr_alu addr(.IR, .SR1, .PC, .ADDR1MUX, .ADDR2MUX, .ADDR_OUT);

	
	//BEN and CC/NZP
	ben_unit ben(.Clk, .Reset, .LD_BEN, .LD_CC, .IR, .BUS_DATA, .BEN);
	
	//LED stuff
//	always_comb
//	begin
//		if (LD_LED):
//		
//	end

 
	
/////////////////////////////TEMPORARY/////////////////////////////////////////////////////////
	//assign LED = 12'b000000000000;
	

					
endmodule
