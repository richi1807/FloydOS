	.file	"vbr.c"
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
	.code16gcc

	.code16gcc
#NO_APP
	.comm	ldtr,6,4
#APP
	jmp main
#NO_APP
.globl in
	.type	in, @function
in:
.LFB1:
	.file 1 "vbr.c"
	.loc 1 44 0
	.cfi_startproc
.LVL0:
	pushl	%ebp
.LCFI0:
	.cfi_def_cfa_offset 8
	.loc 1 46 0
	movl	%eax, %edx
	.loc 1 44 0
	movl	%esp, %ebp
	.cfi_offset 5, -8
.LCFI1:
	.cfi_def_cfa_register 5
	.loc 1 46 0
#APP
# 46 "vbr.c" 1
	inb %dx,%al
# 0 "" 2
.LVL1:
.LVL2:
	.loc 1 48 0
#NO_APP
	popl	%ebp
	ret
	.cfi_endproc
.LFE1:
	.size	in, .-in
.globl out
	.type	out, @function
out:
.LFB2:
	.loc 1 50 0
	.cfi_startproc
.LVL3:
	movl	%eax, %ecx
	movl	%edx, %eax
.LVL4:
	pushl	%ebp
.LCFI2:
	.cfi_def_cfa_offset 8
	.loc 1 51 0
	movl	%ecx, %edx
.LVL5:
	.loc 1 50 0
	movl	%esp, %ebp
	.cfi_offset 5, -8
.LCFI3:
	.cfi_def_cfa_register 5
	.loc 1 51 0
#APP
# 51 "vbr.c" 1
	outb %al,%dx
# 0 "" 2
	.loc 1 52 0
#NO_APP
	popl	%ebp
	ret
	.cfi_endproc
.LFE2:
	.size	out, .-out
.globl wait_keyboard_input
	.type	wait_keyboard_input, @function
wait_keyboard_input:
.LFB3:
	.loc 1 55 0
	.cfi_startproc
	pushl	%ebp
.LCFI4:
	.cfi_def_cfa_offset 8
.LBB10:
	.loc 1 58 0
	movl	$100, %eax
.LBE10:
	.loc 1 55 0
	movl	%esp, %ebp
	.cfi_offset 5, -8
.LCFI5:
	.cfi_def_cfa_register 5
	.loc 1 63 0
	popl	%ebp
.LBB11:
	.loc 1 58 0
	jmp	in
.LBE11:
	.cfi_endproc
.LFE3:
	.size	wait_keyboard_input, .-wait_keyboard_input
.globl wait_keyboard_output
	.type	wait_keyboard_output, @function
wait_keyboard_output:
.LFB4:
	.loc 1 66 0
	.cfi_startproc
	pushl	%ebp
.LCFI6:
	.cfi_def_cfa_offset 8
	movl	%esp, %ebp
	.cfi_offset 5, -8
.LCFI7:
	.cfi_def_cfa_register 5
.L8:
.LBB12:
	.loc 1 69 0
	movl	$100, %eax
	call	in
	.loc 1 70 0
	testb	$1, %al
.LVL6:
	je	.L8
.LBE12:
	.loc 1 74 0
	popl	%ebp
	ret
	.cfi_endproc
.LFE4:
	.size	wait_keyboard_output, .-wait_keyboard_output
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"The A20 line is not enabledl"
	.text
.globl enable_A20
	.type	enable_A20, @function
enable_A20:
.LFB5:
	.loc 1 78 0
	.cfi_startproc
	pushl	%ebp
.LCFI8:
	.cfi_def_cfa_offset 8
	movl	%esp, %ebp
	.cfi_offset 5, -8
.LCFI9:
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$4, %esp
	.loc 1 83 0
#APP
# 83 "vbr.c" 1
	cli
# 0 "" 2
	.loc 1 85 0
#NO_APP
	movl	$208, %edx
	movl	$100, %eax
	.cfi_offset 3, -12
	call	out
	.loc 1 87 0
	call	wait_keyboard_output
	.loc 1 89 0
	movl	$96, %eax
	call	in
	.loc 1 91 0
	testb	$2, %al
.LVL7:
	.loc 1 89 0
	movb	%al, %bl
.LVL8:
	.loc 1 91 0
	jne	.L13
	.loc 1 92 0
	movl	$.LC0, %eax
	call	print
