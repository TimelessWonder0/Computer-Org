
.text
.global main
main:
	sub 	sp, sp, #8
	STR	lr, [sp, #0 ]


	ldr 	r0, = promptMessage
	bl	printf

	ldr	r0, = inputFormat
	ldr 	r1, = age
	bl	scanf

	ldr	r0, = outputFormat
	ldr	r1, = age
	ldr 	r1, [r1]
	bl 	printf

	
	LDR 	lr, [sp,#0]    	
	ADD 	sp, #4
	MOV	pc, lr



.data
	promptMessage: .asciz "Enter your age: "
	inputFormat: .asciz "%d"
	outputFormat: .asciz "Your age is: %d\n"
	age: .word 0



