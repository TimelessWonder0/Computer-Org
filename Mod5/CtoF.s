
.text
.global main
main:

	sub 	sp, sp, #4
	str	lr, [sp, #0]

	sub	sp, sp, #4		@ make room on the stack for lr
	str	lr, [sp, #0]		@ save lr

	ldr	r0, =prompt		@ r0 <- address of prompt string
	bl	printf			@ print the prompt

	ldr	r0, =scanFormat		@ r0 <- address of "%d"
	ldr	r1, =celsius		@ r1 <- address where scanf stores C
	bl	scanf			@ read C into memory

	ldr	r1, =celsius		@ r1 <- address of C
	ldr	r1, [r1]		@ r1 <- C
	mov	r2, #9			@ MUL has no immediate form
	mul	r0, r1, r2		@ r0 <- C * 9  (multiply first)
	mov	r1, #5			@ r1 <- divisor
	bl	__aeabi_idiv		@ r0 <- (C * 9) / 5
	add	r2, r0, #32		@ r2 <- (C * 9 / 5) + 32 = F

	ldr	r1, =celsius		@ reload C (r1 was changed by the call)
	ldr	r1, [r1]		@ r1 <- C
	ldr	r0, =output		@ r0 <- address of output format
	bl	printf			@ printf(output, C, F)

	ldr	lr, [sp, #0]		@ restore lr
	add	sp, sp, #4		@ release stack space
	mov	pc, lr			@ return to caller



	ldr 	lr, [sp, #0]
	add	sp, sp, #4
	mov	pc, lr


.data
	
	celsius:	.word 0
	scanFormat:	.asciz "%d"
	prompt:	.asciz "Enter temperature in Celsius: "
	output:	.asciz "%d degrees Celsius is %d degrees Fahrenheit\n"