.L13:
	.loc 1 94 0
	call	wait_keyboard_input
	.loc 1 100 0
	orl	$2, %ebx
.LVL9:
	.loc 1 96 0
	movl	$209, %edx
	movl	$100, %eax
	call	out
	.loc 1 98 0
	call	wait_keyboard_input
	.loc 1 100 0
	movzbl	%bl, %edx
	movl	$96, %eax
	.loc 1 102 0
	popl	%ecx
	popl	%ebx
	popl	%ebp
	.loc 1 100 0
	jmp	out
	.cfi_endproc
.LFE5:
	.size	enable_A20, .-enable_A20
.globl print
	.type	print, @function
print:
.LFB6:
	.loc 1 105 0
	.cfi_startproc
.LVL10:
	pushl	%ebp
.LCFI10:
	.cfi_def_cfa_offset 8
	movl	%eax, %edx
	movl	%esp, %ebp
	.cfi_offset 5, -8
.LCFI11:
	.cfi_def_cfa_register 5
	.loc 1 107 0
	jmp	.L16
.L17:
.LBB13:
	.loc 1 110 0
#APP
# 110 "vbr.c" 1
	mov $0x0E ,  %ah
# 0 "" 2
	.loc 1 111 0
# 111 "vbr.c" 1
	xor %bh ,  %bh
# 0 "" 2
	.loc 1 112 0
# 112 "vbr.c" 1
	mov $0xEF ,  %bl
# 0 "" 2
	.loc 1 113 0
# 113 "vbr.c" 1
	mov %cl , %al ;
# 0 "" 2
.LVL11:
	.loc 1 114 0
# 114 "vbr.c" 1
	or %al , %al
# 0 "" 2
	.loc 1 115 0
# 115 "vbr.c" 1
	int $0x10
# 0 "" 2
.LVL12:
#NO_APP
.L16:
.LBE13:
	.loc 1 107 0
	movb	(%edx), %cl
	incl	%edx
	testb	%cl, %cl
	jne	.L17
	.loc 1 118 0
	popl	%ebp
	ret
	.cfi_endproc
.LFE6:
	.size	print, .-print
	.section	.rodata.str1.1
.LC1:
	.string	"Welcome to the funnyOS !!\r\nKernel modules loaded...\r\n"
.LC2:
	.string	"A 20 mode is enabled \r\n"
.LC3:
	.string	"Entering Protected mode \r\n"
	.text
.globl main
	.type	main, @function
main:
.LFB7:
	.loc 1 121 0
	.cfi_startproc
	pushl	%ebp
.LCFI12:
	.cfi_def_cfa_offset 8
	.loc 1 122 0
	movl	$.LC1, %eax
	.loc 1 121 0
	movl	%esp, %ebp
	.cfi_offset 5, -8
.LCFI13:
	.cfi_def_cfa_register 5
	.loc 1 122 0
	call	print
	.loc 1 153 0
	movl	$.LC2, %eax
	call	print
	.loc 1 154 0
	movl	$.LC3, %eax
	call	print
	.loc 1 155 0
#APP
# 155 "vbr.c" 1
	mov $0x200 , %eax
# 0 "" 2
	.loc 1 156 0
# 156 "vbr.c" 1
	jmp *%eax
# 0 "" 2
#NO_APP
.L20:
	jmp	.L20
	.cfi_endproc
.LFE7:
	.size	main, .-main
.globl print_char
	.type	print_char, @function
print_char:
.LFB8:
	.loc 1 162 0
	.cfi_startproc
.LVL13:
	pushl	%ebp
.LCFI14:
	.cfi_def_cfa_offset 8
	movl	%esp, %ebp
	.cfi_offset 5, -8
.LCFI15:
	.cfi_def_cfa_register 5
	.loc 1 164 0
#APP
# 164 "vbr.c" 1
	mov $0x0E ,  %ah
# 0 "" 2
	.loc 1 165 0
# 165 "vbr.c" 1
	xor %bh ,  %bh
# 0 "" 2
	.loc 1 166 0
# 166 "vbr.c" 1
	mov $0xEF ,  %bl
# 0 "" 2
	.loc 1 167 0
#NO_APP
	movb	8(%ebp), %dl
#APP
# 167 "vbr.c" 1
	mov %dl , %al ;
# 0 "" 2
	.loc 1 168 0
