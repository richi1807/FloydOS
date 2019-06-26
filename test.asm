[global foo]
extern test 
foo :
	xor ax , ax 
	push eax 
	call test 
	ret 
