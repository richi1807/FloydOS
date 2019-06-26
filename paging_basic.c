#include "paging.h"
#include "monitor.h"
/*Some assembly level functions that ease reading and writing cr3 registers*/
extern uint32_t read_cr0();
extern uint32_t write_cr0();
extern uint32_t read_cr3();
extern uint32_t write_cr3();
uint32_t * pg_dir = (uint32_t *)0x9C00;
uint32_t * pg_tbl = (uint32_t *)0x9D00;
/*This function will initialize the paging tables.Only one paging table is
 * initialized.The first one , which refers to the first 1 MB mark*/
void init_paging_tables()
{
	/*We have the page table in place.Iterate through it*/
	int i ;
	uint32_t address = 0;
	for(i=0;i<1024;i++)
	{
		pg_tbl[i]=address|3; /*present and in supervisor mode*/
		address=address+4096 ;
	}
	return ;
}
/*This function will initialize the paging directory for us*/
void  init_paging_directory()
{
	monitor_write("initializing paging directory\n");
	int i =0;
	uint32_t address = (uint32_t)pg_dir;
	/*Populate the fist table only. As we identity map the first 4 MB of
	 * space*/
	pg_dir[0]=address;
	pg_dir[0]=pg_dir[0]|0x03 ;
	for(i=1;i<1024;i++)
	{
		pg_dir[i]=0|2; //attribute set to not present, supervisor mode
	}
//	monitor_write("paging directory initialized\n");
	return ;
}
void init_paging()
{
	//monitor_write("in here");
	init_paging_tables();
	init_paging_directory();
	/*Write the location of the pdr variable into the cr3 register and set
	 * 32st bit of cr0 register to 1*/
	monitor_write("writing cr3 register\n");
	asm volatile("mov %0, %%cr3":: "b"(pg_dir));
	unsigned int cr0;
	asm volatile("mov %%cr0, %0": "=b"(cr0));
	cr0 |= 0x80000000;
	asm volatile("mov %0, %%cr0":: "b"(cr0));
	monitor_write("Paging is enabled now\n");
	return ;
}