# 168 "vbr.c" 1
	or %al , %al
# 0 "" 2
	.loc 1 169 0
# 169 "vbr.c" 1
	int $0x10
# 0 "" 2
	.loc 1 171 0
#NO_APP
	popl	%ebp
	ret
	.cfi_endproc
.LFE8:
	.size	print_char, .-print_char
.globl print_dec
	.type	print_dec, @function
print_dec:
.LFB9:
	.loc 1 175 0
	.cfi_startproc
.LVL14:
	pushl	%ebp
.LCFI16:
	.cfi_def_cfa_offset 8
	movl	%esp, %ebp
	.cfi_offset 5, -8
.LCFI17:
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$4, %esp
	.loc 1 175 0
	movl	8(%ebp), %eax
	movl	12(%ebp), %edx
	.loc 1 176 0
	testl	%eax, %eax
	jne	.L25
	.cfi_offset 3, -12
.LVL15:
	.loc 1 178 0
	testl	%edx, %edx
	jne	.L26
.LBB14:
.LBB15:
	.loc 1 164 0
#APP
# 164 "vbr.c" 1
	mov $0x0E ,  %ah
# 0 "" 2
	.loc 1 165 0
# 165 "vbr.c" 1
	xor %bh ,  %bh
# 0 "" 2
	.loc 1 166 0
# 166 "vbr.c" 1
	mov $0xEF ,  %bl
# 0 "" 2
	.loc 1 167 0
#NO_APP
	movb	$48, %dl
.LVL16:
	jmp	.L29
.LVL17:
.L26:
.LBE15:
.LBE14:
.LBB16:
.LBB17:
	.loc 1 164 0
#APP
# 164 "vbr.c" 1
	mov $0x0E ,  %ah
# 0 "" 2
	.loc 1 165 0
# 165 "vbr.c" 1
	xor %bh ,  %bh
# 0 "" 2
	.loc 1 166 0
# 166 "vbr.c" 1
	mov $0xEF ,  %bl
# 0 "" 2
	.loc 1 167 0
#NO_APP
	xorl	%edx, %edx
.LVL18:
.L29:
#APP
# 167 "vbr.c" 1
	mov %dl , %al ;
# 0 "" 2
.LVL19:
	.loc 1 168 0
# 168 "vbr.c" 1
	or %al , %al
# 0 "" 2
	.loc 1 169 0
# 169 "vbr.c" 1
	int $0x10
# 0 "" 2
#NO_APP
	jmp	.L28
.LVL20:
.L25:
.LBE17:
.LBE16:
	.loc 1 184 0
	pushl	%ebx
	movl	$10, %ecx
	pushl	%ebx
	pushl	%edx
	xorl	%edx, %edx
.LVL21:
	divl	%ecx
.LVL22:
	pushl	%eax
	movl	%edx, %ebx
	.cfi_escape 0x2e,0x10
	call	print_dec
.LBB18:
.LBB19:
	.loc 1 164 0
#APP
# 164 "vbr.c" 1
	mov $0x0E ,  %ah
# 0 "" 2
	.loc 1 165 0
# 165 "vbr.c" 1
	xor %bh ,  %bh
# 0 "" 2
	.loc 1 166 0
# 166 "vbr.c" 1
	mov $0xEF ,  %bl
# 0 "" 2
	.loc 1 167 0
# 167 "vbr.c" 1
	mov %bl , %al ;
# 0 "" 2
	.loc 1 168 0
# 168 "vbr.c" 1
	or %al , %al
# 0 "" 2
	.loc 1 169 0
# 169 "vbr.c" 1
	int $0x10
# 0 "" 2
#NO_APP
	addl	$16, %esp
.L28:
.LBE19:
.LBE18:
	.loc 1 186 0
	movl	-4(%ebp), %ebx
	leave
	ret
	.cfi_endproc
.LFE9:
	.size	print_dec, .-print_dec
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
	.long	.LVL1-.Ltext0
	.long	.LVL2-.Ltext0
	.value	0x1
	.byte	0x50
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
	.long	.LVL3-.Ltext0
	.long	.LVL4-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL4-.Ltext0
	.long	.LFE2-.Ltext0
	.value	0x1
	.byte	0x51
	.long	0x0
	.long	0x0
