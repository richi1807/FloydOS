#include "pmm.h"

/*The largest contigous memory block  variables. The blocks will be allocated
 * from here*/
uint32_t largest_contigous_base ;
uint32_t largest_contigous_length ;

/*This bitmap takes care of all the allocations in the available area*/
uint32_t * allocation_bitmap ; 
uint32_t allocation_bitmap_size ;
uint32_t total_available_blocks;
uint32_t total_used_blocks ;
static uint32_t align_boundary(uint32_t base)
{
	uint32_t result =  base%BLOCK_SIZE ;
	if(result == 0) /*The result is aligned by boundary. return it directly*/
		return base ;
	else
	{
		return base + (BLOCK_SIZE - result);
	}
}
void init_allocation_bitmap()
{
	allocation_bitmap = (uint32_t*)align_boundary(largest_contigous_base);
	total_available_blocks = (uint32_t)largest_contigous_length/BLOCK_SIZE ;
	total_used_blocks = 0;
	allocation_bitmap_size = total_available_blocks/32;/*extra because we might have */
	int i ;
	for(i=0;i<allocation_bitmap_size;i++)
	{
		allocation_bitmap[i]=0; // none of the blocks are actually allocated 
	}
	/*Some of the space might be wasted , do not worry about that*/
	return ;
}
/*This function will find a block to allocate or return 0 if unsuccessfull*/
uint32_t *alloc_block()
{
	int i , j ;
	for(i=0;i<allocation_bitmap_size;i++)
	{
		if(allocation_bitmap[i]!=0xFFFFFFFF)
		{
			for(j=0;j<32;j++)
			{
				/*Check if a particular bit is set or not*/
				uint32_t temp = 1<<(j);
				if((allocation_bitmap[i]&temp)==0)
				{
					/*Found a free block. Return it to the
					 * calling function*/
					allocation_bitmap[i]|=temp;
					total_used_blocks++;
					total_available_blocks--;
					return (uint32_t *)((uint32_t)allocation_bitmap + (i*32+j)*BLOCK_SIZE );
				}
			}
		}
	}
	return 0;
}
/*This function will deallocate the memory that has been allocated till now*/
void dealloc_block(uint32_t * block_address)
{
	uint32_t blk_address = (uint32_t) block_address ;
	blk_address = blk_address - (uint32_t)allocation_bitmap ;
	blk_address = blk_address/BLOCK_SIZE ;
	/*We have reached the particular 32 bit region where this block actually
	 * lies*/
	blk_address =  blk_address/32 ;
	uint32_t index = blk_address ;
	blk_address =  blk_address%32 ;
	allocation_bitmap[index] = allocation_bitmap[index]|(1<<blk_address);
	total_used_blocks--;
	total_available_blocks++;
	return ;
}
