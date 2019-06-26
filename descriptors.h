/*This file declares the headers for the decriptors*/
#include "kernel_main.h"
#include "common.h"
#ifndef __DESC
#define __DESC
/*The idt structure*/
struct idt_entry
{
	uint16_t offset_low ;
	uint16_t selector ;
	uint8_t zero ;
	uint8_t flags ;
	uint16_t offset_high ;
}__attribute__((packed));
typedef struct idt_entry idt_entry_t ;
/*The idt pointer structure*/
struct idt_ptr_struct
{
	uint16_t limit ;
	uint32_t base ;
}__attribute__((packed));
typedef struct idt_ptr_struct idt_ptr_t ;
struct gdt_desc
{
	/*bits 0-15 of the segment limit*/
	uint16_t limit_low ;
	/*bits 0-23 of the base address*/
	uint16_t base_low ;
	uint8_t base_middle ;
	/*The descriptor flags*/
	uint8_t access ;
	uint8_t granularity ;
	/*high part of the gdt base address*/
	uint8_t base_high ;
}__attribute__((packed));
typedef struct gdt_desc gdt_entry_t ;
/*The actual gdt pointer to tell the processor where the gdt is located*/
struct gdt_ptr_struct
{
	uint16_t limit ;
	uint32_t base ;
}
__attribute__((packed)); 
typedef struct gdt_ptr_struct gdt_ptr_t ;
void init_descriptor_tables();
#endif 
