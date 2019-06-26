	.file	"kernel_main.c"
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.text
.Ltext0:
	.cfi_sections	.debug_frame
#APP
	push %ebx
	push %eax
	call main
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Printing system memory map\n"
.LC1:
	.string	"-----------------------------------\n"
.LC2:
	.string	"type: available "
.LC3:
	.string	"type: reserved "
.LC4:
	.string	"type: acpi reclaim"
.LC5:
	.string	"type: acpi nvs store"
.LC6:
	.string	"Error reading memory map.Memory type undefined \n"
.LC7:
	.string	"base "
.LC8:
	.string	"     length:"
.LC9:
	.string	"\n"
.LC10:
	.string	"---------------------------------\n"
#NO_APP
	.text
.globl load_system_memory_map
	.type	load_system_memory_map, @function
load_system_memory_map:
.LFB0:
	.file 1 "kernel_main.c"
	.loc 1 55 0
	.cfi_startproc
.LVL0:
	pushl	%ebp
.LCFI0:
	.cfi_def_cfa_offset 8
	movl	%esp, %ebp
	.cfi_offset 5, -8
.LCFI1:
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	.loc 1 60 0
	xorl	%esi, %esi
	.cfi_offset 6, -16
	.cfi_offset 7, -12
.LVL1:
	.loc 1 55 0
	pushl	%ebx
	subl	$24, %esp
	.loc 1 55 0
	movl	8(%ebp), %edi
	movl	12(%ebp), %ebx
	.cfi_offset 3, -20
	.loc 1 56 0
	movl	$0, largest_contigous_base
	.loc 1 57 0
	movl	$0, largest_contigous_length
	.loc 1 58 0
	pushl	$.LC0
	.cfi_escape 0x2e,0x10
	call	monitor_write
	.loc 1 60 0
	movl	$.LC1, (%esp)
	call	monitor_write
	.loc 1 61 0
	addl	$16, %esp
	jmp	.L2
.LVL2:
.L10:
.LBB8:
	.loc 1 64 0
	movl	16(%ebx), %eax
	cmpl	$1, %eax
	jne	.L3
	.loc 1 66 0
	subl	$12, %esp
	pushl	$.LC2
	jmp	.L13
.L3:
	.loc 1 68 0
	cmpl	$2, %eax
	jne	.L5
	.loc 1 70 0
	subl	$12, %esp
	pushl	$.LC3
	jmp	.L13
.L5:
	.loc 1 72 0
	cmpl	$3, %eax
	jne	.L6
	.loc 1 74 0
	subl	$12, %esp
	pushl	$.LC4
	jmp	.L13
.L6:
	.loc 1 76 0
	cmpl	$4, %eax
	jne	.L7
	.loc 1 78 0
	subl	$12, %esp
	pushl	$.LC5
.L13:
	call	monitor_write
	addl	$16, %esp
	.loc 1 87 0
	subl	$12, %esp
	pushl	$.LC7
	call	monitor_write
	.loc 1 88 0
	popl	%ecx
	popl	%eax
	pushl	$0
	pushl	(%ebx)
	call	monitor_dec
	.loc 1 89 0
	movl	$.LC8, (%esp)
	call	monitor_write
	.loc 1 90 0
	popl	%eax
	popl	%edx
	pushl	$0
	pushl	8(%ebx)
	call	monitor_dec
	.loc 1 91 0
	movl	$.LC9, (%esp)
	call	monitor_write
	.loc 1 92 0
	addl	$16, %esp
	cmpl	$1, 16(%ebx)
	jne	.L8
	jmp	.L16
.L7:
	.loc 1 82 0
	subl	$12, %esp
	pushl	$.LC6
	call	monitor_write
	.loc 1 83 0
	popl	%edx
	popl	%ecx
	pushl	$0
	pushl	16(%ebx)
	call	monitor_dec
	.loc 1 84 0
	addl	$16, %esp
	jmp	.L8
.L16:
	.loc 1 92 0
	cmpl	$0, 12(%ebx)
	movl	8(%ebx), %eax
	movl	largest_contigous_length, %edx
	jne	.L12
	cmpl	%edx, %eax
	jbe	.L8
.L12:
	.loc 1 94 0
	movl	(%ebx), %edx
	.loc 1 95 0
	movl	%eax, largest_contigous_length
	.loc 1 94 0
	movl	%edx, largest_contigous_base
