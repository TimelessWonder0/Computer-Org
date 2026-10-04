

.text
.global main
main:
	sub	sp, sp, #4		@ make room on the stack for lr
	str	lr, [sp, #0]		@ save lr

	ldr	r0, =prompt		@ r0 <- address of prompt string
	bl	printf			@ print the prompt

	ldr	r0, =scanFormat		@ r0 <- address of "%d"
	ldr	r1, =number		@ r1 <- address where scanf stores x
	bl	scanf			@ read x into memory

	ldr	r1, =number		@ r1 <- address of x
	ldr	r1, [r1]		@ r1 <- x
	mvn	r2, r1			@ r2 <- one's complement of x
	add	r2, r2, #1		@ r2 <- one's complement + 1 = -x

	ldr	r0, =output		@ r0 <- address of output format
	bl	printf			@ printf(output, x, -x)

	ldr	lr, [sp, #0]		@ restore lr
	add	sp, sp, #4		@ release stack space
	mov	pc, lr			@ return to caller
.data
	number:	.word 0
	scanFormat:	.asciz "%d"
	prompt:	.asciz "Enter an integer: "
	output:	.asciz "The negative of %d is %d\n"








