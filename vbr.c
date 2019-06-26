#ifndef _CODE16GCC_H_
#define _CODE16GCC_H_
__asm__(".code16gcc\n");
#endif
/*
 * A simple bootloader skeleton for x86, using gcc.
 *
 * Prashant Borole (boroleprashant at Google mail)
 * */
#include "code16gcc.h" 
/* XXX these must be at top */
__asm__ ("jmp main");
    
#define true 1
#define false 0 
#define __NOINLINE  __attribute__((noinline))
#define __REGPARM   __attribute__ ((regparm(3)))
#define __NORETURN  __attribute__((noreturn))
#define disable_intr() __asm__("cli");
/*The function declarations*/
unsigned char    __NOINLINE __REGPARM in(unsigned int port );
void    __NOINLINE __REGPARM out(unsigned int port , unsigned char value);
void    __NOINLINE __REGPARM enable_A20(void);
void    __NOINLINE __REGPARM print(const char   *s) ;
void    __NOINLINE __REGPARM enter_pmode(void) ;
extern void    gdt_load_asm(void) ;
/*
Read a byte (or word or dword) on a given memory location using another segment than the default C data segment. Unfortunately there is no constraint for manipulating segment registers directly, so issuing the 'mov <reg>, <segmentreg>' manually is required.
*/
static inline
unsigned int farpeekl( unsigned short sel, void * off )
{
    unsigned int ret;
    asm( "push %%fs\n\t"
         "mov  %1, %%fs\n\t"
         "mov  %%fs:(%2), %0\n\t"
         "pop  %%fs"
         : "=r"(ret) : "g"(sel), "r"(off) );
    return ret;
}
unsigned char    __NOINLINE __REGPARM in(unsigned int port )
{
   unsigned char ret;
   asm volatile ("inb %%dx,%%al":"=a" (ret):"d" (port));
   return ret;
}
void    __NOINLINE __REGPARM out(unsigned int port , unsigned char value)
{
	asm volatile ("outb %%al,%%dx": :"d" (port), "a" (value));
}
/* keep reading the input buffer's status until it is ready*/
void    __NOINLINE __REGPARM wait_keyboard_input()
{
	 while(true)
	 {
	 	unsigned char status = in(0x64);
	 	if((status&2 )!= 1) /* querry the bit two*/
	 		break ;
	 }
	return ;
}
/* keep reading the output buffer's status until it is ready*/
void    __NOINLINE __REGPARM wait_keyboard_output()
{
	 while(true)
	 {
	 	unsigned char status = in(0x64);
	 	if((status&1) != 0) /* querry the bit one*/
	 		break ;
	 }
	 return ;
}

/* and now , we enable the A20 line*/
void    __NOINLINE __REGPARM enable_A20(void)
{
	/* 
	 * note : I wanted to check whether A20 line is enabled or not. But referring anything above 1 Mib mark will 
	 * Fault on a number of emulators (bochs specifically). So , sacrificing some checking for the sake of compatibility
	 */
	 disable_intr();
	 /* send read output port command */
	 out(0x64 , 0xD0);
	 /* wait for the keyboard output to arrive */
	 wait_keyboard_output();
	 /* read input buffer */
	 unsigned char status = in(0x60);
	 
	 if((status&2)==0)
	 	print("The A20 line is not enabledl");
	 /* wait for the keyboard input to complete */
	 wait_keyboard_input();
	 /* send write output port command to the controller */
	 out(0x64 , 0xD1);
	 /* wait for the output to arrive*/
	 wait_keyboard_input();
	 /* write to the output port*/
	 out(0x60 , status|2);
	 return ;
} 
/* BIOS interrupts must be done with inline assembly */
void    __NOINLINE __REGPARM print(const char   *s)
{
        int i ;
        for(i=0;s[i];i++)
        {
        	char ch = s[i];
        	__asm__("mov $0x0E ,  %ah");
                __asm__("xor %bh ,  %bh");
                __asm__("mov $0xEF ,  %bl");
		__asm__("mov %0 , %%al ;": : "r"(ch): "%eax");
                __asm__("or %al , %al");
                __asm__("int $0x10");
        }
        return ;
}

/* and for everything else you can use C! Be it traversing the filesystem, or verifying the kernel image etc.*/
 
void __NORETURN main(){
  	print("Welcome to the funnyOS !!\r\nKernel modules loaded...\r\n");
  	/*char * str = "this should work \n";
 	int i ;
  	for(i=0; str[i];i++)
  	{
                __asm__("mov $0x0E ,  %ah");
               	__asm__("xor %bh ,  %bh");
                __asm__("mov $0xEF ,  %bl");
		__asm__("mov %0 , %%al ;": : "r"(str[i]):"%eax");
                __asm__("or %al , %al");
                __asm__("int $0x10");
        }
        */
        //enable_A20();
        //int status ;
/*        __asm__("movw $0xFFFF , %ds");
        __asm__("movw  $0x7E0E , %edx");
        __asm__("movw  %ds:(%edx) , %eax");
        __asm__("mov $0x0 , %ds");
        if(status == 0xAA55)
        	print("A20 line is enabled!\r\n");
        else
        	print("A20 is disabled!\r\n");        
    	*/
    	unsigned int r = farpeekl(0xFFFF , (void *)0x7E0E) ;
	if((r&0xFF)==0xAA55)
	{
		print("A 20 mode is disabled\r\n");
		enable_A20();
	}
	else
		print("A 20 mode is enabled \r\n");
	print("Entering Protected mode \r\n");
	__asm__("mov $0x200 , %eax");
 	__asm__("jmp *%eax");
 	while(true)
	{
	}
}

void    __NOINLINE __REGPARM enter_pmode()
{
	/*Load the cr3 register with 2nd bit set*/
	__asm__("mov %cr3 , %eax");
	__asm__("orl %eax , 2");
	__asm__("movl %eax , %cr3");
	/*That's it.The Pmode is enabled. Make a far jump tp prove your point*/
//	__asm__("ljmp $0x08 , *$0xA00");
}
