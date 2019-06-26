#include "common.h"
#ifndef __PMM
#define __PMM
#define BLOCK_SIZE 4096
void init_allocation_bitmap();
uint32_t * alloc_block() ;
void dealloc_block(uint32_t * block_address);
#endif 
