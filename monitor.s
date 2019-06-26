	.file	"monitor.c"
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.text
.Ltext0:
	.cfi_sections	.debug_frame
.globl vidmem
	.data
	.align 4
	.type	vidmem, @object
	.size	vidmem, 4
vidmem:
	.long	753664
.globl cursor_x
	.bss
	.type	cursor_x, @object
	.size	cursor_x, 1
cursor_x:
	.zero	1
.globl cursor_y
	.type	cursor_y, @object
	.size	cursor_y, 1
cursor_y:
	.zero	1
	.text
	.type	move_cursor, @function
move_cursor:
.LFB0:
	.file 1 "monitor.c"
	.loc 1 11 0
	.cfi_startproc
	pushl	%ebp
.LCFI0:
	.cfi_def_cfa_offset 8
	.loc 1 12 0
	movb	$80, %dl
	.loc 1 11 0
	movl	%esp, %ebp
	.cfi_offset 5, -8
.LCFI1:
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$12, %esp
	.loc 1 12 0
	movb	cursor_y, %al
	movzbl	cursor_x, %ecx
	.loc 1 13 0
	pushl	$14
	pushl	$980
	.loc 1 12 0
	mulb	%dl
	movl	%eax, %edx
	leal	(%edx,%ecx), %ebx
	.cfi_offset 3, -12
.LVL0:
	.loc 1 13 0
	.cfi_escape 0x2e,0x10
	call	outb
	.loc 1 14 0
	popl	%edx
	popl	%ecx
	pushl	$0
	pushl	$981
	call	outb
	.loc 1 15 0
	popl	%ecx
	popl	%eax
	pushl	$15
	pushl	$980
	call	outb
	.loc 1 16 0
	popl	%eax
	popl	%edx
	movzbl	%bl, %edx
.LVL1:
	pushl	%edx
	pushl	$981
	call	outb
.LVL2:
	addl	$16, %esp
	.loc 1 18 0
	movl	-4(%ebp), %ebx
	leave
	ret
	.cfi_endproc
.LFE0:
	.size	move_cursor, .-move_cursor
.globl monitor_put
	.type	monitor_put, @function
monitor_put:
.LFB2:
	.loc 1 40 0
	.cfi_startproc
.LVL3:
	pushl	%ebp
.LCFI2:
	.cfi_def_cfa_offset 8
	movl	%esp, %ebp
	.cfi_offset 5, -8
.LCFI3:
	.cfi_def_cfa_register 5
	subl	$8, %esp
	.loc 1 40 0
	movb	8(%ebp), %al
	.loc 1 45 0
	cmpb	$9, %al
	jne	.L4
.LVL4:
	.loc 1 47 0
	movb	cursor_x, %al
.LVL5:
	testb	%al, %al
	je	.L5
	.loc 1 48 0
	decl	%eax
	movb	%al, cursor_x
	jmp	.L5
.LVL6:
.L4:
	.loc 1 54 0
	cmpb	$13, %al
	jne	.L6
	.loc 1 56 0
	movb	$0, cursor_x
	jmp	.L5
.L6:
	.loc 1 58 0
	cmpb	$10, %al
	jne	.L7
	.loc 1 60 0
	movb	$0, cursor_x
	.loc 1 61 0
	incb	cursor_y
	jmp	.L5
.L7:
	.loc 1 63 0
	cmpb	$31, %al
	jle	.L5
	.loc 1 66 0
	movzbl	cursor_y, %ecx
	cbtw
.LVL7:
	movzbl	cursor_x, %edx
	orb	$15, %ah
	imull	$80, %ecx, %ecx
	addl	%edx, %ecx
	movl	vidmem, %edx
	movw	%ax, (%edx,%ecx,2)
	.loc 1 67 0
	incb	cursor_x
.LVL8:
.L5:
	.loc 1 69 0
	cmpb	$79, cursor_x
	jbe	.L8
	.loc 1 72 0
	incb	cursor_y
	.loc 1 71 0
	movb	$0, cursor_x
.L8:
.LBB5:
.LBB6:
	.loc 1 24 0
	cmpb	$24, cursor_y
	jbe	.L9
.LBB7:
	.loc 1 29 0
	movl	vidmem, %eax
	xorl	%edx, %edx
