
.text
.global miles2kilometer
miles2kilometer: 			@takes int miles as input

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
@End miles to km

.text
.global kph
kph:					@takes int hours (r0) and int miles (r1) as input

	sub	sp, sp, #8		@ make room on the stack for lr
	str	lr, [sp, #0]		@ save lr

	str	r0, [sp, #4]		@save hours into the sp
	
	mov	r0, r1
	bl	miles2kilometer

	ldr	r1, [sp,#4]
	bl	__aeabi_idiv


	ldr    lr, [sp, #0]
    	add    sp, sp, #8
    	mov    pc, lr

.data
@End kph


.text
.global CToF
CToF:					@ input is celcius (r0)

	sub	sp, sp, #4		@ make room on the stack for lr
	str	lr, [sp, #0]		@ save lr

	@Equation is (C x 9/5)+32
	
	mov	r1, #9
	mul	r0, r0, r1		@Multiply by 9

	mov	r1, #5	
	bl	__aeabi_idiv		@ Divide by 5

	add	r0, r0, #32		@add 32


	ldr	lr, [sp, #0]		@ restore lr
	add	sp, sp, #4		@ release stack space
	mov	pc, lr			@ return to caller


.data
@End CToF



.text
.global InchesToFeet
InchesToFeet:				@Takes input of Inches (r0)

	sub	sp, sp, #4		@ make room on the stack for lr
	str	lr, [sp, #0]		@ save lr

	@Formula is feet = inches/12 
	
	mov 	r1, #12			@store 12
	bl	__aeabi_idiv		@divide


	ldr 	lr, [sp, #0]
	add	sp, sp, #4
	mov	pc, lr


.data
@End InchesToFeet



