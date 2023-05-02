;Single Digit Calculator Alisa Majarov

%macro	input	2		;def	input (buffer, numOfChar)
	mov	rax, 0
	mov	rdi, 0
	mov	rsi, %1		;&buffer
	mov	rdx, %2		;&numOfChar
	syscall
%endmacro

%macro	print	2		;def	print (string, numOfChar)
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, %1		;&string
	mov	rdx, %2		;&numOfChar
	syscall
%endmacro
	
%macro	addition	2	;def	addition(num1, num2)
	xor	rax, rax
	mov	dx, 0
	mov	ax, word[%1]	;mov	ax, num1
	add	ax, word[%2]	;add	ax, num2
	adc	dx, 0
%endmacro

section .bss
	buffer	resw	16
	n	resw	1
	action	resw	1
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
	push	word[buffer+rsi]
	loop	stack
	
	mov	rsi, 0
atoi:
	;n = atoi(stack)
	xor	rax, rax
	pop	ax			;ax = top of stack
	cmp	ax, 0
	je	printing
	sub	ax, 41
	cmp	ax, 7
	jl	operator		;jump if ax < 7 it's an operator
	sub	ax, 7
	mov	word[n], ax
	jmp	atoi
	
operator:
	mov	word[action], ax
	cmp	ax, 1
	je	multiplication
	cmp	ax, 2
	je	addition
	cmp	ax, 4
	je	subtraction
	cmp	ax, 6
	je	division
	
multiplication:
	
addition:
	
subtraction:
	
division:
	
printing:
	
	
	
	
	;end of program
	mov	rax, 60
	mov	rdi, 0
	syscall
