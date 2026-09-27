
.text
.global main
main:

	sub	sp, sp, #8
	str	lr, [sp, #0]

	ldr	r0, = inStr
	bl	printf

	ldr	r0, = type
	ldr	r1, = floatvar
	bl	scanf

	ldr	r0, = floatvar
	vldr	s0, [r0]
	vcvt.f64.f32	d0,s0

	ldr 	r0, = outStr
	vmov	r2,r3,d0	
	bl 	printf

	ldr	lr, [sp,#0]
	add	sp, sp, #8
	mov	pc, lr


.data

	inStr: .asciz "Enter your floating point number: "
	.align 2
	floatvar: .float 0.0
	type: .asciz "%f"
	outStr: .asciz "Your floating point number is: %f\n"











