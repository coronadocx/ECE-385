 /************************************************************************
Avalon-MM Interface for AES Decryption IP Core

Dong Kai Wang, Fall 2017

For use with ECE 385 Experiment 9
University of Illinois ECE Department

Register Map:

 0-3 : 4x 32bit AES Key
 4-7 : 4x 32bit AES Encrypted Message
 8-11: 4x 32bit AES Decrypted Message
   12: Not Used
	13: Not Used
   14: 32bit Start Register
   15: 32bit Done Register

************************************************************************/

module avalon_aes_interface (
	// Avalon Clock Input
	input logic CLK,
	
	// Avalon Reset Input (active high)
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,					// Avalon-MM Read (active high)
	input  logic AVL_WRITE,					// Avalon-MM Write (active high)
	input  logic AVL_CS,						// Avalon-MM Chip Select (active high, set to high during read or write op)
	input  logic [3:0] AVL_BYTE_EN,		// Avalon-MM Byte Enable (active high, signals which byte(s) are being written)
	input  logic [3:0] AVL_ADDR,			// Avalon-MM Address
	input  logic [31:0] AVL_WRITEDATA,	// Avalon-MM Write Data
	output logic [31:0] AVL_READDATA,	// Avalon-MM Read Data
	
	// Exported Conduit
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
	 

	//Week 1 work:
	register_file rf(.*);
	 
	 
	 
	 
	 

endmodule

