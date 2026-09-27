
.text
.global main
main:

	sub	lr, sp, #4
	str 	sp, [sp,#0]

	ldr	r0, = inStr
	bl	printf

	ldr	r0, = type
	ldr 	r1, = var
	bl	scanf

	mov



	ldr	sp, [sp,#0]
	add	sp, sp, #4
	mov	pc, lr




.data

	inStr: .asciz "type in a floating point number:"
	type: "%f"
	var: .word 0.0
	outStr: .asciz "Your floating point number is: %f"
	













