/************************************************************************
Lab 9 Nios Software

Dong Kai Wang, Fall 2017
Christine Chen, Fall 2013

For use with ECE 385 Experiment 9
University of Illinois ECE Department
************************************************************************/

#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include "aes.h"

//#define word unsigned long  //4 byte word

// Pointer to base address of AES module, make sure it matches Qsys
volatile unsigned int * AES_PTR = (unsigned int *) 0x00000100;

// Execution mode: 0 for testing, 1 for benchmarking
int run_mode = 0;

/** charToHex
 *  Convert a single character to the 4-bit value it represents.
 *  
 *  Input: a character c (e.g. 'A')
 *  Output: converted 4-bit value (e.g. 0xA)
 */
char charToHex(char c)
{
	char hex = c;

	if (hex >= '0' && hex <= '9')
		hex -= '0';
	else if (hex >= 'A' && hex <= 'F')
	{
		hex -= 'A';
		hex += 10;
	}
	else if (hex >= 'a' && hex <= 'f')
	{
		hex -= 'a';
		hex += 10;
	}
	return hex;
}

/** charsToHex
 *  Convert two characters to byte value it represents.
 *  Inputs must be 0-9, A-F, or a-f.
 *  
 *  Input: two characters c1 and c2 (e.g. 'A' and '7')
 *  Output: converted byte value (e.g. 0xA7)
 */
char charsToHex(char c1, char c2)
{
	char hex1 = charToHex(c1);
	char hex2 = charToHex(c2);
	return (hex1 << 4) + hex2;
}

/** encrypt
 *  Perform AES encryption in software.
 *
 *  Input: msg_ascii - Pointer to 32x 8-bit char array that contains the input message in ASCII format
 *         key_ascii - Pointer to 32x 8-bit char array that contains the input key in ASCII format
 *  Output:  msg_enc - Pointer to 4x 32-bit int array that contains the encrypted message
 *               key - Pointer to 4x 32-bit int array that contains the input key
 */

void KeyExpansion(unsigned char * key, unsigned long * w, int rounds)
{
	unsigned long tmp;
	//Set first word as the original key
	for (int i=0; i<4; i++) {
		w[i] = key[4*i] << 24 | key[4*i+1] << 16 | key[4*i+2] << 8 | key[4*i+3];
	}

	for (int i=4; i<44; i++) {
		tmp = w[i-1];
		if (i % 4 == 0)
			tmp = SubWord(RotWord(tmp)) ^ Rcon[i/4];
		w[i] = w[i-4] ^ tmp;
	}
}

unsigned long RotWord(unsigned long tmp)
{
	return tmp >> 24 | tmp << 8;
}

unsigned long SubWord(unsigned long tmp)
{
	unsigned long byte[4];

	byte[0] = tmp & 0xFF;
	byte[1] = tmp >> 8 & 0xFF;
	byte[2] = tmp >> 16 & 0xFF;
	byte[3] = tmp >> 24 & 0xFF;

	unsigned long ret = aes_sbox[byte[3]] << 24 | aes_sbox[byte[2]] << 16 | aes_sbox[byte[1]] << 8 | aes_sbox[byte[0]];
	return ret;

}

void AddRoundKey(unsigned char state[4][4], unsigned long * key_schedule, unsigned int round) {
	//State is 16-byte array
	//Key_schedule is 16-byte array

	//Find key for current round
	unsigned long key[4];
	unsigned char byte_key[4][4];
	for (int i=0; i<4; i++)
		key[i] = key_schedule[4*round+i];

	//Find bytes for key
	for (int i=0; i<4; i++) {
		for (int j=0; j<4; j++) {
			byte_key[i][j] = (unsigned char)(key[i] >> (8*j) & 0xFF);
		}
	}

	//Xor the bytes
	for (int i=0; i<4; i++) {
		for (int j=0; j<4; j++) {
			state[i][j] ^= byte_key[i][j];
		}
	}



}
//void SubBytes();    done
//void ShiftRows();
//void MixCols();     done


