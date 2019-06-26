	.file	"pic.c"
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.type	pic_send_data, @function
pic_send_data:
.LFB1:
	.file 1 "pic.c"
	.loc 1 36 0
	.cfi_startproc
.LVL0:
	pushl	%ebp
.LCFI0:
	.cfi_def_cfa_offset 8
	movl	%esp, %ebp
	.cfi_offset 5, -8
.LCFI1:
	.cfi_def_cfa_register 5
	subl	$8, %esp
	.loc 1 37 0
	decb	%al
.LVL1:
	jne	.L2
	.loc 1 39 0
	pushl	%ecx
	movzbl	%dl, %edx
.LVL2:
	pushl	%ecx
	pushl	%edx
	pushl	$33
	jmp	.L5
.L2:
	.loc 1 43 0
	pushl	%eax
	movzbl	%dl, %edx
.LVL3:
	pushl	%eax
	pushl	%edx
	pushl	$161
.L5:
	.cfi_escape 0x2e,0x10
	call	outb
.LVL4:
	addl	$16, %esp
	.loc 1 46 0
	leave
	ret
	.cfi_endproc
.LFE1:
	.size	pic_send_data, .-pic_send_data
.globl init_pic
	.type	init_pic, @function
init_pic:
.LFB2:
	.loc 1 51 0
	.cfi_startproc
	pushl	%ebp
.LCFI2:
	.cfi_def_cfa_offset 8
	.loc 1 57 0
	movl	$1, %eax
	.loc 1 51 0
	movl	%esp, %ebp
	.cfi_offset 5, -8
.LCFI3:
	.cfi_def_cfa_register 5
	subl	$8, %esp
	.loc 1 57 0
	call	T.3
	.loc 1 58 0
	movl	$2, %eax
	call	T.3
	.loc 1 63 0
	movl	$32, %edx
	movl	$1, %eax
	call	pic_send_data
	.loc 1 66 0
	movl	$40, %edx
	movl	$2, %eax
	call	pic_send_data
	.loc 1 71 0
	movl	$4, %edx
	movl	$1, %eax
	call	pic_send_data
	.loc 1 74 0
	movl	$6, %edx
	movl	$2, %eax
	call	pic_send_data
	.loc 1 79 0
	movl	$1, %edx
	movl	$1, %eax
	call	pic_send_data
	.loc 1 80 0
	movl	$1, %edx
	movl	$2, %eax
	call	pic_send_data
	.loc 1 83 0
	xorl	%edx, %edx
	movl	$1, %eax
	call	pic_send_data
	.loc 1 84 0
	xorl	%edx, %edx
	movl	$2, %eax
	.loc 1 87 0
	leave
	.loc 1 84 0
	jmp	pic_send_data
	.cfi_endproc
.LFE2:
	.size	init_pic, .-init_pic
	.type	T.3, @function
T.3:
.LFB3:
	.loc 1 6 0
	.cfi_startproc
.LVL5:
	pushl	%ebp
.LCFI4:
	.cfi_def_cfa_offset 8
	movl	%esp, %ebp
	.cfi_offset 5, -8
.LCFI5:
	.cfi_def_cfa_register 5
	subl	$16, %esp
	.loc 1 14 0
	pushl	$19
	pushl	$32
	.cfi_escape 0x2e,0x10
	call	outb
.LVL6:
	addl	$16, %esp
	.loc 1 17 0
	leave
	ret
	.cfi_endproc
.LFE3:
	.size	T.3, .-T.3
.Letext0:
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST0:
	.long	.LFB1-.Ltext0
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
	.long	.LFE1-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST1:
	.long	.LVL0-.Ltext0
	.long	.LVL1-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0x0
	.long	0x0
.LLST2:
	.long	.LVL0-.Ltext0
	.long	.LVL4-.Ltext0
	.value	0x1
	.byte	0x52
	.long	0x0
	.long	0x0
