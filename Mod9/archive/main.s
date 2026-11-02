
.data
	ialpha: .asciz 
	falpha: .asciz "%c"
	palpha: .asciz "Enter a Character:\n"
	yes: .asciz "Y"
	no: .asciz "N"
	outStr: .asciz "alphabetic char: %c"


	fmax: .asciz "%d %d %d"
	pMax: .asciz "Enter 3 integers seperated by a space: "
	val1: .word 0
	val2: .word 0
	val3: .word 0
	outstr: .asciz "The Max value is: %d"
	


	pName: .asciz "Enter a Name: "
	pGrade: .asciz "Enter a Grade: "
	name: .asciz 
	grade: .word 0
	fstr: .asciz "%s"
	fint: .asciz "%d"
	outstr: .asciz "%s has a(n) %c"


.text
.global main
main:

	sub	sp, sp, #4
	str	lr, [sp, #0]

@Test the CheckAlphaLog
	ldr	r0, = palpha
	bl	printf

	ldr	r0, = falpha
	ldr	r1, = isalpha
	bl	scanf

	ldr	r0, = isalpha
	ldr	r0, [r0]
	bl	ChkAlphaLOG

	cmp	r0, #0
	ldrgt	r1, =yes
	ldrle	r1, =no

	
	ldr	r0,= outStr
	bl	printf
	

@Test AlphaNoLog
	ldr 	r0, = palpha
	bl	printf

	ldr 	r0, = falpha
	ldr	r1, = isalpha
	bl	scanf

	ldr 	r0, = isalpha
	ldr	r0, [r0]
	bl	ChkAlphaNOLOG
	
@test findMAXOf3
	ldr 	r0, = pMax
	bl	printf

	ldr	r0, = fmax
	ldr	r1, = val1
	ldr	r2, = val2
	ldr	r3, = val3
	bl	scanf

	ldr	r0, =val1
	ldr 	r0, [r0]

	ldr	r1, = val2
	ldr	r1, [r1]
	
	ldr	r2, = val3
	ldr	r2, [r2]

	bl 	findMAXOf3
	
	mov	r1, r0
	ldr	r0, = outstr
	bl 	printf

@ Grade Test
	ldr	r0, = pName
	bl	printf

	ldr	r0, = fstr
	ldr	r1, = name
	bl 	scanf

	ldr	r0, = pGrade
	bl	printf

	ldr 	r0, =fint
	ldr	r1, = grade
	bl	scanf

	ldr 	r0, = grade
	ldr	r0, [r0]
	bl	Grade

	mov	r2, r0
	ldr	r0, = outStr
	ldr	r1, = name
	bl	printf


	ldr	lr, [sp,#0]
	add	sp, sp, #4
	mov	pc, lr


