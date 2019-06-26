#include "common.h"
#ifndef __PAGING
#define __PAGING
#define PRESENT 1
#define WRITABLE 2
#define USER 4
#define ACCESSED 0x10
#define DIRTY 0x20
#define PAGE_FRAME 0x7FFFF000;
typedef uint32_t pt_entry ;
/*Some of the functions making our job easier*/
#define PAGES_PER_TABLE 1024 
#define PAGES_PER_DIR 1024
#define PAGE_SIZE 4096 
#define PAGE_DIRECTORY_INDEX(x) (((x) >> 22) & 0x3ff)
#define PAGE_TABLE_INDEX(x) (((x) >> 12) & 0x3ff)
#define PAGE_GET_PHYSICAL_ADDRESS(x) (*x & ~0xfff)
struct page_table
{
	pt_entry m_entry[PAGES_PER_TABLE];
}__attribute__((aligned(4096)));
typedef uint32_t pd_entry;
struct page_directory
{
	pd_entry m_entry[PAGES_PER_DIR];
}__attribute__((aligned(4096)));
void init_paging() ;
#endif
