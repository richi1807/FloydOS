	.file	"paging.c"
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.comm	pg_tbl,4096,4
	.comm	pg_dir,4096,4
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"in here"
.LC1:
	.string	"paging table initializing\n"
.LC2:
	.string	"paging table initialized\n"
.LC3:
	.string	"paging directory initialized\n"
.LC4:
	.string	"writing cr3 register\n"
.LC5:
	.string	"writing cr0 register\n"
.LC6:
	.string	"Paging is enabled now\n"
	.text
.globl init_paging
	.type	init_paging, @function
init_paging:
.LFB2:
	.file 1 "paging.c"
	.loc 1 44 0
	.cfi_startproc
	pushl	%ebp
.LCFI0:
	.cfi_def_cfa_offset 8
	movl	%esp, %ebp
	.cfi_offset 5, -8
.LCFI1:
	.cfi_def_cfa_register 5
	subl	$36, %esp
	.loc 1 45 0
	pushl	$.LC0
	.cfi_escape 0x2e,0x10
	call	monitor_write
.LBB6:
.LBB7:
	.loc 1 15 0
	movl	$.LC1, (%esp)
	call	monitor_write
	xorl	%edx, %edx
.LVL0:
	xorl	%eax, %eax
.LVL1:
	addl	$16, %esp
.L2:
	.loc 1 20 0
	movl	%eax, %ecx
	.loc 1 21 0
	addl	$4096, %eax
	.loc 1 20 0
	orl	$3, %ecx
	movl	%ecx, pg_tbl(,%edx,4)
	.loc 1 18 0
	incl	%edx
	cmpl	$4194304, %eax
	jne	.L2
	.loc 1 23 0
	subl	$12, %esp
	pushl	$.LC2
	call	monitor_write
.LVL2:
.LBE7:
.LBE6:
.LBB8:
.LBB9:
	.loc 1 31 0
	movl	$pg_dir, %eax
	.loc 1 35 0
	addl	$16, %esp
	orl	$3, %eax
	movl	%eax, pg_dir
	movl	$1, %eax
.LVL3:
.L3:
	.loc 1 38 0
	movl	$3, pg_dir(,%eax,4)
	.loc 1 36 0
	incl	%eax
	cmpl	$1024, %eax
	jne	.L3
	.loc 1 40 0
	subl	$12, %esp
	pushl	$.LC3
	call	monitor_write
.LVL4:
.LBE9:
.LBE8:
	.loc 1 50 0
	movl	$.LC4, (%esp)
	call	monitor_write
	.loc 1 51 0
	movl	$pg_dir, (%esp)
	call	write_cr3
	.loc 1 52 0
	.cfi_escape 0x2e,0x0
	call	read_cr0
	.loc 1 53 0
	movl	$.LC5, (%esp)
	movl	%eax, -12(%ebp)
	.cfi_escape 0x2e,0x10
	call	monitor_write
	.loc 1 54 0
	movl	-12(%ebp), %eax
	orl	$-2147483648, %eax
.LVL5:
	movl	%eax, (%esp)
	call	write_cr0
	.loc 1 55 0
	movl	$.LC6, (%esp)
	call	monitor_write
	addl	$16, %esp
	.loc 1 57 0
	leave
	ret
	.cfi_endproc
.LFE2:
	.size	init_paging, .-init_paging
.Letext0:
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST0:
	.long	.LFB2-.Ltext0
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
	.long	.LFE2-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST1:
	.long	.LVL0-.Ltext0
	.long	.LVL2-.Ltext0
	.value	0x1
	.byte	0x52
	.long	0x0
	.long	0x0
.LLST2:
	.long	.LVL1-.Ltext0
	.long	.LVL2-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0x0
	.long	0x0
