

.text
.global main
main:
	sub	sp, sp, #4		@ make room on the stack for lr
	str	lr, [sp, #0]		@ save lr

	ldr	r0, =promptFeet		@ r0 <- address of feet prompt
	bl	printf			@ print the prompt
	ldr	r0, =scanFormat		@ r0 <- address of "%d"
	ldr	r1, =feet		@ r1 <- address where scanf stores feet
	bl	scanf			@ read feet into memory

	ldr	r0, =promptInches	@ r0 <- address of inches prompt
	bl	printf			@ print the prompt
	ldr	r0, =scanFormat		@ r0 <- address of "%d"
	ldr	r1, =inches		@ r1 <- address where scanf stores inches
	bl	scanf			@ read inches into memory

	ldr	r1, =feet		@ r1 <- address of feet
	ldr	r1, [r1]		@ r1 <- feet
	ldr	r2, =inches		@ r2 <- address of inches
	ldr	r2, [r2]		@ r2 <- inches
	mov	r3, #12			@ MUL has no immediate form
	mul	r0, r1, r3		@ r0 <- feet * 12
	add	r3, r0, r2		@ r3 <- feet * 12 + inches = total

	ldr	r0, =output		@ r0 <- address of output format
	bl	printf			@ printf(output, feet, inches, total)

	ldr	lr, [sp, #0]		@ restore lr
	add	sp, sp, #4		@ release stack space
	mov	pc, lr			@ return to caller
.data
	feet:		.word 0
	inches:		.word 0
	scanFormat:	.asciz "%d"
	promptFeet:	.asciz "Enter feet: "
	promptInches:	.asciz "Enter inches: "
	output:	.asciz "%d feet %d inches is %d total inches\n"









