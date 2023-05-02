;Single Digit Calculator Alisa Majarov

%macro	input	2		;def	input (buffer, numOfChar)
	mov	rax, 0
	mov	rdi, 0
	mov	rsi, %1		;&buffer
	mov	rdx, %2		;numOfChar
	syscall
%endmacro

%macro	print	2		;def	print (string, numOfChar)
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, %1		;&string
	mov	rdx, %2		;numOfChar
	syscall
%endmacro

section .bss
	buffer	resb	16
	n	resb	1
	total	resw	1
	
section .data
	msg1	db	"Input an expression: "		;21
	msg2	db	"Answer: "			;8
	ascii	db	"00000", 10
	
section .text
	global _start
_start:
	print	msg1, 21
	input	buffer, 16
	mov	rsi, 16
	
stack:
	;stack = buffer
	push	byte[buffer+rsi]
	loop	stack
	
atoi:
	;n = atoi(stack)
	
	
	
	
	
	;end of program
	mov	rax, 60
	mov	rdi, 0
	syscall