.L8:
.LBE8:
	.loc 1 61 0
	incl	%esi
	addl	$20, %ebx
.LVL3:
.L2:
	cmpl	%edi, %esi
	jb	.L10
	.loc 1 98 0
	movl	$.LC10, 8(%ebp)
	.loc 1 100 0
	leal	-12(%ebp), %esp
	popl	%ebx
.LVL4:
	popl	%esi
.LVL5:
	popl	%edi
.LVL6:
	popl	%ebp
	.loc 1 98 0
	.cfi_escape 0x2e,0x4
	jmp	monitor_write
	.cfi_endproc
.LFE0:
	.size	load_system_memory_map, .-load_system_memory_map
	.section	.rodata.str1.1
.LC11:
	.string	"Welcome to the Pink floyd OS\n"
.LC12:
	.string	"Kernel modules loaded"
.LC13:
	.string	"The multiboot header address is :"
.LC14:
	.string	"Testing multiboot header successful\n"
.LC15:
	.string	"Multiboot header not successful"
.LC16:
	.string	"Total system memory "
.LC17:
	.string	"bytes\n"
.LC18:
	.string	"Initializing descriptor tables...\n"
.LC19:
	.string	"Initializing block allocator\n"
.LC20:
	.string	"Allocating two blocks of memory\n"
.LC21:
	.string	"Allocation failed\n"
.LC22:
	.string	"Block allocated at memory addresses :"
.LC23:
	.string	" "
.LC24:
	.string	"deallocating both the blocks\n"
.LC25:
	.string	"Enabling paging\n"
	.text
.globl main
	.type	main, @function
main:
.LFB3:
	.loc 1 129 0
	.cfi_startproc
.LVL7:
	leal	4(%esp), %ecx
.LCFI2:
	.cfi_def_cfa 1, 0
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	movl	%esp, %ebp
	.cfi_escape 0x10,0x5,0x1,0x55
	pushl	%esi
	pushl	%ebx
	pushl	%ecx
.LCFI3:
	.cfi_escape 0xf,0x3,0x75,0x74,0x6
	subl	$12, %esp
	.loc 1 129 0
	movl	(%ecx), %esi
	.cfi_escape 0x10,0x3,0x2,0x75,0x78
	.cfi_escape 0x10,0x6,0x2,0x75,0x7c
	movl	4(%ecx), %ebx
	.loc 1 130 0
	call	monitor_clear
	.loc 1 131 0
	subl	$12, %esp
	pushl	$.LC11
	.cfi_escape 0x2e,0x10
	call	monitor_write
	.loc 1 132 0
	movl	$.LC12, (%esp)
	call	monitor_write
	.loc 1 133 0
	movl	$.LC13, (%esp)
	call	monitor_write
	.loc 1 134 0
	popl	%eax
	popl	%edx
	pushl	$0
	pushl	%ebx
	call	monitor_dec
	.loc 1 135 0
	movl	$.LC9, (%esp)
	call	monitor_write
.LBB9:
.LBB10:
	.loc 1 120 0
	addl	$16, %esp
	cmpl	$732803074, %esi
	jne	.L18
.LVL8:
	.loc 1 121 0
	subl	$12, %esp
	pushl	$.LC14
	jmp	.L26
.L18:
	.loc 1 123 0
	subl	$12, %esp
	pushl	$.LC15
.L26:
	call	monitor_write
.LBB11:
.LBB12:
	.loc 1 107 0
	movl	8(%ebx), %eax
	movl	4(%ebx), %edx
	.loc 1 108 0
	movl	$.LC16, (%esp)
	.loc 1 107 0
	sall	$6, %eax
	leal	1024(%edx,%eax), %esi
.LVL9:
	.loc 1 108 0
	call	monitor_write
	.loc 1 109 0
	popl	%edx
	popl	%ecx
	pushl	$0
	pushl	%esi
	call	monitor_dec
	.loc 1 110 0
	movl	$.LC17, (%esp)
	call	monitor_write
	.loc 1 111 0
	popl	%esi
.LVL10:
	popl	%eax
	pushl	44(%ebx)
	pushl	40(%ebx)
	call	load_system_memory_map
