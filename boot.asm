[bits 16]
[org 0x7c00]

; The starting part of the bootloader function .For now , all it does is print the string
;Load the kernel at the 1 MB mark 
main: 
	mov si , welcome_message 
	call print_string
	mov si , kernel_loading_message 
	call print_string
	call reset 
	mov ax , 1 
	mov bx , 0x60
	mov ecx ,40
	mov es , bx 
	xor bx , bx 
	call read_sectors_loop 
	jmp repeat_read_success
;Some of the preprocessing directives which can be of help 
bytes_per_sector equ 512 
total_sectors    equ 2880
kernel_location_sector equ 2	
;This module is supposed to load the kernel into the memory.  
reset:
	mov ah , 0
	mov dl , 0
	int 0x13 
	jc reset
	mov si , reset_string
	ret 
reset_string db "the floppy disk has been resetted",0
repeat_read_success:
	mov si , kernel_loading_success 
	call print_string
	;Set the data segment 
	mov ax , 0x60
	;mov ds , ax 
	mov si , error_message 
	call print_string 
	jmp 0x60:0x0  ; Load at address 0x600
        mov si , error_message 
	call print_string
print_string : 
		mov ah , 0x0E
		xor bh , bh 
		mov bl , 0xEF 
		lodsb 
		or al , al
		jz return_function
		int 0x10 ;Ah and Bh have already been set
		jmp print_string
		
return_function:
		ret  
SectorsPerTrack equ 18 
NumHeads equ 2 
;cx = how many sectors to read
read_sectors_loop:
	push cx  
	push ax 
	mov cl , 18
	mov dl , 0x0
read_try:	
	and     dx, 7Fh ; dh <- 0, dl.7 <- 0
  	div     cl
  	mov     ch, al
  	mov     cl, ah
  	shr     ch, 1
  	adc     dh, dh
  	inc     cx
  	mov     ax, 0201h
  	int     13h 
  	jnc foo
  	jmp read_try  
foo:
	pop ax 
	xor cx , cx 
	pop cx
	dec cx
	cmp cx , 0x0
	jz end_sectors_loop
	inc ax 
	add bx ,0x200
	jmp read_sectors_loop
end_sectors_loop:
	ret
error_message db " In here.", 0
enabled db "A20 enabled ",0
disabled db "A20 disabled ",0
welcome_message db " Welcome to the silly operating system.",0
kernel_loading_message db " Loading the kernel modules.",0
kernel_loading_success db " Kernel module loading success.",0
final_string db "Everything is working fine"
times 510 - ( $ - $$ ) db 0
dw 0xAA55 

