
.text
.global main
main:

	sub	sp, sp, #4
	str	lr, [sp, #0]


	ldr	r0, = inString
	bl 	printf


	ldr	r0, =formatString
	ldr	r1, =num
	bl	scanf

	ldr 	r0, = outString
	ldr	r1, = num
	ldr	r1, [r1]
	bl	printf


	ldr 	lr, [sp,#0]
	add 	sp, sp, #4
	mov 	pc, lr


.data
	inString: .asciz "Enter a number: "
	formatString: .asciz "%d"
	outString: .asciz "Here is your number:\t %d \t seperated by tabs! \n"
	num: .word 0








