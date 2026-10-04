

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
	lsl	r2, r1, #3		@ r2 <- x * 8
	lsl	r3, r1, #1		@ r3 <- x * 2
	add	r2, r2, r3		@ r2 <- x * 8 + x * 2 = x * 10

	ldr	r0, =output		@ r0 <- address of output format
	bl	printf			@ printf(output, x, x * 10)

	ldr	lr, [sp, #0]		@ restore lr
	add	sp, sp, #4		@ release stack space
	mov	pc, lr			@ return to caller
.data
	number:	.word 0
	scanFormat:	.asciz "%d"
	prompt:	.asciz "Enter an integer: "
	output:	.asciz "%d times 10 is %d\n"





