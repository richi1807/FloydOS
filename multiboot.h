#ifndef __MULTIBOOT
#define __MULTIBOOT
#define ui unsigned int 
struct multiboot_info
{
	unsigned int flags ;
	unsigned int memory_low;
	ui memory_high ;
	ui boot_device ;
	ui cmd_line ;
	ui mods_count ;
	ui syms0;
	ui syms1;
	ui syms2;
	ui mmap_length ;
	ui mmap_addr ;
	ui drives_length ;
	ui drives_addr;
	ui config_table ;
	ui bootloader_name ;
	ui apm_table ;
	ui vbe_control_info ;
	ui mode_info ;
	ui mode ;
	ui interface_seg ;
	ui interface_off ;
	ui interface_len ;
};
#endif