.LLST5:
	.long	.LVL3-.Ltext0
	.long	.LVL5-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL5-.Ltext0
	.long	.LFE2-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0x0
	.long	0x0
.LLST6:
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
.LLST7:
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
	.long	.LVL7-.Ltext0
	.long	.LVL8-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0x0
	.long	0x0
.LLST10:
	.long	.LFB6-.Ltext0
	.long	.LCFI10-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI10-.Ltext0
	.long	.LCFI11-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI11-.Ltext0
	.long	.LFE6-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST11:
	.long	.LVL10-.Ltext0
	.long	.LVL11-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL12-.Ltext0
	.long	.LFE6-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0x0
	.long	0x0
.LLST12:
	.long	.LFB7-.Ltext0
	.long	.LCFI12-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI12-.Ltext0
	.long	.LCFI13-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI13-.Ltext0
	.long	.LFE7-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST13:
	.long	.LFB8-.Ltext0
	.long	.LCFI14-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI14-.Ltext0
	.long	.LCFI15-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI15-.Ltext0
	.long	.LFE8-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST14:
	.long	.LFB9-.Ltext0
	.long	.LCFI16-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI16-.Ltext0
	.long	.LCFI17-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI17-.Ltext0
	.long	.LFE9-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST15:
	.long	.LVL14-.Ltext0
	.long	.LVL15-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL15-.Ltext0
	.long	.LVL19-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL19-.Ltext0
	.long	.LVL20-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LVL20-.Ltext0
	.long	.LVL22-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL22-.Ltext0
	.long	.LFE9-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	0x0
	.long	0x0