.L10:
	movw	160(%eax,%edx), %cx
	movw	%cx, (%eax,%edx)
	addl	$2, %edx
	.loc 1 27 0
	cmpl	$3840, %edx
	jne	.L10
	.loc 1 39 0
	leal	160(%eax), %edx
.L11:
	.loc 1 33 0
	movw	$3872, 3840(%eax)
	addl	$2, %eax
	.loc 1 31 0
	cmpl	%edx, %eax
	jne	.L11
	.loc 1 35 0
	movb	$25, cursor_y
.LVL9:
.L9:
.LBE7:
.LBE6:
.LBE5:
	.loc 1 76 0
	leave
	.loc 1 75 0
	jmp	move_cursor
	.cfi_endproc
.LFE2:
	.size	monitor_put, .-monitor_put
.globl monitor_clear
	.type	monitor_clear, @function
monitor_clear:
.LFB3:
	.loc 1 79 0
	.cfi_startproc
	pushl	%ebp
.LCFI4:
	.cfi_def_cfa_offset 8
	.loc 1 84 0
	xorl	%eax, %eax
.LVL10:
	.loc 1 79 0
	movl	%esp, %ebp
	.cfi_offset 5, -8
.LCFI5:
	.cfi_def_cfa_register 5
	subl	$8, %esp
	.loc 1 84 0
	movl	vidmem, %edx
.L17:
	movw	$3872, (%edx,%eax,2)
	.loc 1 83 0
	incl	%eax
	cmpl	$2000, %eax
	jne	.L17
	.loc 1 85 0
	movb	$0, cursor_x
	.loc 1 86 0
	movb	$0, cursor_y
	.loc 1 89 0
	leave
	.loc 1 87 0
	jmp	move_cursor
.LVL11:
	.cfi_endproc
.LFE3:
	.size	monitor_clear, .-monitor_clear
.globl monitor_write
	.type	monitor_write, @function
monitor_write:
.LFB4:
	.loc 1 92 0
	.cfi_startproc
.LVL12:
	pushl	%ebp
.LCFI6:
	.cfi_def_cfa_offset 8
	movl	%esp, %ebp
	.cfi_offset 5, -8
.LCFI7:
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$4, %esp
	.loc 1 92 0
	movl	8(%ebp), %ebx
	.cfi_offset 3, -12
	.loc 1 94 0
	jmp	.L21
.LVL13:
.L22:
	.loc 1 96 0
	subl	$12, %esp
	movsbl	%al,%eax
	pushl	%eax
	.cfi_escape 0x2e,0x10
	call	monitor_put
	addl	$16, %esp
.L21:
	.loc 1 94 0
	movb	(%ebx), %al
	incl	%ebx
	testb	%al, %al
	jne	.L22
	.loc 1 99 0
	movl	-4(%ebp), %ebx
	leave
	ret
	.cfi_endproc
.LFE4:
	.size	monitor_write, .-monitor_write
.globl monitor_dec
	.type	monitor_dec, @function
monitor_dec:
.LFB5:
	.loc 1 102 0
	.cfi_startproc
.LVL14:
	pushl	%ebp
.LCFI8:
	.cfi_def_cfa_offset 8
	movl	%esp, %ebp
	.cfi_offset 5, -8
.LCFI9:
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$4, %esp
	.loc 1 102 0
	movl	8(%ebp), %eax
	.loc 1 103 0
	testl	%eax, %eax
	je	.L26
	.cfi_offset 3, -12
.LVL15:
	.loc 1 105 0
	movl	$10, %ecx
	xorl	%edx, %edx
	divl	%ecx
.LVL16:
	subl	$12, %esp
	movl	%edx, %ebx
	pushl	%eax
	.cfi_escape 0x2e,0x10
	call	monitor_dec
	.loc 1 106 0
	leal	48(%ebx), %eax
	addl	$16, %esp
	movl	%eax, 8(%ebp)
	.loc 1 108 0
	movl	-4(%ebp), %ebx
	leave
	.loc 1 106 0
	.cfi_escape 0x2e,0x4
	jmp	monitor_put
.LVL17:
.L26:
	.loc 1 108 0
	movl	-4(%ebp), %ebx
	leave
	ret
	.cfi_endproc
.LFE5:
	.size	monitor_dec, .-monitor_dec
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
	.long	.LVL1-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL1-.Ltext0
	.long	.LVL2-.Ltext0
	.value	0x1
	.byte	0x52
	.long	0x0
	.long	0x0