.LBE12:
.LBE11:
.LBE10:
.LBE9:
	.loc 1 140 0
	.cfi_escape 0x2e,0x0
	call	init_descriptor_tables
	.loc 1 141 0
	movl	$.LC18, (%esp)
	.cfi_escape 0x2e,0x10
	call	monitor_write
	.loc 1 142 0
	movl	$.LC19, (%esp)
	call	monitor_write
	.loc 1 143 0
	.cfi_escape 0x2e,0x0
	call	init_allocation_bitmap
	.loc 1 144 0
	movl	$.LC20, (%esp)
	.cfi_escape 0x2e,0x10
	call	monitor_write
	.loc 1 145 0
	.cfi_escape 0x2e,0x0
	call	alloc_block
	movl	%eax, %ebx
.LVL11:
	.loc 1 146 0
	call	alloc_block
	.loc 1 147 0
	addl	$16, %esp
	testl	%eax, %eax
.LVL12:
	.loc 1 146 0
	movl	%eax, %esi
.LVL13:
	.loc 1 147 0
	je	.L25
	testl	%ebx, %ebx
	jne	.L20
.L25:
	.loc 1 148 0
	subl	$12, %esp
	pushl	$.LC21
	.cfi_escape 0x2e,0x10
	call	monitor_write
	jmp	.L27
.L20:
	.loc 1 151 0
	subl	$12, %esp
	pushl	$.LC22
	call	monitor_write
	.loc 1 152 0
	popl	%edx
	popl	%ecx
	pushl	$0
	pushl	%ebx
	call	monitor_dec
	.loc 1 153 0
	movl	$.LC23, (%esp)
	call	monitor_write
	.loc 1 154 0
	popl	%ebx
.LVL14:
	popl	%eax
	pushl	$0
	pushl	%esi
	call	monitor_dec
.LVL15:
.L27:
	.loc 1 156 0
	movl	$.LC24, (%esp)
	call	monitor_write
	.loc 1 157 0
	movl	$.LC25, (%esp)
	call	monitor_write
	.loc 1 158 0
	.cfi_escape 0x2e,0x0
	call	init_paging
	addl	$16, %esp
.L23:
	jmp	.L23
	.cfi_endproc
.LFE3:
	.size	main, .-main
.globl outb
	.type	outb, @function
outb:
.LFB4:
	.loc 1 164 0
	.cfi_startproc
.LVL16:
	pushl	%ebp
.LCFI4:
	.cfi_def_cfa_offset 8
	movl	%esp, %ebp
	.cfi_offset 5, -8
.LCFI5:
	.cfi_def_cfa_register 5
	.loc 1 165 0
	movb	12(%ebp), %al
	movl	8(%ebp), %edx
#APP
# 165 "kernel_main.c" 1
	outb %al, %dx
# 0 "" 2
	.loc 1 166 0
#NO_APP
	popl	%ebp
	ret
	.cfi_endproc
.LFE4:
	.size	outb, .-outb
.globl inb
	.type	inb, @function
inb:
.LFB5:
	.loc 1 169 0
	.cfi_startproc
.LVL17:
	pushl	%ebp
.LCFI6:
	.cfi_def_cfa_offset 8
	movl	%esp, %ebp
	.cfi_offset 5, -8
.LCFI7:
	.cfi_def_cfa_register 5
	.loc 1 171 0
	movl	8(%ebp), %edx
#APP
# 171 "kernel_main.c" 1
	inb %dx, %al
# 0 "" 2
.LVL18:
.LVL19:
	.loc 1 173 0
#NO_APP
	popl	%ebp
	ret
	.cfi_endproc
.LFE5:
	.size	inb, .-inb
.globl inw
	.type	inw, @function
inw:
.LFB6:
	.loc 1 176 0
	.cfi_startproc
.LVL20:
	pushl	%ebp
.LCFI8:
	.cfi_def_cfa_offset 8
	movl	%esp, %ebp
	.cfi_offset 5, -8
.LCFI9:
	.cfi_def_cfa_register 5
	.loc 1 178 0
	movl	8(%ebp), %edx
#APP
# 178 "kernel_main.c" 1
	inw %dx, %ax
# 0 "" 2
.LVL21:
.LVL22:
	.loc 1 180 0
#NO_APP
	popl	%ebp
	ret
	.cfi_endproc
.LFE6:
	.size	inw, .-inw
