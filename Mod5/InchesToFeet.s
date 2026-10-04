

.text
.global main
main:
	sub	sp, sp, #4		@ make room on the stack for lr
	str	lr, [sp, #0]		@ save lr

	ldr	r0, =prompt		@ r0 <- address of prompt string
	bl	printf			@ print the prompt

	ldr	r0, =scanFormat		@ r0 <- address of "%d"
	ldr	r1, =total		@ r1 <- address where scanf stores total
	bl	scanf			@ read total inches into memory

	ldr	r0, =total		@ r0 <- address of total
	ldr	r0, [r0]		@ r0 <- total (the dividend)
	mov	r1, #12			@ r1 <- divisor
	bl	__aeabi_idiv		@ r0 <- total / 12 = feet

	ldr	r1, =total		@ r1 <- address of total
	ldr	r1, [r1]		@ r1 <- total (reload after the call)
	mov	r2, #12			@ MUL has no immediate form
	mul	r3, r0, r2		@ r3 <- feet * 12
	sub	r3, r1, r3		@ r3 <- total - feet * 12 = remainder
	mov	r2, r0			@ r2 <- feet (printf's 3rd argument)

	ldr	r0, =output		@ r0 <- address of output format
	bl	printf			@ printf(output, total, feet, inches)

	ldr	lr, [sp, #0]		@ restore lr
	add	sp, sp, #4		@ release stack space
	mov	pc, lr			@ return to caller
.data
	total:		.word 0
	scanFormat:	.asciz "%d"
	prompt:	.asciz "Enter total inches: "
	output:	.asciz "%d inches is %d feet %d inches\n"