.LLST2:
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
.LLST3:
	.long	.LVL3-.Ltext0
	.long	.LVL4-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL4-.Ltext0
	.long	.LVL5-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL5-.Ltext0
	.long	.LVL6-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LVL6-.Ltext0
	.long	.LVL7-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL7-.Ltext0
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
	.long	.LVL10-.Ltext0
	.long	.LVL11-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0x0
	.long	0x0
.LLST6:
	.long	.LFB4-.Ltext0
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
	.long	.LFE4-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST7:
	.long	.LVL12-.Ltext0
	.long	.LVL13-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL13-.Ltext0
	.long	.LFE4-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST8:
	.long	.LFB5-.Ltext0
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
	.long	.LFE5-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST9:
	.long	.LVL14-.Ltext0
	.long	.LVL15-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL15-.Ltext0
	.long	.LVL16-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL16-.Ltext0
	.long	.LVL17-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LVL17-.Ltext0
	.long	.LFE5-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0x0
	.long	0x0
	.file 2 "kernel_main.h"
	.file 3 "common.h"
	.section	.debug_info
	.long	0x232
	.value	0x2
	.long	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.long	.LASF24
	.byte	0x1
	.long	.LASF25
	.long	.LASF26
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
	.uleb128 0x4
	.long	.LASF3
	.byte	0x2
	.byte	0xb
	.long	0x3e
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.long	.LASF1
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.long	.LASF2
	.uleb128 0x4
	.long	.LASF4
	.byte	0x2
	.byte	0xd
	.long	0x57
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.long	.LASF5
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF6
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF7
	.uleb128 0x4
	.long	.LASF8
	.byte	0x3
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
	.long	.LASF27
	.byte	0x1
	.byte	0x13
	.byte	0x1
	.long	0xb3
	.uleb128 0x6
	.long	.LASF11
	.byte	0x1
	.byte	0x15
	.long	0x4c
	.uleb128 0x6
	.long	.LASF12
	.byte	0x1
	.byte	0x16
	.long	0x33
	.uleb128 0x7
	.uleb128 0x8
	.string	"i"
	.byte	0x1
	.byte	0x1a
	.long	0x33
	.byte	0x0
	.byte	0x0
	.uleb128 0x9
	.long	.LASF28
	.byte	0x1
	.byte	0xa
	.long	.LFB0
	.long	.LFE0
	.long	.LLST0
	.long	0xda
	.uleb128 0xa
	.long	.LASF17
	.byte	0x1
	.byte	0xc
	.long	0x33
	.long	.LLST1
	.byte	0x0
	.uleb128 0xb
	.byte	0x1
	.long	.LASF18
	.byte	0x1
	.byte	0x27
	.byte	0x1
	.long	.LFB2
	.long	.LFE2
	.long	.LLST2
	.long	0x160
	.uleb128 0xc
	.string	"c"
	.byte	0x1
	.byte	0x27
	.long	0x5e
	.long	.LLST3
	.uleb128 0x6
	.long	.LASF13
	.byte	0x1
	.byte	0x29
	.long	0x4c
	.uleb128 0x6
	.long	.LASF14
	.byte	0x1
	.byte	0x2a
	.long	0x4c
	.uleb128 0x6
	.long	.LASF15
	.byte	0x1
	.byte	0x2b
	.long	0x160
	.uleb128 0x6
	.long	.LASF16
	.byte	0x1
	.byte	0x2c
	.long	0x33
	.uleb128 0xd
	.long	0x85
	.long	.LBB5
	.long	.LBE5
	.byte	0x1
	.byte	0x4a
	.uleb128 0xe
	.long	.LBB6
	.long	.LBE6
	.uleb128 0xf
	.long	0x91
	.uleb128 0xf
	.long	0x9c
	.uleb128 0xe
	.long	.LBB7
	.long	.LBE7
	.uleb128 0xf
	.long	0xa8
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.uleb128 0x10
	.byte	0x4
	.long	0x33
	.uleb128 0x11
	.byte	0x1
	.long	.LASF29
	.byte	0x1
	.byte	0x4e
	.long	.LFB3
	.long	.LFE3
	.long	.LLST4
	.long	0x1a2
	.uleb128 0x6
	.long	.LASF11
	.byte	0x1
	.byte	0x50
	.long	0x4c
	.uleb128 0x6
	.long	.LASF12
	.byte	0x1
	.byte	0x51
	.long	0x33
	.uleb128 0x12
	.string	"i"
	.byte	0x1
	.byte	0x52
	.long	0x2c
	.long	.LLST5
	.byte	0x0
	.uleb128 0xb
	.byte	0x1
	.long	.LASF19
	.byte	0x1
	.byte	0x5b
	.byte	0x1
	.long	.LFB4
	.long	.LFE4
	.long	.LLST6
	.long	0x1d2
	.uleb128 0xc
	.string	"s"
	.byte	0x1
	.byte	0x5b
	.long	0x1d2
	.long	.LLST7
	.uleb128 0x8
	.string	"i"
	.byte	0x1
	.byte	0x5d
	.long	0x2c
	.byte	0x0
	.uleb128 0x10
	.byte	0x4
	.long	0x5e
	.uleb128 0xb
	.byte	0x1
	.long	.LASF20
	.byte	0x1
	.byte	0x65
	.byte	0x1
	.long	.LFB5
	.long	.LFE5
	.long	.LLST8
	.long	0x1ff
	.uleb128 0xc
	.string	"i"
	.byte	0x1
	.byte	0x65
	.long	0x6c
	.long	.LLST9
	.byte	0x0
	.uleb128 0x13
	.long	.LASF21
	.byte	0x1
	.byte	0x7
	.long	0x160
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	vidmem
	.uleb128 0x13
	.long	.LASF22
	.byte	0x1
	.byte	0x8
	.long	0x4c
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	cursor_x
	.uleb128 0x13
	.long	.LASF23
	.byte	0x1
	.byte	0x9
	.long	0x4c
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	cursor_y
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
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x6
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
	.uleb128 0x7
	.uleb128 0xb
	.byte	0x1
	.byte	0x0
	.byte	0x0
	.uleb128 0x8
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
	.uleb128 0x9
	.uleb128 0x2e
	.byte	0x1
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
	.uleb128 0x2
	.uleb128 0x6
	.byte	0x0
	.byte	0x0
	.uleb128 0xb
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
	.uleb128 0xc
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
	.uleb128 0xd
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
	.uleb128 0xe
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.byte	0x0
	.byte	0x0
	.uleb128 0xf
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x10
	.uleb128 0xf
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x11
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
	.uleb128 0x12
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
	.uleb128 0x13
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
	.long	0x77
	.value	0x2
	.long	.Ldebug_info0
	.long	0x236
	.long	0xda
	.string	"monitor_put"
	.long	0x166
	.string	"monitor_clear"
	.long	0x1a2
	.string	"monitor_write"
	.long	0x1d8
	.string	"monitor_dec"
	.long	0x1ff
	.string	"vidmem"
	.long	0x211
	.string	"cursor_x"
	.long	0x223
	.string	"cursor_y"
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
.LASF9:
	.string	"long long int"