.Letext0:
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST0:
	.long	.LFB0-.Ltext0
	.long	.LCFI0-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI0-.Ltext0
	.long	.LCFI1-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI1-.Ltext0
	.long	.LFE0-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST1:
	.long	.LVL0-.Ltext0
	.long	.LVL2-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL2-.Ltext0
	.long	.LVL6-.Ltext0
	.value	0x1
	.byte	0x57
	.long	.LVL6-.Ltext0
	.long	.LFE0-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST2:
	.long	.LVL0-.Ltext0
	.long	.LVL2-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 4
	.long	.LVL2-.Ltext0
	.long	.LVL4-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL4-.Ltext0
	.long	.LFE0-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 12
	.long	0x0
	.long	0x0
.LLST3:
	.long	.LVL1-.Ltext0
	.long	.LVL5-.Ltext0
	.value	0x1
	.byte	0x56
	.long	0x0
	.long	0x0
.LLST4:
	.long	.LFB3-.Ltext0
	.long	.LCFI2-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI2-.Ltext0
	.long	.LCFI3-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LCFI3-.Ltext0
	.long	.LFE3-.Ltext0
	.value	0x3
	.byte	0x75
	.sleb128 -12
	.byte	0x6
	.long	0x0
	.long	0x0
.LLST5:
	.long	.LVL7-.Ltext0
	.long	.LVL8-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL8-.Ltext0
	.long	.LVL9-.Ltext0
	.value	0x1
	.byte	0x56
	.long	.LVL9-.Ltext0
	.long	.LFE3-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	0x0
	.long	0x0
.LLST6:
	.long	.LVL7-.Ltext0
	.long	.LVL8-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 4
	.long	.LVL8-.Ltext0
	.long	.LVL11-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL11-.Ltext0
	.long	.LFE3-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 4
	.long	0x0
	.long	0x0
.LLST7:
	.long	.LVL11-.Ltext0
	.long	.LVL14-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL15-.Ltext0
	.long	.LFE3-.Ltext0
	.value	0x1
	.byte	0x53
	.long	0x0
	.long	0x0
.LLST8:
	.long	.LVL12-.Ltext0
	.long	.LVL13-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0x0
	.long	0x0
.LLST9:
	.long	.LVL9-.Ltext0
	.long	.LVL10-.Ltext0
	.value	0x1
	.byte	0x56
	.long	0x0
	.long	0x0
.LLST10:
	.long	.LFB4-.Ltext0
	.long	.LCFI4-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI4-.Ltext0
	.long	.LCFI5-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI5-.Ltext0
	.long	.LFE4-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST11:
	.long	.LFB5-.Ltext0
	.long	.LCFI6-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI6-.Ltext0
	.long	.LCFI7-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI7-.Ltext0
	.long	.LFE5-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST12:
	.long	.LVL18-.Ltext0
	.long	.LVL19-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0x0
	.long	0x0
