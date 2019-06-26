#include "common.h"
/*Defines the register in a particular order.Note that the element pushed last
 * on the stack is the element which is at the lowermost memory address. This
 * means that the first element in the struct which is at the lowermost memory
 * address is the one which gets the element which had been pushed on the stack
 * most recently 
 * Structure padding used very cleverly here. We will tweat it in the morning 
 * */
struct register_struct 
{
	uint32_t ds ; // last to be pushed 
	uint32_t edi , esi , ebp , esp , ebx , edx , ecx , eax ;
	uint32_t int_no , error_code ;
	uint32_t eip , cs , eflags , useresp , ss ;
};

typedef struct register_struct register_t ;