void encrypt(unsigned char * msg_ascii, unsigned char * key_ascii, unsigned int * msg_enc, unsigned int * key)
{
	int rounds = 10;
	unsigned char msg_hex[16];
	unsigned char key_hex[16];
	unsigned long key_schedule[44];
	unsigned char state[4][4]];  //Tis be column-major, whoops


	//Go through the 32 elements of the ascii arrays and create hex arrays
	int idx = 0;
	for (int i=0; i<32; i += 2){
		msg_hex[idx] = charsToHex(msg_hex[i], msg_hex[i+1]);
		key_hex[idx] = charsToHex(key_hex[i], key_hex[i+1]);
	}

	//First key in schedule is original key
	key_schedule[0] = key_hex;

	//Generate rest of key schedule
	unsigned char prevKey[16];
	for (int i=0; i<16; i++) prevKey[i] = key_hex[i];	//set previous key to origional key
	for (int i=1; i<(rounds+1); i++) {
		uint t = 0;



	}



	//Message
	//Generate Key Schedule
	//AddRoundKey
	//-----------------|
	//SubBytes
	//Shift Rows
	//MixColumns
	//AddRoundKey
	//Repeat x9--------|
	//SubBytes
	//AddRoundKey
	//Encrypted Message
}

/** decrypt
 *  Perform AES decryption in hardware.
 *
 *  Input:  msg_enc - Pointer to 4x 32-bit int array that contains the encrypted message
 *              key - Pointer to 4x 32-bit int array that contains the input key
 *  Output: msg_dec - Pointer to 4x 32-bit int array that contains the decrypted message
 */
void decrypt(unsigned int * msg_enc, unsigned int * msg_dec, unsigned int * key)
{
	//Encrypted Message
	//AddRoundKey(KEY)
	//-------------------|
	//InvShiftRows
	//InvSubBytes
	//AddRoundKey
	//InvMixCoulmns
	//repeat x9 ---------|
	//InvShiftRows
	//InvSubBytes
	//AddRoundKey
	//Message
}

/** main
 *  Allows the user to enter the message, key, and select execution mode
 *
 */
int main()
{
	// Input Message and Key as 32x 8-bit ASCII Characters ([33] is for NULL terminator)
	unsigned char msg_ascii[33];
	unsigned char key_ascii[33];
	// Key, Encrypted Message, and Decrypted Message in 4x 32-bit Format to facilitate Read/Write to Hardware
	unsigned int key[4];
	unsigned int msg_enc[4];
	unsigned int msg_dec[4];

	printf("Select execution mode: 0 for testing, 1 for benchmarking: ");
	scanf("%d", &run_mode);

	if (run_mode == 0) {
//		AES_PTR[4] = 0xDEADBEEF;
//
//		if (AES_PTR[4] != 0xDEADBEEF)
//			printf("Error!");
//		else
//			printf("Success!");
		// Continuously Perform Encryption and Decryption
		while (1) {
			int i = 0;
			printf("\nEnter Message:\n");
			scanf("%s", msg_ascii);
			printf("\n");
			printf("\nEnter Key:\n");
			scanf("%s", key_ascii);
			printf("\n");
			encrypt(msg_ascii, key_ascii, msg_enc, key);
			printf("\nEncrpted message is: \n");
			for(i = 0; i < 4; i++){
				printf("%08x", msg_enc[i]);
			}
			printf("\n");
			decrypt(msg_enc, msg_dec, key);
			printf("\nDecrypted message is: \n");
			for(i = 0; i < 4; i++){
				printf("%08x", msg_dec[i]);
			}
			printf("\n");
		}
	}
	else {
		// Run the Benchmark
		int i = 0;
		int size_KB = 2;
		// Choose a random Plaintext and Key
		for (i = 0; i < 32; i++) {
			msg_ascii[i] = 'a';
			key_ascii[i] = 'b';
		}
		// Run Encryption
		clock_t begin = clock();
		for (i = 0; i < size_KB * 64; i++)
			encrypt(msg_ascii, key_ascii, msg_enc, key);
		clock_t end = clock();
		double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
		double speed = size_KB / time_spent;
		printf("Software Encryption Speed: %f KB/s \n", speed);
		// Run Decryption
		begin = clock();
		for (i = 0; i < size_KB * 64; i++)
			decrypt(msg_enc, msg_dec, key);
		end = clock();
		time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
		speed = size_KB / time_spent;
		printf("Hardware Encryption Speed: %f KB/s \n", speed);
	}
	return 0;
}
