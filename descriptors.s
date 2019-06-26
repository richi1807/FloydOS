	.file	"descriptors.c"
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.comm	gdt_entries,45,4
	.comm	gdt_ptr,6,4
	.comm	idt_entries,2048,4
	.comm	idt_ptr,6,4
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Unhandled exception triggered"
	.text
	.type	idt_general_func, @function
idt_general_func:
.LFB3:
	.file 1 "descriptors.c"
	.loc 1 56 0
	.cfi_startproc
	pushl	%ebp
.LCFI0:
	.cfi_def_cfa_offset 8
	movl	%esp, %ebp
	.cfi_offset 5, -8
.LCFI1:
	.cfi_def_cfa_register 5
	subl	$20, %esp
	.loc 1 57 0
	pushl	$.LC0
	.cfi_escape 0x2e,0x10
	call	monitor_write
	addl	$16, %esp
.L2:
	jmp	.L2
	.cfi_endproc
.LFE3:
	.size	idt_general_func, .-idt_general_func
.globl init_descriptor_tables
	.type	init_descriptor_tables, @function
init_descriptor_tables:
.LFB5:
	.loc 1 76 0
	.cfi_startproc
	pushl	%ebp
.LCFI2:
	.cfi_def_cfa_offset 8
	movl	%esp, %ebp
	.cfi_offset 5, -8
.LCFI3:
	.cfi_def_cfa_register 5
	subl	$20, %esp
.LBB30:
.LBB31:
	.loc 1 27 0
	movl	$gdt_entries, gdt_ptr+2
	.loc 1 28 0
	movw	$44, gdt_ptr
.LBB32:
.LBB33:
	.loc 1 42 0
	movw	$0, gdt_entries+2
	.loc 1 43 0
	movb	$0, gdt_entries+4
	.loc 1 44 0
	movw	$0, gdt_entries+7
	.loc 1 46 0
	movw	$0, gdt_entries
	.loc 1 49 0
	movb	$0, gdt_entries+6
	.loc 1 50 0
	movb	$0, gdt_entries+5
.LBE33:
.LBE32:
.LBB34:
.LBB35:
	.loc 1 42 0
	movw	$0, gdt_entries+11
	.loc 1 43 0
	movb	$0, gdt_entries+13
	.loc 1 44 0
	movw	$0, gdt_entries+16
	.loc 1 46 0
	movw	$-1, gdt_entries+9
	.loc 1 49 0
	movb	$-49, gdt_entries+15
	.loc 1 50 0
	movb	$-102, gdt_entries+14
.LBE35:
.LBE34:
.LBB36:
.LBB37:
	.loc 1 42 0
	movw	$0, gdt_entries+20
	.loc 1 43 0
	movb	$0, gdt_entries+22
	.loc 1 44 0
	movw	$0, gdt_entries+25
	.loc 1 46 0
	movw	$-1, gdt_entries+18
	.loc 1 49 0
	movb	$-49, gdt_entries+24
	.loc 1 50 0
	movb	$-110, gdt_entries+23
.LBE37:
.LBE36:
.LBB38:
.LBB39:
	.loc 1 42 0
	movw	$0, gdt_entries+29
	.loc 1 43 0
	movb	$0, gdt_entries+31
	.loc 1 44 0
	movw	$0, gdt_entries+34
	.loc 1 46 0
	movw	$-1, gdt_entries+27
	.loc 1 49 0
	movb	$-49, gdt_entries+33
	.loc 1 50 0
	movb	$-6, gdt_entries+32
.LBE39:
.LBE38:
.LBB40:
.LBB41:
	.loc 1 42 0
	movw	$0, gdt_entries+38
	.loc 1 43 0
	movb	$0, gdt_entries+40
	.loc 1 44 0
	movw	$0, gdt_entries+43
	.loc 1 46 0
	movw	$-1, gdt_entries+36
	.loc 1 49 0
	movb	$-49, gdt_entries+42
	.loc 1 50 0
	movb	$-14, gdt_entries+41
