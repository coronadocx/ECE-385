module register_file
(
	input  logic CLK, 
	input  logic RESET,
	input  logic AVL_READ,					// Avalon-MM Read (active high)
	input  logic AVL_WRITE,					// Avalon-MM Write (active high)
	input  logic AVL_CS,						// Avalon-MM Chip Select (active high, set to high during read or write op)
	input  logic [3:0] AVL_BYTE_EN,		// Avalon-MM Byte Enable (active high, signals which byte(s) are being written)
	input  logic [3:0] AVL_ADDR,			// Avalon-MM Address
	input  logic [31:0] AVL_WRITEDATA,	// Avalon-MM Write Data
	output logic [31:0] AVL_READDATA,	// Avalon-MM Read Data
	output logic [31:0] EXPORT_DATA		// Exported Conduit Signal to LEDs

);
	/**
	Datawidth = 32 bits, Addrwidth = 4 bits
	
	Create 16 registers, each 32-bit
	
	Read is comb speed, write is latch speed
	
	Byteenable[3:0] determines which bytes are being written:
	 * 	1111 - write full 4 bytes
	 *		1100 - Write upper 2 bytes 
	 *		0011 - Write lower 2 bytes
	 * 	1000 - Write to byte 3 only
	 *  	0100 - Write to byte 2 only
	 * 	0010 - Write to byte 1 only
	 * 	0001 - Write to byte 0 only
	
	NIOS sends the AES Key and Message as 4 writes, so need 4 registers to store each variable (AES Key, Encrypted Message, Decrypted Message). Also need 2 registers for START and DONE (14 reg used)
	
	For week 1, implement register array and ensure you can write AES Key and Encrypted Message
	
	Export_data Should be assigned to the first 2 and last 2 bytes of Encrypted Message	
	**/
	
	//Array of 16 32-bit registers
	logic [31:0] reg_arr [16];

	always_ff @ (posedge CLK)
	begin
	
		//Reset sweep
		if(RESET)
		begin
			for(integer i=0; i<16;i=i+1)
			begin
				reg_arr[i] <= {32{1'b0}};
			end
		end
		
		
		//Software Write
		else if (AVL_WRITE && AVL_CS)
		begin
			//Byte enable decoding
			if (AVL_BYTE_EN[3])
				reg_arr[AVL_ADDR][31:24] <= AVL_WRITEDATA[31:24];
			if (AVL_BYTE_EN[2])
				reg_arr[AVL_ADDR][23:16] <= AVL_WRITEDATA[23:16];
			if (AVL_BYTE_EN[1])
				reg_arr[AVL_ADDR][15:8]  <= AVL_WRITEDATA[15:8];
			if (AVL_BYTE_EN[0])
				reg_arr[AVL_ADDR][7:0]   <= AVL_WRITEDATA[7:0];
		end
		
		
//		//Hardware Write -- WEEK 2
//		else
//		begin
//		end
		
	end
	
	always_comb
	begin

		//Assign read data			
		AVL_READDATA = (AVL_READ && AVL_CS) ? reg_arr[AVL_ADDR] : {32{1'b0}};

		//Assign export data
		EXPORT_DATA[15:0]  = reg_arr[4][15:0];	//First two bytes
		EXPORT_DATA[31:16] = reg_arr[7][31:16];	//Last two bytes
	end
	
	
endmodule























