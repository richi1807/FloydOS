#include "common.h"
#include "paging.h"
extern uint32_t read_cr0();
extern void write_cr0(uint32_t );
extern uint32_t * read_cr3();
extern void write_cr3(uint32_t *);
struct page_directory pg_dir;
struct page_table pg_table;
void init_page_directory()
{
	//page_directory	= (uint32_t *) 0x9C000;
	// fill the first entry of the page directory
	pg_dir.m_entry[0] = (uint32_t )&pg_table; // attribute set to: supervisor level, read/write, present(011 in binary)
	pg_dir.m_entry[0] = pg_dir.m_entry[0] | 3;
	// fill the rest of the page directory
	uint32_t i ;
	for(i=1; i<1024; i++)
	{
		pg_dir.m_entry[i] = 0 | 2; // attribute set to: supervisor level, read/write, not present(010 in binary)
	};

}
void init_page_table()
{
	//pg_table	= (uint32_t *) 0x9D000; // the page table comes right after the page directory
	uint32_t address=0; // holds the physical address of where a page is
	uint32_t i;

	// map the first 4MB of memory
	for(i=0; i<1024; i++)
	{
		pg_table.m_entry[i] = address | 3; // attribute set to: supervisor level, read/write, present(011 in binary)
		address = address + 4096; // 4096 = 4kb
	}
}
void enable_paging()
{
	// write_cr3, read_cr3, write_cr0, and read_cr0 all come from the assembly functions
	write_cr3((uint32_t *)&pg_dir); // put that page directory address into CR3
	write_cr0(read_cr0() | 0x80000000); // set the paging bit in CR0 to 1	
}
void paging()
{
	init_page_table();
	init_page_directory();
	enable_paging();
};