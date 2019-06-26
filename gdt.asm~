; Offset 0 in GDT: Descriptor code=0
;This will enable the GDT. Now , next thing to do is 
[bits 16]
[org 0x800]
mov si , start_message
call print_string 
call detect_conventional_memory
call get_extended_memory 
call get_memory_map 
call write_multiboot_header_info
call lgdt_load_asm
call pmode_enter 
;The multiboot header structure declaration , it will get passed to the kernel 
multiboot_info:
	flags		dd	0	; required
	memoryLo	dd	1	; memory size. Present if flags[0] is set
	memoryHi	dd	1
	bootDevice	dd	1	; boot device. Present if flags[1] is set
	cmdLine	dd	1	; kernel command line. Present if flags[2] is set
	mods_count	dd	1	; number of modules loaded along with kernel. present if flags[3] is set
	mods_addr	dd	1
	syms0		dd	1	; symbol table info. present if flags[4] or flags[5] is set
	syms1		dd	1
	syms2		dd	1
	mmap_length	dd	1	; memory map. Present if flags[6] is set
	mmap_address	dd	1
	drives_length	dd	1	; phys address of first drive structure. present if flags[7] is set
	drives_addr	dd	1
	config_table	dd	1	; ROM configuation table. present if flags[8] is set
	bootloader_name dd	1	; Bootloader name. present if flags[9] is set
	apm_table	dd	1	; advanced power management (apm) table. present if flags[10] is set
	vbe_control_info dd	1	; video bios extension (vbe). present if flags[11] is set
	vbe_mode_info	dd	1
	vbe_mode	dw	1
	vbe_interface_seg dw	1
	vbe_interface_off dw	1
	vbe_interface_len dw	1
write_multiboot_header_info :
	mov si , multiboot_header_string 
	call print_string 
	mov dword eax , [extended_memory_low] 
	mov dword [memoryLo] , eax 
	mov dword eax , [extended_memory_high]
	mov dword [memoryHi] , eax
	ret 
multiboot_header_string db "Writing the multiboot string",0
;The memory map structure 
;which gives the entries for the memory map 
extended_memory_low  dw 1
extended_memory_high dw 1 

get_memory_map :
	push eax 
	push ebx
	push ecx 
	push ecx
	xor ebx , ebx 
	mov ecx , 24 
	mov ax , 0x7e0
	mov es  , ax ;We save the buffer at 0x7E00. Just after the bootloader  
	xor di , di ; Overwriting the buffer 
	mov edx , 'PAMS'
	mov eax , 0xe820
	int 0x15 
	jc error_get_memory_map
	cmp ebx , 0x0
	jz error_get_memory_map
	cmp eax , 0x534D4150
	jnz error_get_memory_map 
	cmp ecx , 20
	jnz error_get_memory_map
loop_get_memory_map:
	;Continuation value is already in the ebx .No need to do anything 
	;ECX will be set too. 
	mov ecx , 20 
	mov edx , 'PAMS'
	add di , 20 
	mov eax , 0xE820
	int 0x15 
	cmp ebx , 0
	je done_get_memory_map
	mov dword [mmap_length] , ebx 
	jc error_get_memory_map
	cmp eax , 0x534D4150
	jnz error_get_memory_map
	cmp ecx , 20 
	jnz error_get_memory_map
	jmp loop_get_memory_map  
done_get_memory_map:
	mov dword [mmap_address] , 0x7e00
	mov si , done_get_memory_map_string 
	call print_string 
	pop edx 
	pop ecx
	pop ebx
	pop eax 
	ret 
done_get_memory_map_string db "Done populating the memory map\r\n",0
error_get_memory_map:
	mov si , error_get_memory_map_string
	call print_string
	ret 
start_message db "Starting Stage 3",0
error_get_memory_map_string db "Error getting the memory map\r\n",0
get_extended_memory :;EAX and EBX have the extended memory mentioned 
	mov ax , 0xE801 
	int 0x15
	jc error_get_extended_memory
	jcxz use_ax 
	ret 
use_ax :
	mov eax, ecx 
	mov ebx, edx
	mov dword [extended_memory_low] , eax 
	mov dword [extended_memory_high] , ebx
	mov si , get_extended_memory_string 
	call print_string 
	ret ;
get_extended_memory_string db "Done getting the extended memory string \r\n", 0
error_get_extended_memory:
	mov si , error_get_extended_memory_string 
	call print_string
	ret 
