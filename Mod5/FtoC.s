



.text
.global main
main:
	sub	sp, sp, #4		@ make room on the stack for lr
	str	lr, [sp, #0]		@ save lr

	ldr	r0, =prompt		@ r0 <- address of prompt string
	bl	printf			@ print the prompt

	ldr	r0, =scanFormat		@ r0 <- address of "%d"
	ldr	r1, =fahr		@ r1 <- address where scanf stores F
	bl	scanf			@ read F into memory

	ldr	r1, =fahr		@ r1 <- address of F
	ldr	r1, [r1]		@ r1 <- F
	sub	r1, r1, #32		@ r1 <- F - 32
	mov	r2, #5			@ MUL has no immediate form
	mul	r0, r1, r2		@ r0 <- (F - 32) * 5  (multiply first)
	mov	r1, #9			@ r1 <- divisor
	bl	__aeabi_idiv		@ r0 <- ((F - 32) * 5) / 9
	mov	r2, r0			@ r2 <- C (printf's 3rd argument)

	ldr	r1, =fahr		@ reload F (r1 was changed by the call)
	ldr	r1, [r1]		@ r1 <- F
	ldr	r0, =output		@ r0 <- address of output format
	bl	printf			@ printf(output, F, C)

	ldr	lr, [sp, #0]		@ restore lr
	add	sp, sp, #4		@ release stack space
	mov	pc, lr			@ return to caller
.data
	fahr:		.word 0
	scanFormat:	.asciz "%d"
	prompt:	.asciz "Enter temperature in Fahrenheit: "
	output:	.asciz "%d degrees Fahrenheit is %d degrees Celsius\n"









