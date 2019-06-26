#include "descriptors.h"
#include "pic.h"
/*Defining our own interrupts this way is the best.And it is the first ever use
 * of token pasting operator I have ever found. Not only that , it lets me play
 * for C to asm back to C. *Me Gusta* 
 */
#include "registers.h"
#define intr_define(i) extern void intr##i() 
#define intr_use(i) intr##i
#define irq_define(i) extern void irq##i()
#define intr_usei(i) irq##i
extern void monitor_write(char *) ;
extern void monitor_put(char  ) ;
extern void monitor_dec(uint32_t , uint8_t ) ;
void common_handler(register_t r)
{
	if(r.int_no == 0)
		monitor_write("The interrupt triggered is number zero\n");
	//monitor_dec(r.int_no);
	monitor_put((char)r.int_no);
	while(1)
	;
	return ;
}
/*This will initialize our descriptor tables*/
gdt_entry_t gdt_entries[5] ;
gdt_ptr_t gdt_ptr ;
idt_entry_t idt_entries[48];
idt_ptr_t idt_ptr ;
extern void gdt_flush(uint32_t) ;
//extern void idt_flush(uint32_t) ;
static void init_gdt();
static void init_idt();
static void gdt_set_gate(uint32_t , uint32_t , uint32_t , uint8_t , uint8_t );
/*This will set the interrupts gate*/
static void idt_set_gate(uint32_t num , uint16_t offset_low , uint16_t sel ,uint16_t offset_high , uint8_t flags)
{
	idt_entries[num].offset_low = offset_low ;
	idt_entries[num].offset_high = offset_high ;
	idt_entries[num].zero = 0x0 ;
	/*Some black scientific magic here*/
	idt_entries[num].flags = flags ;
	idt_entries[num].selector = sel ;
	return ;
}
static void init_gdt()
{
	gdt_ptr.base = (uint32_t)&gdt_entries ;
	gdt_ptr.limit = sizeof(gdt_entry_t)*5 -1 ;

	/*set the gdt gates*/
	gdt_set_gate(0 , 0 ,0 ,  0 , 0); //NULL segment
	gdt_set_gate(1 , 0x0 ,0xFFFFF , 0x9A , 0xCF);//Code segment
	gdt_set_gate(2 , 0x0 ,0XFFFFF , 0x92 , 0xCF );//Date segment
	gdt_set_gate(3 , 0x0 ,0xFFFFF , 0xFA , 0xCF); //User mode code segment
	gdt_set_gate(4 , 0x0 ,0xFFFFF , 0xF2 , 0xCF);//User mode data segment 
	gdt_flush((uint32_t)&gdt_ptr);
	return ;
}
/*Very complex for mortals. Do not touch this peice of art*/
static void gdt_set_gate(uint32_t num , uint32_t base , uint32_t limit , uint8_t access  , uint8_t granularity)
{
	gdt_entries[num].base_low = base&0xFFFF ;
	gdt_entries[num].base_middle = (base>>16)&0xFF ;
	gdt_entries[num].base_high = (base>>24)&0xFF ;

	gdt_entries[num].limit_low = limit&0xFFFF ;
	gdt_entries[num].granularity = (limit>>16)&0x0F ;

	gdt_entries[num].granularity |= (granularity)&0xF0;
	gdt_entries[num].access = access;
	return ;
}
/*The generalized function for all kinds of errors and for all the 256
 * interrupts
static void idt_general_func()
{
	monitor_write("Unhandled exception triggered");
	while(1)
	;
}
*/
static void init_idt()
{
	/*set up the idts from 0 to 256*/
	intr_define(0) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(0 ,(uint16_t)((uint32_t)intr_use(0)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(0))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(1) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(1 ,(uint16_t)((uint32_t)intr_use(1)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(1))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(2) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(2 ,(uint16_t)((uint32_t)intr_use(2)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(2))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(3) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(3 ,(uint16_t)((uint32_t)intr_use(3)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(3))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(4) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(4 ,(uint16_t)((uint32_t)intr_use(4)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(4))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(5) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(5 ,(uint16_t)((uint32_t)intr_use(5)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(5))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(6) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(6 ,(uint16_t)((uint32_t)intr_use(6)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(6))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(7) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(7 ,(uint16_t)((uint32_t)intr_use(7)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(7))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(8) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(8 ,(uint16_t)((uint32_t)intr_use(8)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(8))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(9) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(9 ,(uint16_t)((uint32_t)intr_use(9)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(9))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(10) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(10 ,(uint16_t)((uint32_t)intr_use(10)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(10))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(11) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(11,(uint16_t)((uint32_t)intr_use(11)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(11))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(12) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(12,(uint16_t)((uint32_t)intr_use(12)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(12))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(13) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(13,(uint16_t)((uint32_t)intr_use(13)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(13))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(14) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(14 ,(uint16_t)((uint32_t)intr_use(14)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(14))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(15) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(15 ,(uint16_t)((uint32_t)intr_use(15)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(15))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(16) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(16 ,(uint16_t)((uint32_t)intr_use(16)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(16))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(17) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(17 ,(uint16_t)((uint32_t)intr_use(17)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(17))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(18) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(18 ,(uint16_t)((uint32_t)intr_use(18)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(18))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(19) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(19 ,(uint16_t)((uint32_t)intr_use(19)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(19))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(20) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(20 ,(uint16_t)((uint32_t)intr_use(20)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(20))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(21) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(21 ,(uint16_t)((uint32_t)intr_use(21)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(21))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(22) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(22 ,(uint16_t)((uint32_t)intr_use(22)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(22))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(23) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(23 ,(uint16_t)((uint32_t)intr_use(23)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(23))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(24) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(24 ,(uint16_t)((uint32_t)intr_use(24)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(24))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(25) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(25 ,(uint16_t)((uint32_t)intr_use(25)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(25))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(26) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(26 ,(uint16_t)((uint32_t)intr_use(26)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(26))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(27) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(27 ,(uint16_t)((uint32_t)intr_use(27)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(27))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(28) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(28 ,(uint16_t)((uint32_t)intr_use(28)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(28))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(29) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(29 ,(uint16_t)((uint32_t)intr_use(29)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(29))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(30) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(30 ,(uint16_t)((uint32_t)intr_use(30)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(30))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	intr_define(31) ; //Defining the interrupts with the help of the token pasting operator.The definitions will be visible after this point 
	idt_set_gate(31 ,(uint16_t)((uint32_t)intr_use(31)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(31))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	irq_define(0) ;
	idt_set_gate(32 ,(uint16_t)((uint32_t)intr_usei(0)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(0))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	irq_define(1) ;
	idt_set_gate(33 ,(uint16_t)((uint32_t)intr_usei(1)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(1))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	irq_define(2) ;
	idt_set_gate(34 ,(uint16_t)((uint32_t)intr_usei(2)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(2))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	irq_define(3) ;
	idt_set_gate(35 ,(uint16_t)((uint32_t)intr_usei(3)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(3))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	irq_define(4) ;
	idt_set_gate(36 ,(uint16_t)((uint32_t)intr_usei(4)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(4))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	irq_define(5) ;
	idt_set_gate(37 ,(uint16_t)((uint32_t)intr_usei(5)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(5))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	irq_define(6) ;
	idt_set_gate(38 ,(uint16_t)((uint32_t)intr_usei(6)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(6))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	irq_define(7) ;
	idt_set_gate(39 ,(uint16_t)((uint32_t)intr_usei(7)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(7))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	irq_define(8) ;
	idt_set_gate(40 ,(uint16_t)((uint32_t)intr_usei(8)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(8))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	irq_define(9) ;
	idt_set_gate(41 ,(uint16_t)((uint32_t)intr_usei(9)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(9))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	irq_define(10) ;
	idt_set_gate(42 ,(uint16_t)((uint32_t)intr_usei(10)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(10))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	irq_define(11) ;
	idt_set_gate(43 ,(uint16_t)((uint32_t)intr_usei(11)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(11))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	irq_define(12) ;
	idt_set_gate(44 ,(uint16_t)((uint32_t)intr_usei(12)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(12))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	irq_define(13) ;
	idt_set_gate(45 ,(uint16_t)((uint32_t)intr_usei(13)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(13))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	irq_define(14) ;
	idt_set_gate(46 ,(uint16_t)((uint32_t)intr_usei(14)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(14))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	irq_define(15) ;
	idt_set_gate(47 ,(uint16_t)((uint32_t)intr_usei(15)&0xFFFF) ,0x08 ,  (uint16_t)((((uint32_t)intr_use(15))>>16)&0xFFFF) , 0x0E|0x60|0x80);
	
	/*set the base and limit of the idt_ptr*/
	idt_ptr.base = (uint32_t)&idt_entries ;
	idt_ptr.limit = sizeof(idt_entries) -1 ;
	extern void idt_flush(uint32_t);
	idt_flush((uint32_t)&idt_ptr);
	return ;
}
static void init_timer(uint32_t freq) ;
void init_descriptor_tables()
{
	init_gdt();
	init_idt();
	init_pic();
	init_timer(10);
//	init_kbd();
	return ;
}
/*Initializing the timer. Basically what we do is to set up the frequency of the timer clock 0 with the help of a frequency divider.We send the bytes of the 16 bit frequency so determined to the Command port of the PIC*/
static void init_timer(uint32_t freq)
{
	/*The value we want to send to the controller is value we want to divide our input frequency with*/
	uint32_t divisor = 1193180 / freq ;
	/*Read the format of the control word for further information on this*/
	outb((u16int)0x43 , (u8int)0x34);
	/*Send the LSB and then the MSB (We mentioned it in the control byte)*/
	u8int l = (u8int)(divisor&0xFF) ;
	u8int h = (u8int)((divisor>>8)&0xFF) ;
	/*Write to counter 0's data register*/
	outb((u16int)0x40 , l);
	outb((u16int)0x40 , h);
	return ;
}
/*The timer ticks initially set to zero*/
uint32_t ticks = 0;
/*The timer interrupt being serviced by the IRQ0*/
static void timer_interrupt()
{
	ticks++;
	//monitor_write("timer_interrupt :Ticks --> ");
	//monitor_dec(ticks, 0);
}
const char keymap[128]  = {'?','?','1','2','3','4','5','6','7','8','9','0','?','?','?','?','q','w','e',     'r','t','y','u','i','o','p','?','?','?','?','a','s','d','f','g','h','j','k','l','?','?','?','?','?','z','x',       'c','v','b','n','m','?','?','?','?','?','?',' ','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?',     '?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?'};
uint8_t get_key_pressed()
{
	uint8_t stat = inb((u8int)0x64);
	if((stat&01)==1)
	{
		//read the data port
		stat = inb((u8int)0x60);
		if(stat<128)
		{
			//monitor_write("in here\n");
			//monitor_put(keymap[stat]);
			//monitor_dec((int)stat, 0);
			return keymap[stat];
		}
		else
		{
//			monitor_write("in here 2 ");
//			monitor_dec((int)stat, 0);
//			monitor_write("\n");
			return 0;
		}
	}
	return 0;
}
/*Keyboard handler for the keyboard interrupt*/
static void keyboard_interrupt_handler()
{
	/*Get the ASCII code for the key pressed*/
	uint8_t key = get_key_pressed();
	/*Write the key on the monitor*/
	monitor_put((char)key);
	return ;
}
void irq_handler(register_t regs)
{
	if(regs.int_no==32)
	{
		//monitor_write("The notorious timer interrupt is fired\n");
		timer_interrupt();
	}
	else if(regs.int_no==33)
	{
		/*Call the keyboard interrupt handler*/
		keyboard_interrupt_handler();
	}
	if(regs.int_no!=32)
	{
//		monitor_write("Interrupt no. ");
//		monitor_dec(regs.int_no, 0);
//		monitor_write("\n");
	}
	if(regs.int_no >=40) //Singal the slave
	{
//		monitor_write("Signalling the slave about the end of interrupt\n");
		outb((u16int)0xA0 , (u8int)0x20);
	}
	//Signal the master about the end of interrupt
	if(regs.int_no !=32 )
//		monitor_write("Signalling the master about the end of interrupt\n");
		;
	outb((u16int)0x20 , (u8int)0x20);	
}