.LLST13:
	.long	.LFB6-.Ltext0
	.long	.LCFI8-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI8-.Ltext0
	.long	.LCFI9-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI9-.Ltext0
	.long	.LFE6-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST14:
	.long	.LVL21-.Ltext0
	.long	.LVL22-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0x0
	.long	0x0
	.file 2 "kernel_main.h"
	.file 3 "common.h"
	.section	.debug_info
	.long	0x443
	.value	0x2
	.long	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.long	.LASF54
	.byte	0x1
	.long	.LASF55
	.long	.LASF56
	.long	.Ltext0
	.long	.Letext0
	.long	.Ldebug_line0
	.uleb128 0x2
	.long	.LASF1
	.byte	0x2
	.byte	0x9
	.long	0x30
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.long	.LASF0
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x2
	.long	.LASF2
	.byte	0x2
	.byte	0xb
	.long	0x49
	.uleb128 0x3
	.byte	0x2
	.byte	0x7
	.long	.LASF3
	.uleb128 0x3
	.byte	0x2
	.byte	0x5
	.long	.LASF4
	.uleb128 0x2
	.long	.LASF5
	.byte	0x2
	.byte	0xd
	.long	0x62
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.long	.LASF6
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF7
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF8
	.uleb128 0x2
	.long	.LASF9
	.byte	0x3
	.byte	0x8
	.long	0x30
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.long	.LASF10
	.uleb128 0x2
	.long	.LASF11
	.byte	0x3
	.byte	0xa
	.long	0x94
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.long	.LASF12
	.uleb128 0x5
	.byte	0x4
	.byte	0x7
	.uleb128 0x6
	.long	.LASF36
	.byte	0x54
	.byte	0x1
	.byte	0x10
	.long	0x1ed
	.uleb128 0x7
	.long	.LASF13
	.byte	0x1
	.byte	0x11
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x7
	.long	.LASF14
	.byte	0x1
	.byte	0x12
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x7
	.long	.LASF15
	.byte	0x1
	.byte	0x13
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0x7
	.long	.LASF16
	.byte	0x1
	.byte	0x14
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0xc
	.uleb128 0x7
	.long	.LASF17
	.byte	0x1
	.byte	0x15
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.uleb128 0x7
	.long	.LASF18
	.byte	0x1
	.byte	0x16
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x14
	.uleb128 0x7
	.long	.LASF19
	.byte	0x1
	.byte	0x17
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x18
	.uleb128 0x7
	.long	.LASF20
	.byte	0x1
	.byte	0x18
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x1c
	.uleb128 0x7
	.long	.LASF21
	.byte	0x1
	.byte	0x19
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x20
	.uleb128 0x7
	.long	.LASF22
	.byte	0x1
	.byte	0x1a
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x24
	.uleb128 0x7
	.long	.LASF23
	.byte	0x1
	.byte	0x1b
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x28
	.uleb128 0x7
	.long	.LASF24
	.byte	0x1
	.byte	0x1c
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x2c
	.uleb128 0x7
	.long	.LASF25
	.byte	0x1
	.byte	0x1d
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x30
	.uleb128 0x7
	.long	.LASF26
	.byte	0x1
	.byte	0x1e
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x34
	.uleb128 0x7
	.long	.LASF27
	.byte	0x1
	.byte	0x1f
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x38
	.uleb128 0x7
	.long	.LASF28
	.byte	0x1
	.byte	0x20
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x3c
	.uleb128 0x7
	.long	.LASF29
	.byte	0x1
	.byte	0x21
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x40
	.uleb128 0x7
	.long	.LASF30
	.byte	0x1
	.byte	0x22
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x44
	.uleb128 0x7
	.long	.LASF31
	.byte	0x1
	.byte	0x23
	.long	0x25
	.byte	0x2
	.byte	0x23
	.uleb128 0x48
	.uleb128 0x7
	.long	.LASF32
	.byte	0x1
	.byte	0x24
	.long	0x3e
	.byte	0x2
	.byte	0x23
	.uleb128 0x4c
	.uleb128 0x7
	.long	.LASF33
	.byte	0x1
	.byte	0x25
	.long	0x3e
	.byte	0x2
	.byte	0x23
	.uleb128 0x4e
	.uleb128 0x7
	.long	.LASF34
	.byte	0x1
	.byte	0x26
	.long	0x3e
	.byte	0x2
	.byte	0x23
	.uleb128 0x50
	.uleb128 0x7
	.long	.LASF35
	.byte	0x1
	.byte	0x27
	.long	0x3e
	.byte	0x2
	.byte	0x23
	.uleb128 0x52
	.byte	0x0
	.uleb128 0x6
	.long	.LASF37
	.byte	0x14
	.byte	0x1
	.byte	0x2a
	.long	0x224
	.uleb128 0x7
	.long	.LASF38
	.byte	0x1
	.byte	0x2b
	.long	0x89
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x7
	.long	.LASF39
	.byte	0x1
	.byte	0x2c
	.long	0x89
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0x7
	.long	.LASF40
	.byte	0x1
	.byte	0x2d
	.long	0x77
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.byte	0x0
	.uleb128 0x8
	.long	.LASF43
	.byte	0x1
	.byte	0x67
	.byte	0x1
	.byte	0x1
	.long	0x253
	.uleb128 0x9
	.string	"ebx"
	.byte	0x1
	.byte	0x67
	.long	0x25
	.uleb128 0xa
	.long	.LASF41
	.byte	0x1
	.byte	0x69
	.long	0x253
	.uleb128 0xa
	.long	.LASF42
	.byte	0x1
	.byte	0x6b
	.long	0x25
	.byte	0x0
	.uleb128 0xb
	.byte	0x4
	.long	0x9e
	.uleb128 0x8
	.long	.LASF44
	.byte	0x1
	.byte	0x76
	.byte	0x1
	.byte	0x1
	.long	0x27d
	.uleb128 0x9
	.string	"eax"
	.byte	0x1
	.byte	0x76
	.long	0x25
	.uleb128 0x9
	.string	"ebx"
	.byte	0x1
	.byte	0x76
	.long	0x25
	.byte	0x0
	.uleb128 0xc
	.byte	0x1
	.long	.LASF46
	.byte	0x1
	.byte	0x36
	.byte	0x1
	.long	.LFB0
	.long	.LFE0
	.long	.LLST0
	.long	0x2d7
	.uleb128 0xd
	.long	.LASF23
	.byte	0x1
	.byte	0x36
	.long	0x25
	.long	.LLST1
	.uleb128 0xd
	.long	.LASF24
	.byte	0x1
	.byte	0x36
	.long	0x25
	.long	.LLST2
	.uleb128 0xe
	.string	"i"
	.byte	0x1
	.byte	0x3b
	.long	0x37
	.long	.LLST3
	.uleb128 0xf
	.long	.LBB8
	.long	.LBE8
	.uleb128 0xa
	.long	.LASF45
	.byte	0x1
	.byte	0x3f
	.long	0x2d7
	.byte	0x0
	.byte	0x0
	.uleb128 0xb
	.byte	0x4
	.long	0x1ed
	.uleb128 0xc
	.byte	0x1
	.long	.LASF47
	.byte	0x1
	.byte	0x80
	.byte	0x1
	.long	.LFB3
	.long	.LFE3
	.long	.LLST4
	.long	0x37a
	.uleb128 0x10
	.string	"eax"
	.byte	0x1
	.byte	0x80
	.long	0x25
	.long	.LLST5
	.uleb128 0x10
	.string	"ebx"
	.byte	0x1
	.byte	0x80
	.long	0x25
	.long	.LLST6
	.uleb128 0xe
	.string	"ptr"
	.byte	0x1
	.byte	0x91
	.long	0x37a
	.long	.LLST7
	.uleb128 0x11
	.long	.LASF48
	.byte	0x1
	.byte	0x92
	.long	0x37a
	.long	.LLST8
	.uleb128 0x12
	.long	0x259
	.long	.LBB9
	.long	.LBE9
	.byte	0x1
	.byte	0x8a
	.uleb128 0x13
	.long	0x271
	.uleb128 0x13
	.long	0x266
	.uleb128 0x12
	.long	0x224
	.long	.LBB11
	.long	.LBE11
	.byte	0x1
	.byte	0x7d
	.uleb128 0x13
	.long	0x231
	.uleb128 0xf
	.long	.LBB12
	.long	.LBE12
	.uleb128 0x14
	.long	0x23c
	.uleb128 0x15
	.long	0x247
	.long	.LLST9
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.uleb128 0xb
	.byte	0x4
	.long	0x77
	.uleb128 0xc
	.byte	0x1
	.long	.LASF49
	.byte	0x1
	.byte	0xa3
	.byte	0x1
	.long	.LFB4
	.long	.LFE4
	.long	.LLST10
	.long	0x3b6
	.uleb128 0x16
	.long	.LASF50
	.byte	0x1
	.byte	0xa3
	.long	0x3e
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x16
	.long	.LASF51
	.byte	0x1
	.byte	0xa3
	.long	0x57
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.byte	0x0
	.uleb128 0x17
	.byte	0x1
	.string	"inb"
	.byte	0x1
	.byte	0xa8
	.byte	0x1
	.long	0x57
	.long	.LFB5
	.long	.LFE5
	.long	.LLST11
	.long	0x3f1
	.uleb128 0x16
	.long	.LASF50
	.byte	0x1
	.byte	0xa8
	.long	0x3e
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0xe
	.string	"ret"
	.byte	0x1
	.byte	0xaa
	.long	0x57
	.long	.LLST12
	.byte	0x0
	.uleb128 0x17
	.byte	0x1
	.string	"inw"
	.byte	0x1
	.byte	0xaf
	.byte	0x1
	.long	0x3e
	.long	.LFB6
	.long	.LFE6
	.long	.LLST13
	.long	0x42c
	.uleb128 0x16
	.long	.LASF50
	.byte	0x1
	.byte	0xaf
	.long	0x3e
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0xe
	.string	"ret"
	.byte	0x1
	.byte	0xb1
	.long	0x3e
	.long	.LLST14
	.byte	0x0
	.uleb128 0x18
	.long	.LASF52
	.byte	0x1
	.byte	0xd
	.long	0x77
	.byte	0x1
	.byte	0x1
	.uleb128 0x18
	.long	.LASF53
	.byte	0x1
	.byte	0xe
	.long	0x77
	.byte	0x1
	.byte	0x1
	.byte	0x0
	.section	.debug_abbrev
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x6
	.byte	0x0
	.byte	0x0
	.uleb128 0x2
	.uleb128 0x16
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0x0
	.byte	0x0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0x0
	.byte	0x0
	.uleb128 0x5
	.uleb128 0x24
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x6
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x7
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x8
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x9
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xa
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xf
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xc
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xd
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0x0
	.byte	0x0
	.uleb128 0xe
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0x0
	.byte	0x0
	.uleb128 0xf
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.byte	0x0
	.byte	0x0
	.uleb128 0x10
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0x0
	.byte	0x0
	.uleb128 0x11
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0x0
	.byte	0x0
	.uleb128 0x12
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x13
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x14
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x15
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0x0
	.byte	0x0
	.uleb128 0x16
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x17
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x18
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.section	.debug_pubnames,"",@progbits
	.long	0x4b
	.value	0x2
	.long	.Ldebug_info0
	.long	0x447
	.long	0x27d
	.string	"load_system_memory_map"
	.long	0x2dd
	.string	"main"
	.long	0x380
	.string	"outb"
	.long	0x3b6
	.string	"inb"
	.long	0x3f1
	.string	"inw"
	.long	0x0
	.section	.debug_aranges,"",@progbits
	.long	0x1c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x4
	.byte	0x0
	.value	0x0
	.value	0x0
	.long	.Ltext0
	.long	.Letext0-.Ltext0
	.long	0x0
	.long	0x0
	.section	.debug_str,"MS",@progbits,1