.LLST3:
	.long	.LFB2-.Ltext0
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
	.long	.LFE2-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST4:
	.long	.LFB3-.Ltext0
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
	.long	.LFE3-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST5:
	.long	.LVL5-.Ltext0
	.long	.LVL6-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0x0
	.long	0x0
	.file 2 "common.h"
	.section	.debug_info
	.long	0x116
	.value	0x2
	.long	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.long	.LASF11
	.byte	0x1
	.long	.LASF12
	.long	.LASF13
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
	.uleb128 0x4
	.long	.LASF6
	.byte	0x2
	.byte	0x3
	.long	0x5a
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF5
	.uleb128 0x4
	.long	.LASF7
	.byte	0x2
	.byte	0x4
	.long	0x41
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.long	.LASF8
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.long	.LASF9
	.uleb128 0x5
	.long	.LASF14
	.byte	0x1
	.byte	0x6
	.byte	0x1
	.byte	0x1
	.long	0x9e
	.uleb128 0x6
	.string	"pic"
	.byte	0x1
	.byte	0x6
	.long	0x4f
	.uleb128 0x6
	.string	"cmd"
	.byte	0x1
	.byte	0x6
	.long	0x4f
	.byte	0x0
	.uleb128 0x7
	.long	.LASF15
	.byte	0x1
	.byte	0x23
	.byte	0x1
	.long	.LFB1
	.long	.LFE1
	.long	.LLST0
	.long	0xd5
	.uleb128 0x8
	.string	"pic"
	.byte	0x1
	.byte	0x23
	.long	0x4f
	.long	.LLST1
	.uleb128 0x9
	.long	.LASF10
	.byte	0x1
	.byte	0x23
	.long	0x4f
	.long	.LLST2
	.byte	0x0
	.uleb128 0xa
	.byte	0x1
	.long	.LASF16
	.byte	0x1
	.byte	0x32
	.long	.LFB2
	.long	.LFE2
	.long	.LLST3
	.long	0xf9
	.uleb128 0xb
	.string	"icw"
	.byte	0x1
	.byte	0x37
	.long	0x61
	.byte	0x0
	.uleb128 0xc
	.long	0x7a
	.long	.LFB3
	.long	.LFE3
	.long	.LLST4
	.uleb128 0xd
	.long	0x87
	.long	.LLST5
	.uleb128 0xe
	.long	0x92
	.byte	0x0
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
	.uleb128 0x6
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
	.uleb128 0x2
	.uleb128 0x6
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
	.uleb128 0x2
	.uleb128 0x6
	.byte	0x0
	.byte	0x0
	.uleb128 0xa
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
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.byte	0x0
	.byte	0x0
	.uleb128 0xd
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0x0
	.byte	0x0
	.uleb128 0xe
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.section	.debug_pubnames,"",@progbits
	.long	0x1b
	.value	0x2
	.long	.Ldebug_info0
	.long	0x11a
	.long	0xd5
	.string	"init_pic"
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
.LASF8:
	.string	"long long int"
.LASF14:
	.string	"pic_send_command"
.LASF0:
	.string	"unsigned int"
.LASF3:
	.string	"unsigned char"
.LASF12:
	.string	"pic.c"
.LASF9:
	.string	"long long unsigned int"
.LASF10:
	.string	"data"
.LASF16:
	.string	"init_pic"
.LASF7:
	.string	"uint8_t"
.LASF11:
	.string	"GNU C 4.4.3"
.LASF4:
	.string	"char"
.LASF6:
	.string	"int8_t"
.LASF13:
	.string	"/home/sankalps/Desktop/projects/os_projects/backupOS"
.LASF15:
	.string	"pic_send_data"
.LASF1:
	.string	"short unsigned int"
.LASF5:
	.string	"signed char"
.LASF2:
	.string	"short int"
	.ident	"GCC: (Ubuntu 4.4.3-4ubuntu5.1) 4.4.3"
	.section	.note.GNU-stack,"",@progbits
