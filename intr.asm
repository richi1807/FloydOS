extern common_handler
extern irq_handler
;We define the 256 interrupts with the help of this file and a macro
%macro ISR_NOCODE 1
 [global intr%1]
 intr%1:
	cli
	push byte 0 ;Push the dummy error code 
	push byte %1
	jmp intr_common_stub
%endmacro

%macro ISR_CODE 1
 [global intr%1]
 intr%1:
	cli 
	push byte %1 
	jmp intr_common_stub 
%endmacro

%macro IRQ 2
 [global irq%1] 
 irq%1:
	cli 
	push %0 ;The dummy error code 
	push %2
	jmp irq_common_stub
%endmacro
;The interrupt routines expanded by the macro
IRQ 0 ,32 
IRQ 1 , 33 
IRQ 2 , 34
IRQ 3 , 35
IRQ 4 , 36
IRQ 5 , 37
IRQ 6 , 38
IRQ 7 , 39
IRQ 8 , 40
IRQ 9 , 41
IRQ 10 ,42
IRQ 11 ,43
IRQ 12 ,44
IRQ 13 ,45
IRQ 14 ,46
IRQ 15 ,47

ISR_CODE 0
ISR_CODE 1
ISR_CODE 2
ISR_CODE 3
ISR_CODE 4
ISR_CODE 5
ISR_CODE 6
ISR_CODE 7
ISR_CODE 9
ISR_CODE 15
ISR_CODE 16
ISR_CODE 17
ISR_CODE 18
ISR_CODE 19
ISR_CODE 20
ISR_CODE 21
ISR_CODE 22
ISR_CODE 23
ISR_CODE 24
ISR_CODE 25
ISR_CODE 26 
ISR_CODE 27
ISR_CODE 28
ISR_CODE 29
ISR_CODE 30
ISR_CODE 31

ISR_NOCODE 8
ISR_NOCODE 10
ISR_NOCODE 11
ISR_NOCODE 12
ISR_NOCODE 13
ISR_NOCODE 14 

;The isr_common_stub. All it does is push all the register values over the stack and call up the common c function to handle the interrupts 
intr_common_stub :
	pusha 
	mov eax , ds ; lower 16 bits of eax = ds 
	push eax 
	mov eax , 0x10
	mov ds , ax  
	mov fs , ax 
	mov gs , ax 
	mov es , ax 
	;Call the function here 
	call common_handler
	pop eax 
	mov ds , ax 
	mov es , ax 
	mov gs , ax
	mov fs , ax
	popa
	add esp , 8 ; clear off the pushed error code from the stack
	sti 
	iret 

irq_common_stub :
	pusha
	mov ax , ds 
	push eax 
	mov eax , 0x10
	mov ds , ax
	mov ss , ax
	mov gs , ax
	mov fs , ax
	
	call irq_handler 

	pop eax 
	mov ds , ax 
	mov es , ax
	mov ds , ax
	mov fs , ax
	popa 
	add esp , 8
	sti 
	iret
