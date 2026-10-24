
.text
.global main
main:

	sub	sp, sp, #4		@ make room on the stack for lr
	str	lr, [sp, #0]		@ save lr

	@ Formula: (miles x 161) / 100

	mov 	r1, #161 		@move 161 into r1, r0 contains the mph
	mul	r0, r0, r1
	mov	r1, #100
	bl	__aeabi_idiv

	ldr 	lr, [sp, #0]
	add	sp, sp, #5
	mov	pc, lr

.data

#End miles to km