.LLST16:
	.long	.LVL14-.Ltext0
	.long	.LVL15-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 4
	.long	.LVL15-.Ltext0
	.long	.LVL16-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL16-.Ltext0
	.long	.LVL17-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 12
	.long	.LVL17-.Ltext0
	.long	.LVL18-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL18-.Ltext0
	.long	.LVL20-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 12
	.long	.LVL20-.Ltext0
	.long	.LVL21-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL21-.Ltext0
	.long	.LFE9-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 12
	.long	0x0
	.long	0x0
	.file 2 "code16gcc.h"
	.section	.debug_info
	.long	0x31a
	.value	0x2
	.long	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.long	.LASF17
	.byte	0x1
	.long	.LASF18
	.long	.LASF19
	.long	.Ltext0
	.long	.Letext0
	.long	.Ldebug_line0
	.uleb128 0x2
	.long	.LASF20
	.byte	0x6
	.byte	0x2
	.byte	0x6
	.long	0x4e
	.uleb128 0x3
	.long	.LASF0
	.byte	0x2
	.byte	0x7
	.long	0x4e
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x3
	.long	.LASF1
	.byte	0x2
	.byte	0x8
	.long	0x55
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.byte	0x0
	.uleb128 0x4
	.byte	0x2
	.byte	0x7
	.long	.LASF2
	.uleb128 0x5
	.byte	0x4
	.long	0x5b
	.uleb128 0x4
	.byte	0x8
	.byte	0x7
	.long	.LASF3
	.uleb128 0x4
	.byte	0x4
	.byte	0x7
	.long	.LASF4
	.uleb128 0x6
	.long	.LASF21
	.byte	0x1
	.byte	0x21
	.byte	0x1
	.long	0x62
	.byte	0x3
	.long	0x9c
	.uleb128 0x7
	.string	"sel"
	.byte	0x1
	.byte	0x21
	.long	0x4e
	.uleb128 0x7
	.string	"off"
	.byte	0x1
	.byte	0x21
	.long	0x9c
	.uleb128 0x8
	.string	"ret"
	.byte	0x1
	.byte	0x23
	.long	0x62
	.byte	0x0
	.uleb128 0x9
	.byte	0x4
	.uleb128 0xa
	.byte	0x1
	.long	.LASF22
	.byte	0x1
	.byte	0xa1
	.byte	0x1
	.byte	0x1
	.long	0xc0
	.uleb128 0x7
	.string	"d"
	.byte	0x1
	.byte	0xa1
	.long	0xc0
	.uleb128 0x8
	.string	"ch"
	.byte	0x1
	.byte	0xa3
	.long	0xc0
	.byte	0x0
	.uleb128 0x4
	.byte	0x1
	.byte	0x6
	.long	.LASF5
	.uleb128 0xb
	.byte	0x1
	.string	"in"
	.byte	0x1
	.byte	0x2b
	.byte	0x1
	.long	0x102
	.long	.LFB1
	.long	.LFE1
	.long	.LLST0
	.long	0x102
	.uleb128 0xc
	.long	.LASF7
	.byte	0x1
	.byte	0x2b
	.long	0x62
	.long	.LLST1
	.uleb128 0xd
	.string	"ret"
	.byte	0x1
	.byte	0x2d
	.long	0x102
	.long	.LLST2
	.byte	0x0
	.uleb128 0x4
	.byte	0x1
	.byte	0x8
	.long	.LASF6
	.uleb128 0xe
	.byte	0x1
	.string	"out"
	.byte	0x1
	.byte	0x31
	.byte	0x1
	.long	.LFB2
	.long	.LFE2
	.long	.LLST3
	.long	0x141
	.uleb128 0xc
	.long	.LASF7
	.byte	0x1
	.byte	0x31
	.long	0x62
	.long	.LLST4
	.uleb128 0xc
	.long	.LASF8
	.byte	0x1
	.byte	0x31
	.long	0x102
	.long	.LLST5
	.byte	0x0
	.uleb128 0xf
	.byte	0x1
	.long	.LASF10
	.byte	0x1
	.byte	0x36
	.long	.LFB3
	.long	.LFE3
	.long	.LLST6
	.long	0x16b
	.uleb128 0x10
	.long	.Ldebug_ranges0+0x0
	.uleb128 0x11
	.long	.LASF9
	.byte	0x1
	.byte	0x3a
	.long	0x102
	.byte	0x0
	.byte	0x0
	.uleb128 0xf
	.byte	0x1
	.long	.LASF11
	.byte	0x1
	.byte	0x41
	.long	.LFB4
	.long	.LFE4
	.long	.LLST7
	.long	0x19b
	.uleb128 0x12
	.long	.LBB12
	.long	.LBE12
	.uleb128 0x13
	.long	.LASF9
	.byte	0x1
	.byte	0x45
	.long	0x102
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.byte	0x0
	.uleb128 0x14
	.byte	0x1
	.long	.LASF12
	.byte	0x1
	.byte	0x4d
	.byte	0x1
	.long	.LFB5
	.long	.LFE5
	.long	.LLST8
	.long	0x1c4
	.uleb128 0x15
	.long	.LASF9
	.byte	0x1
	.byte	0x59
	.long	0x102
	.long	.LLST9
	.byte	0x0
	.uleb128 0x14
	.byte	0x1
	.long	.LASF13
	.byte	0x1
	.byte	0x68
	.byte	0x1
	.long	.LFB6
	.long	.LFE6
	.long	.LLST10
	.long	0x208
	.uleb128 0x16
	.string	"s"
	.byte	0x1
	.byte	0x68
	.long	0x208
	.long	.LLST11
	.uleb128 0x8
	.string	"i"
	.byte	0x1
	.byte	0x6a
	.long	0x213
	.uleb128 0x12
	.long	.LBB13
	.long	.LBE13
	.uleb128 0x8
	.string	"ch"
	.byte	0x1
	.byte	0x6d
	.long	0xc0
	.byte	0x0
	.byte	0x0
	.uleb128 0x5
	.byte	0x4
	.long	0x20e
	.uleb128 0x17
	.long	0xc0
	.uleb128 0x18
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0xf
	.byte	0x1
	.long	.LASF14
	.byte	0x1
	.byte	0x79
	.long	.LFB7
	.long	.LFE7
	.long	.LLST12
	.long	0x23c
	.uleb128 0x8
	.string	"r"
	.byte	0x1
	.byte	0x92
	.long	0x62
	.byte	0x0
	.uleb128 0x19
	.long	0x9e
	.long	.LFB8
	.long	.LFE8
	.long	.LLST13
	.long	0x25f
	.uleb128 0x1a
	.long	0xac
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1b
	.long	0xb5
	.byte	0x0
	.uleb128 0x14
	.byte	0x1
	.long	.LASF15
	.byte	0x1
	.byte	0xae
	.byte	0x1
	.long	.LFB9
	.long	.LFE9
	.long	.LLST14
	.long	0x30b
	.uleb128 0x16
	.string	"dec"
	.byte	0x1
	.byte	0xae
	.long	0x62
	.long	.LLST15
	.uleb128 0xc
	.long	.LASF16
	.byte	0x1
	.byte	0xae
	.long	0x213
	.long	.LLST16
	.uleb128 0x1c
	.long	0x9e
	.long	.LBB14
	.long	.LBE14
	.byte	0x1
	.byte	0xb3
	.long	0x2be
	.uleb128 0x1d
	.long	0x251
	.uleb128 0x12
	.long	.LBB15
	.long	.LBE15
	.uleb128 0x1b
	.long	0xb5
	.byte	0x0
	.byte	0x0
	.uleb128 0x1c
	.long	0x9e
	.long	.LBB16
	.long	.LBE16
	.byte	0x1
	.byte	0xb5
	.long	0x2e6
	.uleb128 0x1d
	.long	0x251
	.uleb128 0x12
	.long	.LBB17
	.long	.LBE17
	.uleb128 0x1b
	.long	0xb5
	.byte	0x0
	.byte	0x0
	.uleb128 0x1e
	.long	0x9e
	.long	.LBB18
	.long	.LBE18
	.byte	0x1
	.byte	0xb9
	.uleb128 0x1d
	.long	0x251
	.uleb128 0x12
	.long	.LBB19
	.long	.LBE19
	.uleb128 0x1b
	.long	0xb5
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.uleb128 0x1f
	.long	.LASF23
	.byte	0x2
	.byte	0xa
	.long	0x25
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.long	ldtr
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
	.uleb128 0x3
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
	.uleb128 0x4
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
	.uleb128 0x5
	.uleb128 0xf
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x6
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
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x7
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
	.uleb128 0xf
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
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
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xb
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
	.uleb128 0xc
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
	.uleb128 0xd
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
	.uleb128 0xe
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
	.uleb128 0x10
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
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
	.uleb128 0x14
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
	.uleb128 0x15
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
	.uleb128 0x16
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
	.uleb128 0x17
	.uleb128 0x26
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x18
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
	.uleb128 0x19
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
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x1a
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x1b
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x1c
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
	.uleb128 0x1d
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x1e
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
	.uleb128 0x1f
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
	.long	0x96
	.value	0x2
	.long	.Ldebug_info0
	.long	0x31e
	.long	0xc7
	.string	"in"
	.long	0x109
	.string	"out"
	.long	0x141
	.string	"wait_keyboard_input"
	.long	0x16b
	.string	"wait_keyboard_output"
	.long	0x19b
	.string	"enable_A20"
	.long	0x1c4
	.string	"print"
	.long	0x21a
	.string	"main"
	.long	0x23c
	.string	"print_char"
	.long	0x25f
	.string	"print_dec"
	.long	0x30b
	.string	"ldtr"
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
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.long	.LBB10-.Ltext0
	.long	.LBE10-.Ltext0
	.long	.LBB11-.Ltext0
	.long	.LBE11-.Ltext0
	.long	0x0
	.long	0x0
	.section	.debug_str,"MS",@progbits,1
