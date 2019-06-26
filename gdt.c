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

#define __NOINLINE  __attribute__((noinline))
#define __REGPARM   __attribute__ ((regparm(3)))
#define __NORETURN  __attribute__((noreturn))
#define disable_intr() __asm__("cli");
#define uint64_t unsigned long long int 
//Used for creating GDT segment descriptors in 64-bit integer form.
 
 
// Each define here is for a specific flag in the descriptor.
// Refer to the intel documentation for a description of what each one does.
#define SEG_DESCTYPE(x)  ((x) << 0x04) // Descriptor type (0 for system, 1 for code/data)
#define SEG_PRES(x)      ((x) << 0x07) // Present
#define SEG_SAVL(x)      ((x) << 0x0C) // Available for system use
#define SEG_LONG(x)      ((x) << 0x0D) // Long mode
#define SEG_SIZE(x)      ((x) << 0x0E) // Size (0 for 16-bit, 1 for 32)
#define SEG_GRAN(x)      ((x) << 0x0F) // Granularity (0 for 1B - 1MB, 1 for 4KB - 4GB)
#define SEG_PRIV(x)     (((x) &  0x03) << 0x05)   // Set privilege level (0 - 3)
 
#define SEG_DATA_RD        0x00 // Read-Only
#define SEG_DATA_RDA       0x01 // Read-Only, accessed
#define SEG_DATA_RDWR      0x02 // Read/Write
#define SEG_DATA_RDWRA     0x03 // Read/Write, accessed
#define SEG_DATA_RDEXPD    0x04 // Read-Only, expand-down
#define SEG_DATA_RDEXPDA   0x05 // Read-Only, expand-down, accessed
#define SEG_DATA_RDWREXPD  0x06 // Read/Write, expand-down
#define SEG_DATA_RDWREXPDA 0x07 // Read/Write, expand-down, accessed
#define SEG_CODE_EX        0x08 // Execute-Only
#define SEG_CODE_EXA       0x09 // Execute-Only, accessed
#define SEG_CODE_EXRD      0x0A // Execute/Read
#define SEG_CODE_EXRDA     0x0B // Execute/Read, accessed
#define SEG_CODE_EXC       0x0C // Execute-Only, conforming
#define SEG_CODE_EXCA      0x0D // Execute-Only, conforming, accessed
#define SEG_CODE_EXRDC     0x0E // Execute/Read, conforming
#define SEG_CODE_EXRDCA    0x0F // Execute/Read, conforming, accessed
 
#define GDT_CODE_PL0 SEG_DESCTYPE(1) | SEG_PRES(1) | SEG_SAVL(0) | \
                     SEG_LONG(0)     | SEG_SIZE(1) | SEG_GRAN(1) | \
                     SEG_PRIV(0)     | SEG_CODE_EXRD
 
#define GDT_DATA_PL0 SEG_DESCTYPE(1) | SEG_PRES(1) | SEG_SAVL(0) | \
                     SEG_LONG(0)     | SEG_SIZE(1) | SEG_GRAN(1) | \
                     SEG_PRIV(0)     | SEG_DATA_RDWR
 
#define GDT_CODE_PL3 SEG_DESCTYPE(1) | SEG_PRES(1) | SEG_SAVL(0) | \
                     SEG_LONG(0)     | SEG_SIZE(1) | SEG_GRAN(1) | \
                     SEG_PRIV(3)     | SEG_CODE_EXRD
 
#define GDT_DATA_PL3 SEG_DESCTYPE(1) | SEG_PRES(1) | SEG_SAVL(0) | \
                     SEG_LONG(0)     | SEG_SIZE(1) | SEG_GRAN(1) | \
                     SEG_PRIV(3)     | SEG_DATA_RDWR
/* few descriptors we will be needing in the tutorial , we need to declare them globally so that it is accesible to the asm code*/
extern void    __NOINLINE __REGPARM print(const char   *s) ;
uint64_t gdt_array[5]; 
uint64_t * gdt_base ;
unsigned short int gdt_size ;
void __NOINLINE __REGPARM load_gdt_asm();
extern void  load_gdt(void);
/* For creating the descriptor , this is what we're going to use */
unsigned long long int
__NOINLINE __REGPARM create_descriptor( unsigned long long int  base, unsigned int limit, unsigned short int flag )
{
    unsigned long long int descriptor;
 
    // Create the high 32 bit segment
    descriptor  =  limit       & 0x000F0000;         // set limit bits 19:16
    descriptor |= (flag <<  8) & 0x00F0FF00;         // set type, p, dpl, s, g, d/b, l and avl fields
    descriptor |= (base >> 16) & 0x000000FF;         // set base bits 23:16
    descriptor |=  base        & 0xFF000000;         // set base bits 31:24
 
    // Shift by 32 to allow for low part of segment
    descriptor <<= 32;
 
    // Create the low 32 bit segment
    descriptor |= base  << 16;                       // set base bits 15:0
    descriptor |= limit  & 0x0000FFFF;               // set limit bits 15:0
 
//    print("0x%.16llX\n", descriptor);
    return descriptor ;
}
/*This will , in turn , create all the descriptors in place */
void 
__NOINLINE __REGPARM load_gdt()
{
	gdt_array[0]=create_descriptor(0 , 0 , 0 ); //NULL segment
	gdt_array[1]=create_descriptor(0x1000 , 0x000FFFFF , GDT_CODE_PL0 ); //kernel code segment
	gdt_array[2]=create_descriptor(0x1000 , 0x000FFFFF , GDT_DATA_PL0 ); //kernel data segment 
	gdt_array[3]=create_descriptor(0x1000 , 0x000FFFFF , GDT_CODE_PL3 ); //user code segment 
	gdt_array[4]=create_descriptor(0x1000 , 0x000FFFFF , GDT_CODE_PL3 ); //user data segment 
	gdt_base = gdt_array ;
	gdt_size = sizeof(gdt_array) -1 ;
	load_gdt_asm();
}
/*The LDTR structure*/
/*#pragma pack(push , 1) // exact fit , no packing 
struct ldtr_struct
{
	unsigned short size ;
	unsigned long long int * base ;
};
#pragma pack(pop)
*/
/*void __NOINLINE __REGPARM load_gdt_asm()
{
	ldtr.size = gdt_size ;
	ldtr.base = gdt_base ;
	struct ldtr_struct * ldtr_ptr = &ldtr ;
	__asm__("lgdt (%0)":"=r"(ldtr_ptr):);
	print("GDT planted.\r\nTrying to enter Protected mode....");
}*/