.LASF36:
	.string	"multiboot_info"
.LASF31:
	.string	"vbe_mode_info"
.LASF43:
	.string	"load_memory_map"
.LASF41:
	.string	"mboot_info"
.LASF51:
	.string	"value"
.LASF15:
	.string	"memory_high"
.LASF35:
	.string	"vbe_interface_len"
.LASF23:
	.string	"mmap_length"
.LASF11:
	.string	"uint64_t"
.LASF32:
	.string	"vbe_mode"
.LASF14:
	.string	"memory_low"
.LASF55:
	.string	"kernel_main.c"
.LASF56:
	.string	"/home/sankalps/Desktop/projects/os_projects/backupOS"
.LASF19:
	.string	"mods_addr"
.LASF12:
	.string	"long long unsigned int"
.LASF6:
	.string	"unsigned char"
.LASF26:
	.string	"drives_addr"
.LASF33:
	.string	"vbe_interface_seg"
.LASF20:
	.string	"syms0"
.LASF21:
	.string	"syms1"
.LASF22:
	.string	"syms2"
.LASF3:
	.string	"short unsigned int"
.LASF24:
	.string	"mmap_addr"
.LASF29:
	.string	"apm_table"
.LASF17:
	.string	"cmd_line"
.LASF37:
	.string	"mmap_entry"
