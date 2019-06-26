#include "isr.h"
#include "monitor.h"
#include "kernel_main.h"

void isr_handler(register_t registers)
{
	monitor_write("Interrupt fired\n");
	monitor_write("Interrupt number ");
	monitor_write((unsigned char *)&registers.int_no);
	return ;
}

