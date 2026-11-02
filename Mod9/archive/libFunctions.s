

.data


.text
.global ChkAlphaLOG
ChkAlphaLOG:

	@save the link register
	sub	sp, sp, #4
	str 	lr, [sp,#0]


@r0 contains the char, I need to test to see if its a letter. 

	ldr 	r1, r0
	ldr 	r1, [r1]

@load up the comparison values
	mov	r0, #0
	mov	r2, #0

@r1 greater than A
	cmp	r1, #0x41
	addgt	r0, #1

@r1 less than Z
	cmp 	r1, #0x5A
	addlt	r2, #1

@make sure both are true
	and	r0, r0, r2

@The lowercase side
	mov 	r2, #0
	mov	r3, #0

@r1 greater than a
	cmp	r1, #0x61
	addgt	r2, #1

@r1 less than z
	cmp	r1, #0x7A
	addlt	r3, #1

@make sure both are true
	and	r2, r2, r3

@make sure one of the 2 are true
	orr	r0, r0, r2


	@bring back the link register
	ldr	lr, [sp, #0]
	add	sp, sp, #4
	mov	pc, lr

@END ChkAlphaLOG

.data


.text
.global ChkAlphaNOLOG
ChkAlphaNOLOG:

@save lr
	sub	sp, sp, #4
	str	lr, [sp, #0]

@r0 contains the character

@check to make sure its not below A
	cmp	r0, #0x41
	blt	notAlpha

@under Z
	cmp	r0, #0x5A
	ble	alpha

@not below A
	cmp	r0, #0x61
	blt	notAlpha

@below Z
	cmp	r0, #0x7A
	ble	alpha

@else
	b 	notAlpha


alpha:
	mov	r0, #1
	b	end

notAlpha:
	mov	r0, #0

end:


@return to lr
	ldr	lr, [sp, #0]
	add	sp, sp, #4
	mov	pc, lr

@END ChkAlphaNOLOG

.data


.text
.global findMAXof3
findMAXof3:

	sub	sp, sp, #4
	str	lr, [sp,#0]


@r0 is num1, r1 is num2, r2 is num3

@intialize r3 as r0, do Cmp against the next and the next

	ldr 	r3, r0
	ldr	r3, [r3]

	cmp	r1, r3
	movgt	r3, r1
	
	cmp	r2, r3
	movgt	r3, r2

	mov	r0, r3
	mov	r0, [r0]

@load lr
	ldr	lr, [sp, #0]
	add	sp, sp, #4
	mov	pc, lr

@END findMAXof3

.data
	fstring: .asciz "The number is not between 0 and 100/n"

.text
.global Grade

Grade:

	sub	sp, sp, #4
	str	lr, [sp, #0]

@input is grade in r0
	cmp	r0, #100
	movgt	error

	cmp	r0, #0
	movlt	error

	cmp	r0, #90
	movgt	r0, #A
	movgt	end	

	cmp	r0, #80
	movgt	r0, #B
	movgt	end

	cmp	r0, #70
	movgt	r0, #C
	movgt 	end

	mov	r0, #F
	mov	end


error:
	ldr	r0, = fstring
	bl	printf

end:

	ldr	lr, [sp, #0]
	add	sp, sp, #4
	mov	pc, lr


@END Grade


