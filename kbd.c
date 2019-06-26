#include "kbd.h"
#include "kernel_main.h"
#include "monitor.h"
/*The keyboard map*/
char keymap[128] = {'?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','q','1','?','?','?','z','s','a','w','2','?','?','c','x','d','e','4','3','?','?',' ','v','f','t','r','5','?','?','n','b','h','g','y','6','?','?','?','m','j','u','7','8','?','?','?','k','i','o','0','9','?','?','?','?','l','?','p','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?'}; 
/*Read The input from keyboard controller and keyboard encoder*/
static uint8_t read_kbd_cmd(int code)
{
	if(code == 1)
		return (uint8_t)inb((u16int)KBD_CONTROLLER_PORT);
	else
		return (uint8_t)inb((u16int)KBD_ENCODER_PORT);
}
/*Send the command byte to the keyboard controller or encoder depending on the
 * code. 1= controller 2=encoder*/
static void send_kbd_cmd(int code , uint8_t cmd)
{
	u8int stat ;
	if(code == 1)
	{
		while(true)
		{
			stat=inb((u16int)KBD_CONTROLLER_PORT);
			if((stat&0x02)==0) // bit 1 =0 . Input port empty . Can be written to
				break ;
		}
		outb((u16int)KBD_CONTROLLER_PORT , (u8int)cmd) ;
	}
	else if(code ==2) //Anything written to encoder is written to the controller first 
	{
		while(true)
		{
			stat = inb((u16int)KBD_CONTROLLER_PORT);
			if((stat&0x02)==0)
				break ;
		}
		outb((u16int)KBD_ENCODER_PORT , (u8int)cmd);
	}
}
/*Use to self test the keyboard controller so that everything is working
 * okay .This just means sending 0xAA to the keyboard controller and look for
 * the output value in the output buffer.If the result in the output buffer is
 * 0x55, then , everything is okay. Otherwise , nothing is Okay*/
static u8int kbd_self_test()
{
	u8int stat ;
	send_kbd_cmd(1 , 0xAA); 
	/*wait for the output buffer to be full*/
	while(true)
	{
		stat=inb((u16int)KBD_CONTROLLER_PORT);
		if((stat&&0x01)==0x01) //output buffer full. Can be read 
			break ;
	}
	stat = inb((u16int)KBD_ENCODER_PORT);
	if(stat==0x55)
		return 1;
	else
		return 0 ;
}
/*To set the LEDs like that of scroll lock etc.*/
static void set_led(int num , int caps , int scroll)
{
	u8int data = 0;
	data = (scroll) ? (data|1) : (data&1) ;
	data = (num)? (num|2) : (num&2) ;
	data = (caps)? (caps|2) :(caps&2);
	send_kbd_cmd(2 ,(uint8_t)0xED);
	send_kbd_cmd(2 ,(uint8_t)data);
	return ;
}
/*This will test the keyboard seroal interface between the keyboard controller
 * and the keyboard encoder. The return result , if zero , proves that there are
 * no errros. OTherwise , it will show us a lot types of errors
 */
static u8int kbd_interface_test()
{
	u8int stat ;
	send_kbd_cmd(1,(u8int)0xAB);
	while(true)
	{
		stat = inb((u16int)KBD_CONTROLLER_PORT);
		if((stat&0x01)==0x01)
			break ;
	}
	stat = inb((u16int)KBD_ENCODER_PORT);
	if(stat == 0)
		return 1;
	else
		return 0 ;
}
static uint8_t check_error(u8int code)
{
	switch(code)
	{
		case 0x00:
			monitor_write("Key detection or internal buffer overrun\n");
			return 0;
		case 0xAA:
			monitor_write("Self test passed\n");
			return 1 ;
		case 0xEE:
			monitor_write("Response echo OK\n");
			return 1 ;
		case 0xFA:
			monitor_write("Response command acknowledge\n");
			return 1;
		case 0xFC:
			monitor_write("self test failed\n");
			return 0 ;
		case 0xFE:
			monitor_write("resend last command.Some error\n");
			return 2 ;
		case 0xFD:
			monitor_write("Self test failed\n");
			return 0;
		case 0xFF:
			monitor_write("key detection or internal buffer overrun\n");
			return 0 ;
		default:
			return 0;
	}
}
void init_kbd_controller();
/*Reads the character from the keyboard encoder data port and returns the ASCII
 * value accordingly*/