.LASF47:
	.string	"main"
.LASF28:
	.string	"bootloader_name"
.LASF34:
	.string	"vbe_interface_off"
.LASF5:
	.string	"u8int"
.LASF38:
	.string	"base_address"
.LASF1:
	.string	"u32int"
.LASF0:
	.string	"unsigned int"
.LASF13:
	.string	"flags"
.LASF7:
	.string	"char"
.LASF46:
	.string	"load_system_memory_map"
.LASF42:
	.string	"total_memory"
.LASF30:
	.string	"vbe_control_info"
.LASF10:
	.string	"long long int"
.LASF54:
	.string	"GNU C 4.4.3"
.LASF18:
	.string	"mods_count"
.LASF52:
	.string	"largest_contigous_base"
.LASF45:
	.string	"m_entry"
.LASF50:
	.string	"port"
.LASF40:
	.string	"type"
.LASF4:
	.string	"short int"
.LASF25:
	.string	"drives_length"
.LASF53:
	.string	"largest_contigous_length"
.LASF49:
	.string	"outb"
.LASF16:
	.string	"boot_device"
.LASF9:
	.string	"uint32_t"
.LASF8:
	.string	"signed char"
.LASF2:
	.string	"u16int"
.LASF44:
	.string	"verify_multiboot_header"
.LASF39:
	.string	"length"
.LASF48:
	.string	"ptr2"
.LASF27:
	.string	"config_table"
	.ident	"GCC: (Ubuntu 4.4.3-4ubuntu5.1) 4.4.3"
	.section	.note.GNU-stack,"",@progbits
