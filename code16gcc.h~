#ifndef __ASSEMBLY__
asm(".code16gcc");
/*The LDTR structure*/
#pragma pack(push , 1) // exact fit , no packing 
struct ldtr_struct
{
	unsigned short size ;
	unsigned long long int * base ;
};
struct ldtr_struct ldtr;
#pragma pack(pop)
#endif 
