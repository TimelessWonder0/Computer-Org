
@ libFunctions.s
@ Library of conversion functions. Arguments come in r0, r1; result returns in r0.


@ miles2kilometer(int miles)
@ Input:  r0 = miles
@ Output: r0 = kilometers = (miles * 161) / 100
@
@ Why this method: 1 mile = 1.609344 km. We approximate that as 1.61 = 161/100
@ so the whole conversion can be done with integer multiply and divide
@ (no floating point needed). We multiply BEFORE dividing so the fractional
@ part is not truncated away too early.
@
@ Greater precision: use a more exact ratio such as (miles * 1609344) / 100000


.text
.global miles2kilometer
miles2kilometer:			@ takes int miles (r0) as input

	sub	sp, sp, #4		@ make room on the stack for lr
	str	lr, [sp, #0]		@ save lr (bl below overwrites it)

	@ Formula: (miles x 161) / 100

	mov	r1, #161		@ r0 contains miles, put 161 in r1
	mul	r0, r0, r1		@ r0 = miles * 161
	mov	r1, #100
	bl	__aeabi_idiv		@ r0 = r0 / 100

	ldr	lr, [sp, #0]		@ restore lr
	add	sp, sp, #4		@ release stack space (must match the sub)
	mov	pc, lr			@ return to caller

.data
@ End miles2kilometer


@ kph(int hours, int miles)
@ Input:  r0 = hours, r1 = miles
@ Output: r0 = kilometers per hour = miles2kilometer(miles) / hours
@
@ hours is saved on the stack because miles2kilometer (and __aeabi_idiv)
@ are free to overwrite r0-r3.

.text
.global kph
kph:					@ takes int hours (r0) and int miles (r1)

	sub	sp, sp, #8		@ make room on the stack for lr and hours
	str	lr, [sp, #0]		@ save lr

	str	r0, [sp, #4]		@ save hours (original r0) on the stack

	mov	r0, r1			@ miles becomes the argument to miles2kilometer
	bl	miles2kilometer		@ r0 = kilometers

	ldr	r1, [sp, #4]		@ r1 = hours
	bl	__aeabi_idiv		@ r0 = kilometers / hours

	ldr	lr, [sp, #0]		@ restore lr
	add	sp, sp, #8		@ release stack space
	mov	pc, lr			@ return to caller

.data
@ End kph


@ CToF(int celsius)
@ Input:  r0 = degrees Celsius
@ Output: r0 = degrees Fahrenheit = (C * 9) / 5 + 32
@
@ Multiply by 9 BEFORE dividing by 5 so precision isn't lost to truncation.
.text
.global CToF
CToF:					@ input is celsius (r0)

	sub	sp, sp, #4		@ make room on the stack for lr
	str	lr, [sp, #0]		@ save lr

	@ Equation is (C x 9 / 5) + 32

	mov	r1, #9
	mul	r0, r0, r1		@ multiply by 9

	mov	r1, #5
	bl	__aeabi_idiv		@ divide by 5

	add	r0, r0, #32		@ add 32

	ldr	lr, [sp, #0]		@ restore lr
	add	sp, sp, #4		@ release stack space
	mov	pc, lr			@ return to caller

.data
@ End CToF


@ InchesToFt(int inches)
@ Input:  r0 = inches
@ Output: r0 = whole feet = inches / 12
@
@ Integer division truncates, so leftover inches are dropped
@ (e.g. 30 inches -> 2 feet, 9 inches -> 0 feet).
.text
.global InchesToFt
InchesToFt:				@ takes inches (r0) as input

	sub	sp, sp, #4		@ make room on the stack for lr
	str	lr, [sp, #0]		@ save lr

	@ Formula is feet = inches / 12

	mov	r1, #12			@ divisor: 12 inches per foot
	bl	__aeabi_idiv		@ r0 = inches / 12

	ldr	lr, [sp, #0]		@ restore lr
	add	sp, sp, #4		@ release stack space
	mov	pc, lr			@ return to caller

.data
@ End InchesToFt



