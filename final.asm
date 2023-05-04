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



section .bss

	buffer	resb	10

	n1	resw	1

	n2	resw	1

	action	resw	1

	

section .data

	msg1	db	"Input an expression: "		;21

	msg2	db	"Answer: "			;8

	ascii	db	"00000", 10

	

section .text

	global _start

_start:

	print	msg1, 21

	input	buffer, 10

	

	mov	rsi, 10

	

stack:

	;stack = buffer

	xor	rax, rax

	movzx	rax, byte[buffer+rsi]

	push	rax

	dec	rsi

	cmp	rsi, 0

	jge	stack



	;n1 = first input number

	xor	rax, rax

	pop	rax			;ax = top of stack

	sub	ax, 41

	cmp	ax, 7

	jl	operator		;jump if ax < 7 it's an operator

	sub	ax, 7

	mov	word[n1], ax

	

atoi:

	;extract n2

	xor	rax, rax

	pop	rax			;ax = top of stack

	cmp	ax, 10

	je	itoa

	sub	ax, 41

	cmp	ax, 7

	jl	operator		;jump if ax < 7 it's an operator

	sub	ax, 7

	mov	word[n2], ax

	jmp	decide

	

operator:

	mov	word[action], ax

	jmp	atoi

decide:

	cmp	word[n2], 0

	je	atoi

	cmp	word[action], 1

	je	multiplication

	cmp	word[action], 2

	je	addition

	cmp	word[action], 4

	je	subtraction

	cmp	word[action], 6

	je	division

	

	

multiplication:

	

addition:

	xor	rax, rax

	mov	dx, 0

	mov	ax, word[n1]	

	add	ax, word[n2]	

	mov	word[n1], ax

	jmp	atoi

subtraction:

	

division:



itoa:

	mov	ax, word[n1]

	add	ax, 48	

	mov	word[n1], ax

	

	print	n1, 10

	

	

	

	;end of program

	mov	rax, 60

	mov	rdi, 0

	syscall