.LBE41:
.LBE40:
	.loc 1 36 0
	pushl	$gdt_ptr
	.cfi_escape 0x2e,0x10
	call	gdt_flush
.LBE31:
.LBE30:
.LBB42:
.LBB43:
	.loc 1 67 0
	movl	$idt_general_func, %ecx
	xorl	%eax, %eax
.LVL0:
	shrl	$16, %ecx
	addl	$16, %esp
.LBB44:
.LBB45:
	.loc 1 17 0
	movl	$idt_general_func, %edx
.L6:
	movw	%dx, idt_entries(,%eax,8)
	.loc 1 18 0
	movw	%cx, idt_entries+6(,%eax,8)
	.loc 1 19 0
	movb	$0, idt_entries+4(,%eax,8)
	.loc 1 21 0
	movb	$-114, idt_entries+5(,%eax,8)
	.loc 1 22 0
	movw	$8, idt_entries+2(,%eax,8)
.LBE45:
.LBE44:
	.loc 1 65 0
	incl	%eax
	cmpl	$256, %eax
	jne	.L6
	.loc 1 72 0
	subl	$12, %esp
	pushl	$idt_ptr
	.loc 1 70 0
	movl	$idt_entries, idt_ptr+2
	.loc 1 71 0
	movw	$2047, idt_ptr
	.loc 1 72 0
	call	idt_flush
.LVL1:
	addl	$16, %esp
.LBE43:
.LBE42:
	.loc 1 80 0
	leave
	ret
	.cfi_endproc
.LFE5:
	.size	init_descriptor_tables, .-init_descriptor_tables