error_get_extended_memory_string db "Error getting extending memory\r\n",0
detect_conventional_memory:
	xor ax , ax 
	int 0x12 
	jc error_detect_conventional_memory
	push ax 
	mov si , success_detect_conventional_memory 
	call print_string 
	;AX has the value to be printed 
	pop ax 
	call print_decimal 
	ret 
error_detect_conventional_memory:
	mov si , error_detect_conventional_memory
	call print_string 
	cmp ax , 0x80
	je error_invalid_function 
	cmp ax , 0x86 
	je error_unsupported_function
	ret 
error_invalid_function:
	mov si , error_invalid_function_string 
	call print_string
	ret
error_unsupported_function:
	mov si , error_unsupported_function_string 
	call print_string 
	ret 
gdt_data: 
	dd 0 				; null descriptor
	dd 0 
 
; Offset 0x8 bytes from start of GDT: Descriptor code therfore is 8
 
; gdt code:				; code descriptor
	dw 0FFFFh 			; limit low
	dw 0 				; base low
	db 0 				; base middle
	db 10011010b 			; access
	db 11001111b 			; granularity
	db 0 				; base high
 
; Offset 16 bytes (0x10) from start of GDT. Descriptor code therfore is 0x10.
 
; gdt data:				; data descriptor
	dw 0FFFFh 			; limit low (Same as code)
	dw 0 				; base low
	db 0 				; base middle
	db 10010010b 			; access
	db 11001111b 			; granularity
	db 0				; base high
 
;...Other descriptors begin at offset 0x18. Remember that each descriptor is 8 bytes in size?
; Add other descriptors for Ring 3 applications, stack, whatever here...
 
end_of_gdt:
toc: 
	dw end_of_gdt - gdt_data - 1 	; limit (Size of GDT)
	dd gdt_data 			; base of GDT
lgdt_load_asm :
	mov si , lgdt_load_asm_string
	call print_string
	cli			; make sure to clear interrupts first!
	lgdt	[toc]		; load GDT into GDTR
	;call pmode_enter
	sti 
	ret
lgdt_load_asm_string db "Loading the decriptor tables",0
pmode_enter :
	mov si , pmode_enter_string
	call print_string 
	mov eax , 0x2BADB002
	mov ebx , multiboot_info ;Only the address is what we need in here 
	mov eax, cr0 ; set bit 0 in CR0-go to pmode 
	or eax, 1 
	mov cr0, eax
	;make a far jump and you are done 
	jmp 0x8:stage_three
pmode_enter_string db "Entering the protected mode world",0
print_decimal: ;Number is in ax register
	mov cx , 10
	mov bx , -1 
	push bx ; A dummy sentinel which is kept to record the order
loop_print_decimal:
	mov dx , 0 
	div cx 
	;Now , ax =  eax/10
	;And dx  = eax%10
	push dx ; Push the variable on the stack 
	cmp ax ,0 
	je print_digits_on_stack
	jmp loop_print_decimal
print_digits_on_stack:
	;This will print the digits which are kept over on the stack :P
	pop ax 
	cmp ax , -1 
	je end_print_digit
	add al , '0'
	call print_char
	jmp print_digits_on_stack
end_print_digit:
	ret 
print_char: ;print the character which is pushed onto the stack
	cmp ah , 0x0
	jnz error_print_char
	mov ah , 0x0E
	xor bh , bh 
	mov bl , 0xEF
	int 0x10 
	ret 
error_print_char:
	mov si , error_print_char_string
	call print_string
	ret
print_string :
	xor bh , bh 
	mov bl , 0xEF
	mov ah , 0x0E
	lodsb
	or al , al 
	jz end_print_string
	int 0x10 
	jmp print_string 
end_print_string:
	ret 

success_detect_conventional_memory db "success detecting conventional memory", 0
error_print_char_string db "error printing character", 0
error_detect_conventional_memory_string db "Error detecting conventional memory",0
error_invalid_function_string db "Invalid Function",0
error_unsupported_function_string db "Unsupported function", 0
[bits 32]
	
stage_three :
	mov		ax, 0x10		; set data segments to data selector (0x10)
	mov		ds, ax
	mov		ss, ax
	mov		es, ax
	mov		esp, 90000h		; stack begins from 90000h
	;Write something to the video memory 
	mov byte [0B8000h], 'P'
	mov byte [0B8001h], 1Bh
	mov eax , 0x2BADB002 
	push ebx ; The multiboot header structure is pushed onto the stack 
	jmp 0xC00
loop: jmp loop
