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

	buffer	resb	16

	n1	resw	1

	n2	resw	1

	action	resw	1

	

section .data

	msg1	db	"Input an expression: "		;21

	msg2	db	"Answer: "			;8

	ascii		db	"0", 10

	ascii10		db	"00", 10

	ascii100	db	"000", 10

	ascii1000	db	"0000", 10

	ascii10000	db	"00000", 10

	

section .text

	global _start

_start:

	print	msg1, 21

	input	buffer, 16

	

	mov	rsi, 16

	

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

	sub	ax, 48

	mov	word[n1], ax

	

atoi:

	;extract operator / n2

	xor	rax, rax

	pop	rax			;ax = top of stack

	cmp	ax, 10			;jump to end if /n

	je	itoa

	sub	ax, 41

	cmp	ax, 7

	jl	operator		;jump if it's an operator (ax < 7)

	sub	ax, 7

	mov	word[n2], ax

	jmp	decide

	

operator:

	mov	word[action], ax	;save operator

	jmp	atoi			;get n2

decide:

	cmp	word[action], 1		; (*)

	je	multiplication

	cmp	word[action], 2		; (+)

	je	addition

	cmp	word[action], 4		; (-)

	je	subtraction

	cmp	word[action], 6		; (/)

	je	division

	

	

multiplication:

	xor	rax, rax

	mov	dx, 0

	mov	ax, word[n1]

	mov	bx, word[n2]

	mul	bx

	mov	word[n1], ax

	jmp	atoi		;get next operator

addition:

	xor	rax, rax

	mov	dx, 0

	mov	ax, word[n1]	

	add	ax, word[n2]	

	mov	word[n1], ax

	jmp	atoi		;get next operator

subtraction:

	xor	rax, rax

	mov	dx, 0

	mov	ax, word[n1]

	sub	ax, word[n2]

	mov	word[n1], ax

	jmp	atoi		;get next operator

division:

	xor	rax, rax

	mov	dx, 0

	mov	ax, word[n1]

	mov	bx, word[n2]

	div	bx

	mov	word[n1], ax

	jmp	atoi		;get next operator



itoa:

	xor	rax, rax

	mov	ax, word[n1]

	cmp	ax, 10

	jl	convert1	;1 digit answer

	cmp	ax, 100

	jl	convert10s	;10 digit answer

	cmp	ax, 1000

	jl	convert100s	;100 digit answer

	cmp	ax, 10000

	jl	convert1000s	;1000 digit answer

	jge	convert10000s	;10000 digit answer



convert1:

	mov	ax, word[n1]

	add	byte[ascii], al

	print	msg2, 8

	print	ascii, 2

	jmp	end

	

convert10s:

	mov	rcx, 1

convert10:

	mov	dx, 0

	mov	bx, 10

	div	bx

	add	byte[ascii10+rcx], dl

	dec	rcx

	cmp	rcx, 0

	jge	convert10

	print	msg2, 8

	print	ascii10, 3

	jmp	end

	

convert100s:

	mov	rcx, 2

convert100:

	mov	dx, 0

	mov	bx, 10

	div	bx

	add	byte[ascii100+rcx], dl

	dec	rcx

	cmp	rcx, 0

	jge	convert100

	print	msg2, 8

	print	ascii100, 4

	jmp	end



convert1000s:

	mov	rcx, 3

convert1000:

	mov	dx, 0

	mov	bx, 10

	div	bx

	add	byte[ascii1000+rcx], dl

	dec	rcx

	cmp	rcx, 0

	jge	convert1000

	print	msg2, 8

	print	ascii1000, 5

	jmp	end



convert10000s:

	mov	rcx, 4

convert10000:

	mov	dx, 0

	mov	bx, 10

	div	bx

	add	byte[ascii10000+rcx], dl

	dec	rcx

	cmp	rcx, 0

	jge	convert10000

	print	msg2, 8

	print	ascii10000, 6

	jmp	end

	

itoabegin:

	mov	r10, 6

	xor	rdx, rdx

	mov	bx, 10

	mov	ax, word[ascii10000]



betteritoa:

	xor	rax, rax

	xor	rdx, rdx

	div	bx

	add	byte[ascii10000+r10], dl

	cmp	r10, 0

	jge	betteritoa

	xor	r10, r10

itoacntr:

	;count how many 0's in the beginning

	;store amt of 0s in r10

	;add r10 to address of n1 and print

	xor	rax, rax

	cmp	byte[ascii10000+r10], 0

	inc	r10

	je	itoacntr

	

	





end:

	;end of program

	mov	rax, 60

	mov	rdi, 0

	syscall