.LASF25:
	.string	"monitor.c"
.LASF0:
	.string	"unsigned int"
.LASF19:
	.string	"monitor_write"
.LASF20:
	.string	"monitor_dec"
.LASF5:
	.string	"unsigned char"
.LASF16:
	.string	"character_write"
.LASF17:
	.string	"cursor_location"
.LASF4:
	.string	"u8int"
.LASF3:
	.string	"u16int"
.LASF10:
	.string	"long long unsigned int"
.LASF27:
	.string	"scroll_screen"
.LASF15:
	.string	"location"
.LASF29:
	.string	"monitor_clear"
.LASF11:
	.string	"attribute_byte"
.LASF24:
	.string	"GNU C 4.4.3"
.LASF6:
	.string	"char"
.LASF8:
	.string	"uint32_t"
.LASF22:
	.string	"cursor_x"
.LASF26:
	.string	"/home/sankalps/Desktop/projects/os_projects/backupOS"
.LASF13:
	.string	"foreground_color"
.LASF18:
	.string	"monitor_put"
.LASF28:
	.string	"move_cursor"
.LASF23:
	.string	"cursor_y"
.LASF1:
	.string	"short unsigned int"
.LASF7:
	.string	"signed char"
.LASF21:
	.string	"vidmem"
.LASF14:
	.string	"background_color"
.LASF2:
	.string	"short int"
.LASF12:
	.string	"character_byte"
	.ident	"GCC: (Ubuntu 4.4.3-4ubuntu5.1) 4.4.3"
	.section	.note.GNU-stack,"",@progbits