.LASF8:
	.string	"value"
.LASF11:
	.string	"wait_keyboard_output"
.LASF2:
	.string	"short unsigned int"
.LASF9:
	.string	"status"
.LASF19:
	.string	"/home/sankalps/Desktop/projects/os_projects/backupOS"
.LASF10:
	.string	"wait_keyboard_input"
.LASF0:
	.string	"size"
.LASF16:
	.string	"times"
.LASF1:
	.string	"base"
.LASF20:
	.string	"ldtr_struct"
.LASF6:
	.string	"unsigned char"
.LASF14:
	.string	"main"
.LASF4:
	.string	"unsigned int"
.LASF12:
	.string	"enable_A20"
.LASF3:
	.string	"long long unsigned int"
.LASF17:
	.string	"GNU C 4.4.3"
.LASF5:
	.string	"char"
.LASF23:
	.string	"ldtr"
.LASF13:
	.string	"print"
.LASF7:
	.string	"port"
.LASF15:
	.string	"print_dec"
.LASF21:
	.string	"farpeekl"
.LASF22:
	.string	"print_char"
.LASF18:
	.string	"vbr.c"
	.ident	"GCC: (Ubuntu 4.4.3-4ubuntu5.1) 4.4.3"
	.section	.note.GNU-stack,"",@progbits
