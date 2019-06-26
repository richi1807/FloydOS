#include "pic.h"
#include "kernel_main.h"
#include "common.h"
/* this function is used to send the command register to the particular PIC.This
 * register, while reading from it, becomes the status register*/
static void pic_send_command(int8_t pic , int8_t cmd)
{
	if(pic==1)
	{
		outb((u16int)PIC1_COMMAND, (u8int)cmd);
	}
	else
	{
		outb((u16int)PIC1_COMMAND , (u8int)cmd);
	}
	return ;
}

/*Functions for reading and writing the data register.*/
/*
static u8int pic_read_data(uint8_t pic)
{
	u8int ret ;
	if(pic == 1)
	{ 
		ret = inb((u16int)PIC1_DATA);	
	}
	else
	{
		ret = inb((u16int)PIC2_DATA);
	}
	return ret;
}
*/
static void pic_send_data(int8_t pic , int8_t data)
{
	if( pic==1 )
	{
		outb((u16int)PIC1_DATA , (u8int)data);
	}
	else
	{
		outb((u16int)PIC2_DATA , (u8int)data);
	}
	return ;
}
/*The PIC initializer function.We initialize the PIC in four simple
 * words.Sending those words to the designated ports of PIC will initialize the
 * pic for us*/
void init_pic()
{
	/*We simply need to perform the ORing of all the macros defined in the
	 * pic.h*i*/
	//ICW1
	uint8_t icw = 0;
	icw |= ICW1_PIC_NO | ICW1_PIC_INIT| ICW1_ICW4 ;
	pic_send_command((uint8_t)1 , icw);
pic_send_command((uint8_t)2 , icw);

	//ICW2
	icw = 0;
	icw |= 0x20 ;
	pic_send_data((uint8_t)1 , icw);
	icw^=icw ;
	icw|=0x28;
	pic_send_data((uint8_t)2 , icw);
	
	//ICW3
	icw = 0;
	icw |= ICW3_PIC1_B2 ;
	pic_send_data((uint8_t)1 ,icw );
	icw^=0;
	icw |= ICW3_PIC2_IRQ2 ;
	pic_send_data((uint8_t)2 , icw);

	//ICW4. The last one. We only need to worry about 1 bit just like I said
	icw ^= icw ;
	icw |= ICW4_PIC_x86 ;
	pic_send_data((uint8_t)1 , icw);
	pic_send_data((uint8_t)2 , icw);

	/*Clear out all the data registers when you are done*/
	pic_send_data((uint8_t)1 , 0);
	pic_send_data((uint8_t)2 , 0);

	return ;
}

