


.text
.global main
main:
	sub	sp, sp, #4		@ make room on the stack for lr
	str	lr, [sp, #0]		@ save lr

	ldr	r0, =promptA		@ r0 <- address of first prompt
	bl	printf			@ print the prompt
	ldr	r0, =scanFormat		@ r0 <- address of "%d"
	ldr	r1, =valueA		@ r1 <- address where scanf stores a
	bl	scanf			@ read a into memory

	ldr	r0, =promptB		@ r0 <- address of second prompt
	bl	printf			@ print the prompt
	ldr	r0, =scanFormat		@ r0 <- address of "%d"
	ldr	r1, =valueB		@ r1 <- address where scanf stores b
	bl	scanf			@ read b into memory

	ldr	r1, =valueA		@ r1 <- address of a
	ldr	r1, [r1]		@ r1 <- a
	ldr	r2, =valueB		@ r2 <- address of b
	ldr	r2, [r2]		@ r2 <- b
	ldr	r0, =before		@ r0 <- address of "before" format
	bl	printf			@ print r1 and r2 before the swap

	
	ldr	r1, = valueA
	ldr	r1, [r1]
	ldr	r2, = valueB
	ldr	r2, [r2]


	EOR	r1, r1, r2
	EOR 	r2, r1, r2
	EOR	r1, r1, r2
	
	ldr	r0, = after
	bl 	printf



	ldr	lr, [sp, #0]		@ restore lr
	add	sp, sp, #4		@ release stack space
	mov	pc, lr			@ return to caller


.data
	valueA:		.word 0
	valueB:		.word 0
	scanFormat:	.asciz "%d"
	promptA:	.asciz "Enter the first integer: "
	promptB:	.asciz "Enter the second integer: "
	before:	.asciz "Before swap: r1 = %d, r2 = %d\n"
	after:	.asciz "After swap:  r1 = %d, r2 = %d\n"