.LLST3:
	.long	.LVL3-.Ltext0
	.long	.LVL4-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0x0
	.long	0x0
	.file 2 "common.h"
	.file 3 "paging.h"
	.section	.debug_info
	.long	0x1c3
	.value	0x2
	.long	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.long	.LASF19
	.byte	0x1
	.long	.LASF20
	.long	.LASF21
	.long	.Ltext0
	.long	.Letext0
	.long	.Ldebug_line0
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF0
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.long	.LASF1
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.long	.LASF2
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.long	.LASF3
	.uleb128 0x3
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x4
	.long	.LASF7
	.byte	0x2
	.byte	0x8
	.long	0x53
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.long	.LASF4
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.long	.LASF5
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.long	.LASF6
	.uleb128 0x4
	.long	.LASF8
	.byte	0x3
	.byte	0xa
	.long	0x48
	.uleb128 0x5
	.long	.LASF10
	.value	0x1000
	.byte	0x3
	.byte	0x13
	.long	0x8f
	.uleb128 0x6
	.long	.LASF12
	.byte	0x3
	.byte	0x14
	.long	0x8f
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.byte	0x0
	.uleb128 0x7
	.long	0x68
	.long	0xa0
	.uleb128 0x8
	.long	0xa0
	.value	0x3ff
	.byte	0x0
	.uleb128 0x9
	.byte	0x4
	.byte	0x7
	.uleb128 0x4
	.long	.LASF9
	.byte	0x3
	.byte	0x16
	.long	0x48
	.uleb128 0x5
	.long	.LASF11
	.value	0x1000
	.byte	0x3
	.byte	0x18
	.long	0xca
	.uleb128 0x6
	.long	.LASF12
	.byte	0x3
	.byte	0x19
	.long	0xca
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.byte	0x0
	.uleb128 0x7
	.long	0xa3
	.long	0xdb
	.uleb128 0x8
	.long	0xa0
	.value	0x3ff
	.byte	0x0
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF13
	.uleb128 0xa
	.long	.LASF15
	.byte	0x1
	.byte	0xc
	.byte	0x1
	.long	0x103
	.uleb128 0xb
	.string	"i"
	.byte	0x1
	.byte	0x10
	.long	0x41
	.uleb128 0xc
	.long	.LASF14
	.byte	0x1
	.byte	0x11
	.long	0x48
	.byte	0x0
	.uleb128 0xa
	.long	.LASF16
	.byte	0x1
	.byte	0x1b
	.byte	0x1
	.long	0x124
	.uleb128 0xb
	.string	"i"
	.byte	0x1
	.byte	0x1e
	.long	0x41
	.uleb128 0xc
	.long	.LASF14
	.byte	0x1
	.byte	0x1f
	.long	0x48
	.byte	0x0
	.uleb128 0xd
	.byte	0x1
	.long	.LASF22
	.byte	0x1
	.byte	0x2b
	.long	.LFB2
	.long	.LFE2
	.long	.LLST0
	.long	0x1a2
	.uleb128 0xe
	.string	"loc"
	.byte	0x1
	.byte	0x34
	.long	0x48
	.byte	0x1
	.byte	0x50
	.uleb128 0xf
	.long	0xe2
	.long	.LBB6
	.long	.LBE6
	.byte	0x1
	.byte	0x2e
	.long	0x179
	.uleb128 0x10
	.long	.LBB7
	.long	.LBE7
	.uleb128 0x11
	.long	0xee
	.long	.LLST1
	.uleb128 0x11
	.long	0xf7
	.long	.LLST2
	.byte	0x0
	.byte	0x0
	.uleb128 0x12
	.long	0x103
	.long	.LBB8
	.long	.LBE8
	.byte	0x1
	.byte	0x2f
	.uleb128 0x10
	.long	.LBB9
	.long	.LBE9
	.uleb128 0x11
	.long	0x10f
	.long	.LLST3
	.uleb128 0x13
	.long	0x118
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.uleb128 0x14
	.long	.LASF17
	.byte	0x1
	.byte	0x8
	.long	0x73
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	pg_tbl
	.uleb128 0x14
	.long	.LASF18
	.byte	0x1
	.byte	0x9
	.long	0xae
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	pg_dir
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
	.uleb128 0x3
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
	.uleb128 0x4
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
	.uleb128 0x5
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0x5
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x6
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
	.uleb128 0x7
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x8
	.uleb128 0x21
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0x5
	.byte	0x0
	.byte	0x0
	.uleb128 0x9
	.uleb128 0x24
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0xa
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xb
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
	.byte	0x0
	.byte	0x0
	.uleb128 0xc
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
	.uleb128 0xd
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
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0xf
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
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x10
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.byte	0x0
	.byte	0x0
	.uleb128 0x11
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x31
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
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x14
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
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.section	.debug_pubnames,"",@progbits
	.long	0x34
	.value	0x2
	.long	.Ldebug_info0
	.long	0x1c7
	.long	0x124
	.string	"init_paging"
	.long	0x1a2
	.string	"pg_tbl"
	.long	0x1b4
	.string	"pg_dir"
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
.LASF5:
	.string	"long long int"
.LASF4:
	.string	"unsigned int"
.LASF1:
	.string	"unsigned char"
.LASF22:
	.string	"init_paging"
.LASF14:
	.string	"address"
.LASF20:
	.string	"paging.c"
.LASF10:
	.string	"page_table"
.LASF6:
	.string	"long long unsigned int"
.LASF19:
	.string	"GNU C 4.4.3"
.LASF11:
	.string	"page_directory"
.LASF7:
	.string	"uint32_t"
.LASF12:
	.string	"m_entry"
.LASF21:
	.string	"/home/sankalps/Desktop/projects/os_projects/backupOS"
.LASF16:
	.string	"init_paging_directory"
.LASF15:
	.string	"init_paging_tables"
.LASF3:
	.string	"short unsigned int"
.LASF0:
	.string	"signed char"
.LASF8:
	.string	"pt_entry"
.LASF9:
	.string	"pd_entry"
.LASF18:
	.string	"pg_dir"
.LASF17:
	.string	"pg_tbl"
.LASF2:
	.string	"short int"
.LASF13:
	.string	"char"
	.ident	"GCC: (Ubuntu 4.4.3-4ubuntu5.1) 4.4.3"
	.section	.note.GNU-stack,"",@progbits
