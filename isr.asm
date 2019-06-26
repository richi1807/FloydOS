%macro ISR_NOERRORCODE 1
 [global isr%1]
 cli
 push byte 0
 push byte %1 
 jmp isr_common_stub 
%endmacro 

%macro ISR_ERRORCODE 1
 [global isr%1]
 cli
 push byte %1 
 jmp isr_common_stub 
%endmacro

[extern isr_handler] ;Defined in isr.c 
	pusha

	mov ax , ds 
	push eax 

	mov ax , 0x10
	mov ds , ax 
	mov es , ax 
	;mov ss , ax 
	mov fs , ax 
	mov gs , ax 

	call isr_handler 
	
	pop eax 
	mov ds , ax 
	mov es , ax 
	mov fs , ax 
	mov gs , ax 
	
	popa 
	add esp , 8 ; Clear up the error code and the interrupt number 
	sti 
	iret ; Pops the status of the currently interrupted process  