uint8_t get_key_pressed()
{
	uint8_t stat = read_kbd_cmd(1);
	if((stat&0x01)==1) /*Read when the keyboard controller until it's one , i.e. when the data comes over */
	{
		stat = read_kbd_cmd(2);
		if(check_error((u8int)stat)==0)
			return stat ;
		else
			return 0;
	}
	else
		return 0;
//	init_kbd_controller();
}
/*to initialize our PS2 Device, which is keyboard in our case*/
static void init_kbd_encoder()
{
	set_led(0 , 0 , 0);
	/*map the scan codes, for the moment , we will just print up the scan
	 * codes*/
}
/*Initializes the entire keyboard subsystem*/
void init_kbd()
{
	init_kbd_controller();
	init_kbd_encoder();
}
/*Initialization is done in the following 5 steps, only one of which is
 * actually necessary :-/ 
 *
 * 1.Disable all the ps2 devices, so that we don't fuck up big time if an
 * interrupt comes while the execution of this function
 * 
 * 2.Flush the controller's output buffer, if it has some data left over because of a lost IRQ.This can be done by poling the status register bit 0, this is the bit
 * which is responsible for showing if the output buffer is empty or not
 * 
 * 3.Set the controller's configuration byte. We want to disable all IRQs and
 * and disable translation from AT to AX. That is to say, we will be getting
 * scan code set number 2 from the data port.
 *
 * 4.Keyboard self test
 * 
 * 5.Enable devices and IRQs
 *
 * 6.Reset devices 
 * */
void init_kbd_controller()
{
	send_kbd_cmd(1 , (uint8_t)0xAD); //Disable PS1
	send_kbd_cmd(1 , (uint8_t)0xA7); //Disable PS2, if present

	u8int stat = inb((uint8_t)0x64);
	while((stat&0x01)!=0x00) //
	{
		stat = inb((uint8_t)0x64);
	}
	
	send_kbd_cmd(1, (u8int)0x20); //get the configuration byte
	while(true)
	{
		stat = read_kbd_cmd(1);
		if((stat&0x01)==0x01) /*buffer full , bail out man*/
			break;
	}
	stat = inb((uint8_t)KBD_ENCODER_PORT);

	u8int num_ports = (stat&0x20)==0?1:2 ;
	//now write the modifued value back*/
	stat= ( stat & (~0x43) ); //Clearing bits 0 , 1 and 6*/
	send_kbd_cmd(1 , (uint8_t)0x60);
        send_kbd_cmd(1 , (uint8_t)stat);

	stat = kbd_self_test();
	if(stat==1)
		monitor_write("Keyboard self test [OK]\n");
	stat = kbd_interface_test();
	if(stat==1)
		monitor_write("Keyboard interface test [OK]\n");
	send_kbd_cmd(1,(uint8_t)0xAE);
	if(num_ports == 2)
		send_kbd_cmd(1, (uint8_t)0xA8);
	if(num_ports == 2)
		stat = stat|0x03 ;
	else
		stat = stat|0x01 ;
	send_kbd_cmd(1 , (uint8_t)0x60);
	send_kbd_cmd(1,  (uint8_t)stat);

	send_kbd_cmd(2 , (uint8_t)0xFF);
	/*Read the input register of the device, just to be on the safe side*/
	while(true)
	{
		stat = inb((u8int)KBD_CONTROLLER_PORT) ; //Read the status register 
		if((stat&0x02)==0) //Input buffer empty , can be read 
			break ;
	}
	stat = inb((u8int)KBD_ENCODER_PORT);
	if(stat == 0xFA)
		monitor_write("PS2 Keyboard Device Microcontroller test [OK]\n");
	else
		monitor_write("PS2 Keyboard Device Microcontroller test [failed]\n");
	return ;
}