.Letext0:
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST0:
	.long	.LFB3-.Ltext0
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
	.long	.LFE3-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST1:
	.long	.LFB5-.Ltext0
	.long	.LCFI2-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI2-.Ltext0
	.long	.LCFI3-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI3-.Ltext0
	.long	.LFE5-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST2:
	.long	.LVL0-.Ltext0
	.long	.LVL1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0x0
	.long	0x0
	.file 2 "common.h"
	.file 3 "descriptors.h"
	.section	.debug_info
	.long	0x430
	.value	0x2
	.long	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.long	.LASF38
	.byte	0x1
	.long	.LASF39
	.long	.LASF40
	.long	.Ltext0
	.long	.Letext0
	.long	.Ldebug_line0
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.long	.LASF0
	.uleb128 0x3
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.long	.LASF1
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.long	.LASF2
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.long	.LASF3
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF4
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF5
	.uleb128 0x4
	.long	.LASF6
	.byte	0x2
	.byte	0x4
	.long	0x41
	.uleb128 0x4
	.long	.LASF7
	.byte	0x2
	.byte	0x6
	.long	0x33
	.uleb128 0x4
	.long	.LASF8
	.byte	0x2
	.byte	0x8
	.long	0x25
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.long	.LASF9
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.long	.LASF10
	.uleb128 0x5
	.long	.LASF17
	.byte	0x8
	.byte	0x3
	.byte	0x8
	.long	0xd8
	.uleb128 0x6
	.long	.LASF11
	.byte	0x3
	.byte	0x9
	.long	0x61
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x6
	.long	.LASF12
	.byte	0x3
	.byte	0xa
	.long	0x61
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0x6
	.long	.LASF13
	.byte	0x3
	.byte	0xb
	.long	0x56
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x6
	.long	.LASF14
	.byte	0x3
	.byte	0xc
	.long	0x56
	.byte	0x2
	.byte	0x23
	.uleb128 0x5
	.uleb128 0x6
	.long	.LASF15
	.byte	0x3
	.byte	0xd
	.long	0x61
	.byte	0x2
	.byte	0x23
	.uleb128 0x6
	.byte	0x0
	.uleb128 0x4
	.long	.LASF16
	.byte	0x3
	.byte	0xf
	.long	0x85
	.uleb128 0x5
	.long	.LASF18
	.byte	0x6
	.byte	0x3
	.byte	0x12
	.long	0x10c
	.uleb128 0x6
	.long	.LASF19
	.byte	0x3
	.byte	0x13
	.long	0x61
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x6
	.long	.LASF20
	.byte	0x3
	.byte	0x14
	.long	0x6c
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.byte	0x0
	.uleb128 0x4
	.long	.LASF21
	.byte	0x3
	.byte	0x16
	.long	0xe3
	.uleb128 0x5
	.long	.LASF22
	.byte	0x9
	.byte	0x3
	.byte	0x18
	.long	0x178
	.uleb128 0x6
	.long	.LASF23
	.byte	0x3
	.byte	0x1a
	.long	0x61
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x6
	.long	.LASF24
	.byte	0x3
	.byte	0x1c
	.long	0x61
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0x6
	.long	.LASF25
	.byte	0x3
	.byte	0x1d
	.long	0x56
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x6
	.long	.LASF26
	.byte	0x3
	.byte	0x1f
	.long	0x56
	.byte	0x2
	.byte	0x23
	.uleb128 0x5
	.uleb128 0x6
	.long	.LASF27
	.byte	0x3
	.byte	0x20
	.long	0x56
	.byte	0x2
	.byte	0x23
	.uleb128 0x6
	.uleb128 0x6
	.long	.LASF28
	.byte	0x3
	.byte	0x22
	.long	0x61
	.byte	0x2
	.byte	0x23
	.uleb128 0x7
	.byte	0x0
	.uleb128 0x4
	.long	.LASF29
	.byte	0x3
	.byte	0x24
	.long	0x117
	.uleb128 0x5
	.long	.LASF30
	.byte	0x6
	.byte	0x3
	.byte	0x27
	.long	0x1ac
	.uleb128 0x6
	.long	.LASF19
	.byte	0x3
	.byte	0x28
	.long	0x61
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x6
	.long	.LASF20
	.byte	0x3
	.byte	0x29
	.long	0x6c
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.byte	0x0
	.uleb128 0x4
	.long	.LASF31
	.byte	0x3
	.byte	0x2c
	.long	0x183
	.uleb128 0x7
	.long	.LASF32
	.byte	0x1
	.byte	0x28
	.byte	0x1
	.byte	0x1
	.long	0x1fc
	.uleb128 0x8
	.string	"num"
	.byte	0x1
	.byte	0x28
	.long	0x6c
	.uleb128 0x9
	.long	.LASF20
	.byte	0x1
	.byte	0x28
	.long	0x6c
	.uleb128 0x9
	.long	.LASF19
	.byte	0x1
	.byte	0x28
	.long	0x6c
	.uleb128 0x9
	.long	.LASF26
	.byte	0x1
	.byte	0x28
	.long	0x56
	.uleb128 0x9
	.long	.LASF27
	.byte	0x1
	.byte	0x28
	.long	0x56
	.byte	0x0
	.uleb128 0x7
	.long	.LASF33
	.byte	0x1
	.byte	0xf
	.byte	0x1
	.byte	0x1
	.long	0x241
	.uleb128 0x8
	.string	"num"
	.byte	0x1
	.byte	0xf
	.long	0x6c
	.uleb128 0x9
	.long	.LASF11
	.byte	0x1
	.byte	0xf
	.long	0x61
	.uleb128 0x8
	.string	"sel"
	.byte	0x1
	.byte	0xf
	.long	0x61
	.uleb128 0x9
	.long	.LASF15
	.byte	0x1
	.byte	0xf
	.long	0x61
	.uleb128 0x9
	.long	.LASF14
	.byte	0x1
	.byte	0xf
	.long	0x56
	.byte	0x0
	.uleb128 0xa
	.long	.LASF41
	.byte	0x1
	.byte	0x19
	.byte	0x1
	.uleb128 0xb
	.long	.LASF42
	.byte	0x1
	.byte	0x3d
	.byte	0x1
	.long	0x25f
	.uleb128 0xc
	.string	"i"
	.byte	0x1
	.byte	0x40
	.long	0x2c
	.byte	0x0
	.uleb128 0xd
	.long	.LASF43
	.byte	0x1
	.byte	0x37
	.long	.LFB3
	.long	.LFE3
	.long	.LLST0
	.uleb128 0xe
	.byte	0x1
	.long	.LASF44
	.byte	0x1
	.byte	0x4b
	.long	.LFB5
	.long	.LFE5
	.long	.LLST1
	.long	0x3c8
	.uleb128 0xf
	.long	0x241
	.long	.LBB30
	.long	.LBE30
	.byte	0x1
	.byte	0x4d
	.long	0x37b
	.uleb128 0xf
	.long	0x1b7
	.long	.LBB32
	.long	.LBE32
	.byte	0x1
	.byte	0x1f
	.long	0x2ca
	.uleb128 0x10
	.long	0x1f0
	.uleb128 0x10
	.long	0x1e5
	.uleb128 0x10
	.long	0x1da
	.uleb128 0x10
	.long	0x1cf
	.uleb128 0x10
	.long	0x1c4
	.byte	0x0
	.uleb128 0xf
	.long	0x1b7
	.long	.LBB34
	.long	.LBE34
	.byte	0x1
	.byte	0x20
	.long	0x2f7
	.uleb128 0x10
	.long	0x1f0
	.uleb128 0x10
	.long	0x1e5
	.uleb128 0x10
	.long	0x1da
	.uleb128 0x10
	.long	0x1cf
	.uleb128 0x10
	.long	0x1c4
	.byte	0x0
	.uleb128 0xf
	.long	0x1b7
	.long	.LBB36
	.long	.LBE36
	.byte	0x1
	.byte	0x21
	.long	0x324
	.uleb128 0x10
	.long	0x1f0
	.uleb128 0x10
	.long	0x1e5
	.uleb128 0x10
	.long	0x1da
	.uleb128 0x10
	.long	0x1cf
	.uleb128 0x10
	.long	0x1c4
	.byte	0x0
	.uleb128 0xf
	.long	0x1b7
	.long	.LBB38
	.long	.LBE38
	.byte	0x1
	.byte	0x22
	.long	0x351
	.uleb128 0x10
	.long	0x1f0
	.uleb128 0x10
	.long	0x1e5
	.uleb128 0x10
	.long	0x1da
	.uleb128 0x10
	.long	0x1cf
	.uleb128 0x10
	.long	0x1c4
	.byte	0x0
	.uleb128 0x11
	.long	0x1b7
	.long	.LBB40
	.long	.LBE40
	.byte	0x1
	.byte	0x23
	.uleb128 0x10
	.long	0x1f0
	.uleb128 0x10
	.long	0x1da
	.uleb128 0x10
	.long	0x1e5
	.uleb128 0x10
	.long	0x1cf
	.uleb128 0x10
	.long	0x1c4
	.byte	0x0
	.byte	0x0
	.uleb128 0x11
	.long	0x249
	.long	.LBB42
	.long	.LBE42
	.byte	0x1
	.byte	0x4e
	.uleb128 0x12
	.long	.LBB43
	.long	.LBE43
	.uleb128 0x13
	.long	0x255
	.long	.LLST2
	.uleb128 0x11
	.long	0x1fc
	.long	.LBB44
	.long	.LBE44
	.byte	0x1
	.byte	0x43
	.uleb128 0x10
	.long	0x235
	.uleb128 0x10
	.long	0x22a
	.uleb128 0x10
	.long	0x214
	.uleb128 0x10
	.long	0x209
	.uleb128 0x10
	.long	0x21f
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.uleb128 0x14
	.long	0x178
	.long	0x3d8
	.uleb128 0x15
	.long	0x3d8
	.byte	0x4
	.byte	0x0
	.uleb128 0x16
	.byte	0x4
	.byte	0x7
	.uleb128 0x17
	.long	.LASF34
	.byte	0x1
	.byte	0x4
	.long	0x3c8
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	gdt_entries
	.uleb128 0x17
	.long	.LASF35
	.byte	0x1
	.byte	0x5
	.long	0x1ac
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	gdt_ptr
	.uleb128 0x14
	.long	0xd8
	.long	0x40f
	.uleb128 0x15
	.long	0x3d8
	.byte	0xff
	.byte	0x0
	.uleb128 0x17
	.long	.LASF36
	.byte	0x1
	.byte	0x6
	.long	0x3ff
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	idt_entries
	.uleb128 0x17
	.long	.LASF37
	.byte	0x1
	.byte	0x7
	.long	0x10c
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	idt_ptr
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
	.uleb128 0xb
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
	.uleb128 0x8
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
	.uleb128 0x9
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
	.byte	0x0
	.byte	0x0
	.uleb128 0xa
	.uleb128 0x2e
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x20
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0xb
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
	.uleb128 0xc
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
	.uleb128 0xd
	.uleb128 0x2e
	.byte	0x0
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
	.byte	0x0
	.byte	0x0
	.uleb128 0xe
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
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x11
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
	.uleb128 0x12
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.byte	0x0
	.byte	0x0
	.uleb128 0x13
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0x0
	.byte	0x0
	.uleb128 0x14
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x15
	.uleb128 0x21
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x16
	.uleb128 0x24
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x17
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
	.long	0x61
	.value	0x2
	.long	.Ldebug_info0
	.long	0x434
	.long	0x272
	.string	"init_descriptor_tables"
	.long	0x3db
	.string	"gdt_entries"
	.long	0x3ed
	.string	"gdt_ptr"
	.long	0x40f
	.string	"idt_entries"
	.long	0x421
	.string	"idt_ptr"
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
.LASF42:
	.string	"init_idt"
