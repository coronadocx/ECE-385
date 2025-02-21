// Main.c - makes LEDG0 on DE2-115 board blink if NIOS II is set up correctly
// for ECE 385 - University of Illinois - Electrical and Computer Engineering
// Author: Zuofu Cheng

#include <stdio.h>

int main()
{
	int i = 0;
	unsigned int sum = 0;
	volatile unsigned int *LED_PIO = (unsigned int*)0x00000070; //make a pointer to access the PIO block
	volatile unsigned int *SW      = (unsigned int*)0x00000060;
	volatile unsigned int *KEY     = (unsigned int*)0x00000050;
	*LED_PIO = 0; //clear all LEDs


	while ( 1 == 1 )
	{
		*LED_PIO &= 0;
		sum = 0;
		while ( *KEY != 2)                    //not pressing key2
		{
				*LED_PIO &= 0;
			if ( *KEY == 1) {				  //If key3 is pressed
				while (*KEY == 1);
				sum += *SW;
				if (sum > 255) sum -= 256;	  //overflow

			} else{							  //else blink
//				for (i = 0; i < 100000; i++); //software delay
				*LED_PIO |= sum;              //set LSB
//				for (i = 0; i < 100000; i++); //software delay
//				*LED_PIO &= ~(sum);           //clear LSB
			}
		}
	}

//	while (1 == 1) {
//		if (*KEY != 3) {
//			for (i = 0; i < 100000; i++); //software delay
//			*LED_PIO |= *SW;              //set LSB
//			for (i = 0; i < 100000; i++); //software delay
//			*LED_PIO &= ~(*SW);           //clear LSB
//		}
//	}
//		volatile unsigned int data = *KEY;
//		if (data == 0) {
//			for (i = 0; i < 100000; i++); //software delay
//			*LED_PIO |= 1;              //set LSB
//			for (i = 0; i < 100000; i++); //software delay
//			*LED_PIO &= ~1;           //clear LSB
//		}
//		else if (data == 1) {
//			for (i = 0; i < 100000; i++); //software delay
//			*LED_PIO |= 2;              //set LSB
//			for (i = 0; i < 100000; i++); //software delay
//			*LED_PIO &= ~2;           //clear LSB
//		}
//
//		else if (data == 2) {
//			for (i = 0; i < 100000; i++); //software delay
//			*LED_PIO |= 3;              //set LSB
//			for (i = 0; i < 100000; i++); //software delay
//			*LED_PIO &= ~3;           //clear LSB
//		}
//
//		else if (data == 3) {
//			for (i = 0; i < 100000; i++); //software delay
//			*LED_PIO |= 4;              //set LSB
//			for (i = 0; i < 100000; i++); //software delay
//			*LED_PIO &= ~4;           //clear LSB
//		}
//	}
	return 1; //never gets here
}
