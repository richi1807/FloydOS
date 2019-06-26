#include "kernel_main.h"
#include "monitor.h"
#include "common.h"
/*
 *Move the cursor on the screen.This is done by writing two bytes to the VGA controller. 
*/
u16int * vidmem =(u16int *)( 0xB8000);
u8int cursor_x = 0 ;
u8int cursor_y = 0 ;
static void move_cursor()
{
	u16int cursor_location = cursor_y*80 + cursor_x ; /*The linear offset of the cursor*/
	outb(0x3D4 , 14); /*Command that we will be sending the high bit*/
	outb(0x3D5 , (u8int)cursor_location>>8); /*Send the high bit to the data port*/
	outb(0x3D4 , 15); /*Command that we will be sending the low bit*/
	outb(0x3D5 , (u8int)cursor_location); /*Send the low bit to the data port*/
	return ;	
}
static void scroll_screen()
{
	//u8int attribute_byte = (0<<4)|(0x0F&15) ; /*White text over black background*/
	//u16int character_byte = 0x20 | attribute_byte << 8; /*Space*/
	
	if(cursor_y >=25)
	{
		monitor_clear();
		/*u16int i ;
		for(i=0*80 ; i<24*80 ; i++)
		{
			vidmem[i] = vidmem[i+80] ;
		}
		for(i=24*80 ; i<25*80 ; i++)
		{
			vidmem[i] = character_byte ;
		}
		cursor_y=25 ;
		*/
	}
	return ;
}
void monitor_put(char c)
{
	u8int foreground_color = 15 ;
	u8int background_color = 0 ; 
	u16int * location ;
	u16int character_write = ( c | ( ((background_color<<4) | (foreground_color&0x0F) )<<8) );
	if(c == 0x09)
	{
		if(cursor_x!=0)
			cursor_x-- ;
	}
	else if(c == '\t')
	{
		cursor_x+=8 ;
	}
	else if(c == '\r')
	{
		cursor_x=0;
	}
	else if( c == '\n')
	{
		cursor_x = 0 ;
		cursor_y++;
	}
	else if(c >= ' ')
	{
		location = vidmem + (cursor_y*80 + cursor_x);
		*location = character_write ;
		cursor_x++;
	}
	if(cursor_x>=80)
	{
		cursor_x=0;
		cursor_y++;
	}
	scroll_screen();
	move_cursor();
}
/*clear the entire screen*/
void monitor_clear()
{
	u8int attribute_byte = (0<<4)|(0x0F&15) ; /*White text over black background*/
	u16int character_byte =( 0x20 | (attribute_byte << 8) ); /*Space*/
	int i ;
	for(i=0*80 ; i< 25*80 ; i++)
		vidmem[i] = character_byte ;
	cursor_x=0;
	cursor_y=0;
	move_cursor();	
	return ;
}
/*write an entire string to the monitor*/
void monitor_write(char * s)
{
	int i ;
	for(i=0; s[i] ; i++)
	{
		monitor_put(s[i]);
	}
	return ;	
}

void monitor_dec(uint32_t i, uint8_t iter)
{
	if(i==0)
	{
		if(iter==0)
			monitor_put(0);
		return ;
	}
	monitor_dec(i/10, iter++);
	monitor_put('0'+i%10);
	return ;
}
/*
void monitor_dec64(uint64_t i , uint16_t iter)
{
	if(i==0)
	{
		if(iter==0)
			monitor_put('0');
		return ;
	}
	monitor_dec64(i/10 , iter++);
	monitor_put(i%10 + '0');
	return ;
}*/