.LASF15:
	.string	"offset_high"
.LASF33:
	.string	"idt_set_gate"
.LASF17:
	.string	"idt_entry"
.LASF16:
	.string	"idt_entry_t"
.LASF32:
	.string	"gdt_set_gate"
.LASF25:
	.string	"base_middle"
.LASF12:
	.string	"selector"
.LASF40:
	.string	"/home/sankalps/Desktop/projects/os_projects/backupOS"
.LASF26:
	.string	"access"
.LASF13:
	.string	"zero"
.LASF10:
	.string	"long long unsigned int"
.LASF27:
	.string	"granularity"
.LASF3:
	.string	"unsigned char"
.LASF34:
	.string	"gdt_entries"
.LASF43:
	.string	"idt_general_func"
.LASF21:
	.string	"idt_ptr_t"
.LASF20:
	.string	"base"
.LASF1:
	.string	"short unsigned int"
.LASF41:
	.string	"init_gdt"
.LASF37:
	.string	"idt_ptr"
.LASF35:
	.string	"gdt_ptr"
.LASF22:
	.string	"gdt_desc"
.LASF28:
	.string	"base_high"
.LASF31:
	.string	"gdt_ptr_t"
.LASF0:
	.string	"unsigned int"
.LASF14:
	.string	"flags"
.LASF4:
	.string	"char"
.LASF6:
	.string	"uint8_t"
.LASF19:
	.string	"limit"
.LASF24:
	.string	"base_low"
.LASF44:
	.string	"init_descriptor_tables"
.LASF11:
	.string	"offset_low"
.LASF29:
	.string	"gdt_entry_t"
.LASF9:
	.string	"long long int"
.LASF38:
	.string	"GNU C 4.4.3"
.LASF36:
	.string	"idt_entries"
.LASF2:
	.string	"short int"
.LASF7:
	.string	"uint16_t"
.LASF8:
	.string	"uint32_t"
.LASF30:
	.string	"gdt_ptr_struct"
.LASF5:
	.string	"signed char"
.LASF18:
	.string	"idt_ptr_struct"
.LASF39:
	.string	"descriptors.c"
.LASF23:
	.string	"limit_low"
	.ident	"GCC: (Ubuntu 4.4.3-4ubuntu5.1) 4.4.3"
	.section	.note.GNU-stack,"",@progbits
