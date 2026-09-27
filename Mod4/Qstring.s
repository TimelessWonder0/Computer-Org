
.text
.global main
main:

	sub	sp, sp, #4
	str 	lr, [sp, #0]

	ldr 	r0, = outString
	bl	printf

	ldr	lr, [sp, #0]
	add	sp, sp, #4
	mov	pc, lr


.data

	outString: .asciz "This is my output \"Hello world\"\n"









