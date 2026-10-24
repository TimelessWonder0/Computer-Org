@ main.s
@ Prompts for input and tests each function in libFunctions.s:
@   miles2kilometer, kph, CToF, InchesToFt
@ All I/O goes through the C library (printf / scanf).

.text
.global main
main:
	sub	sp, sp, #8		@ make room on the stack (8 keeps it aligned)
	str	lr, [sp, #0]		@ save lr

	@ ---------- miles -> kilometers ----------
	ldr	r0, =pmiles		@ prompt for miles
	bl	printf

	ldr	r0, =sformat
	ldr	r1, =miles		@ scanf needs the ADDRESS of miles
	bl	scanf

	ldr	r0, =miles
	ldr	r0, [r0]		@ r0 = value of miles
	bl	miles2kilometer		@ r0 = kilometers

	mov	r1, r0			@ km goes in r1 for printf
	ldr	r0, =pkm
	bl	printf

	@ ---------- kilometers per hour ----------
	ldr	r0, =pmiles		@ prompt for miles
	bl	printf

	ldr	r0, =sformat
	ldr	r1, =miles
	bl	scanf

	ldr	r0, =phours		@ prompt for hours
	bl	printf

	ldr	r0, =sformat
	ldr	r1, =hours
	bl	scanf

	ldr	r0, =hours
	ldr	r0, [r0]		@ r0 = hours (first argument)
	ldr	r1, =miles
	ldr	r1, [r1]		@ r1 = miles (second argument)
	bl	kph			@ r0 = km / hours

	mov	r1, r0
	ldr	r0, =pkph
	bl	printf

	@ ---------- Celsius -> Fahrenheit ----------
	ldr	r0, =pcelsius		@ prompt for celsius
	bl	printf

	ldr	r0, =sformat
	ldr	r1, =celsius
	bl	scanf

	ldr	r0, =celsius
	ldr	r0, [r0]		@ r0 = celsius
	bl	CToF			@ r0 = fahrenheit

	mov	r1, r0
	ldr	r0, =pfahr
	bl	printf

	@ ---------- inches -> feet ----------
	ldr	r0, =pinches		@ prompt for inches
	bl	printf

	ldr	r0, =sformat
	ldr	r1, =inches
	bl	scanf

	ldr	r0, =inches
	ldr	r0, [r0]		@ r0 = inches
	bl	InchesToFt		@ r0 = whole feet

	mov	r1, r0
	ldr	r0, =pfeet
	bl	printf

	mov	r0, #0			@ return 0 from main
	ldr	lr, [sp, #0]		@ restore lr
	add	sp, sp, #8		@ release stack space
	mov	pc, lr			@ return to caller

.data
pmiles:		.asciz "Enter miles: "
phours:		.asciz "Enter hours: "
pcelsius:	.asciz "Enter degrees Celsius: "
pinches:	.asciz "Enter inches: "

sformat:	.asciz "%d"

pkm:		.asciz "That is %d km\n"
pkph:		.asciz "That is %d km/h\n"
pfahr:		.asciz "That is %d degrees Fahrenheit\n"
pfeet:		.asciz "That is %d feet\n"

.align 2
miles:		.word 0
hours:		.word 0
celsius:	.word 0
inches:		.word 0

@ End main
