[bits 32]
[global gdt_flush]
[global idt_flush]
idt_flush:
	mov eax , [esp+4] ;Install the idt this way 
	lidt [eax] 
	; restore interrupts 
	sti 
	;int 0x13
	ret 
gdt_flush:
	mov eax , [esp+4]
	lgdt [eax]
	mov ax , 0x10 ; Offset for the data segment
	mov ds , ax 
	mov es , ax 
	mov fs , ax 
	mov gs , ax 
	mov ss , ax 
	jmp 0x08:.flush ; make a far jump to switch over to the new GDT

.flush:
	ret 
