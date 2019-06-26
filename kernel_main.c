#include "kernel_main.h"
#include "common.h"
#include "pmm.h"
#include "paging.h"
/*Jump to the main function. This is our first instruction ya know*/
__asm__("mov $0xb00b , %eax");
__asm__("push %eax");
__asm__("mov $0x10 , %ax");
__asm__("mov %ax , %ds");
__asm__("mov %ax , %es");
__asm__("mov %ax , %ss");
__asm__("pop %eax");
__asm__("push %ebx");
__asm__("push %eax");
__asm__("call main");
/**
 * The multiboot header structure 
 */
extern uint32_t largest_contigous_base;
extern uint32_t largest_contigous_length ;
extern void paging();
struct multiboot_info 
{
	u32int flags ;
	u32int memory_low ;
	u32int memory_high ;
	u32int boot_device ; 
	u32int cmd_line ;
	u32int mods_count ;
	u32int mods_addr;
	u32int syms0;
	u32int syms1;
	u32int syms2;
	u32int mmap_length ;
	u32int mmap_addr ;
	u32int drives_length ;
	u32int drives_addr ;
	u32int config_table ;
	u32int bootloader_name ;
	u32int apm_table ;
	u32int vbe_control_info;
	u32int vbe_mode_info ;
	u16int vbe_mode ;
	u16int vbe_interface_seg;
	u16int vbe_interface_off;
	u16int vbe_interface_len ;
}__attribute__((packed));
struct mmap_entry
{
	uint64_t base_address ;
	uint64_t length ;
	uint32_t type ;
}__attribute__((packed));
extern void init_descriptor_tables() ;
extern void monitor_write(char * s);
extern void monitor_clear();
 void monitor_dec(uint32_t , uint8_t);
/*This function will load the memory map.It also determines the largest
 * contigous available block of memory which will be used by our physical
 * memory manager*/
void load_system_memory_map(u32int mmap_length , u32int mmap_addr)
{
	largest_contigous_base=0;
	largest_contigous_length=0;
	monitor_write("Printing system memory map\n");
	int i ;
	monitor_write("-----------------------------------\n");
	for(i=0;i<mmap_length;i++)
	{
		struct mmap_entry * m_entry = (struct mmap_entry *)mmap_addr + i ;
		if(m_entry->type==1)
		{
			monitor_write("type: available ");
		}
		else if(m_entry->type==2)
		{
			monitor_write("type: reserved ");
		}
		else if(m_entry->type==3)
		{
			monitor_write("type: acpi reclaim");
		}
		else if(m_entry->type==4)
		{
			monitor_write("type: acpi nvs store");
		}
		else 
		{
			monitor_write("Error reading memory map.Memory type undefined \n");
			monitor_dec(m_entry->type, 0);
			continue ;
		}
		/*The base address*/
		monitor_write("base ");
		monitor_dec((uint32_t)m_entry->base_address,0);
		monitor_write("     length:");
		monitor_dec((uint32_t)m_entry->length,0);
		monitor_write("\n");
		if((m_entry->type==1)&&(m_entry->length>largest_contigous_length))
		{
			largest_contigous_base = m_entry->base_address;
			largest_contigous_length = m_entry->length ;
		}
	}
	monitor_write("---------------------------------\n");
	return ;
}
u32int convert_to_physical(u32int physical)
{
	return physical + 0x40000C00 ;
}
u32int convert_to_virtual(u32int virtual)
{
	return virtual - 0x40000C00 ;
}
/*This function will parse the ebx register and load the memory map into the
 * memory map structure*/
static void load_memory_map(u32int ebx)
{
	struct multiboot_info * mboot_info = (struct multiboot_info *)ebx ;
	/*printing up the total memory*/
	u32int total_memory = mboot_info->memory_low + 64*mboot_info->memory_high + 1024 ; //Not need to document , you will remember this fuking expression the rest of ur life
	monitor_write("Total system memory ");
	monitor_dec(total_memory,0);
	monitor_write("bytes\n");
	load_system_memory_map(mboot_info->mmap_length , mboot_info->mmap_addr);
	return ;
};
/*If we are following a multiboot header type of booting.The following
 * conditions should be met 
 * 1. EAX should have the value as 0x2BADB002
 * */
static void verify_multiboot_header(u32int eax, u32int ebx)
{
	if(eax==0x2BADB002)
		monitor_write("Testing multiboot header successful\n");
	else
		monitor_write("Multiboot header not successful");
	/*Load the memory map from the multiboot header structure*/
	load_memory_map(ebx);
}
/*The starting point for our kernel. This is where our high level OS starts*/
void main(u32int eax, u32int ebx)
{
	monitor_clear();
	monitor_write("Welcome to the Pink floyd OS\n");
	monitor_write("Kernel modules loaded");
	monitor_write("The multiboot header address is :");
	monitor_dec(ebx , 0);
	monitor_write("\n");
	/*print the multiboot information from the address present in the ebx
	 * register and also verify the multiboot header*/
	verify_multiboot_header(eax, ebx);
	/*intialize the descriptors in the memory both for GDT and IDT*/
	init_descriptor_tables();
	monitor_write("Initializing descriptor tables...\n");
	monitor_write("Initializing block allocator\n");
	init_allocation_bitmap();
	monitor_write("Allocating two blocks of memory\n");
	uint32_t * ptr = alloc_block();
	uint32_t * ptr2 = alloc_block();
	if((ptr==(uint32_t*)0x0)||(ptr2==(uint32_t*)0x0))
		monitor_write("Allocation failed\n");
	else
	{
		monitor_write("Block allocated at memory addresses :");
		monitor_dec((uint32_t)ptr, 0);
		monitor_write((" "));
		monitor_dec((uint32_t)ptr2 ,0);
	}
	monitor_write("deallocating both the blocks\n");
	monitor_write("Enabling paging\n");
	paging();
	monitor_write("paging has been enabled\n");
	while(1)
	;
}
// Write a byte out to the specified port.
void outb(u16int port, u8int value)
{
    asm volatile ("outb %1, %0" : : "dN" (port), "a" (value));
}

u8int inb(u16int port)
{
   u8int ret;
   asm volatile("inb %1, %0" : "=a" (ret) : "dN" (port));
   return ret;
}

u16int inw(u16int port)
{
   u16int ret;
   asm volatile ("inw %1, %0" : "=a" (ret) : "dN" (port));
   return ret;
} 
