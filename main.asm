[bits 16]
jmp kmain 
print_string : 
		mov ah , 0x0E
		xor bh , bh 
		mov bl , 0xEF
repeat_loop_print_string : 
		lodsb 
		or al , al
		jz return_function
		int 0x10 ;Ah and Bh have already been set
		jmp repeat_loop_print_string
		
return_function:
		ret  
	
kmain:
	mov ah , 0x0e 
	xor bh , bh 
	mov al , 'S'
	mov bl , 0xEF 
	int 0x10 
	mov si , debug_message 
	call print_string 
	hlt ; Halt the machine 	
debug_message db "kernel loaded . *Yey* Me mucho gusta",0
