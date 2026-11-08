

@ Program: Computer guesses the user's number (binary search)
@ The user thinks of a secret number from 1 to a maximum they enter.
@ The computer guesses the middle of the remaining range each time.
@ The user answers: 1 = higher, 2 = lower, 3 = correct.
@ The range is narrowed after every answer until the guess is correct.

.data
    mStr:     .asciz "\nEnter the Maximum Value: "
    gStr:     .asciz "\nIs your number %d? Enter 1 = higher, 2 = lower, 3 = correct: "
    eStr:     .asciz "\nI got it! Your number is %d and it took me %d guesses!\n"
    errStr:   .asciz "\nError: the maximum value must be at least 1.\n"
    badStr:   .asciz "\nInvalid answer. Please enter 1, 2, or 3."
    cheatStr: .asciz "\nThat's impossible - your answers were inconsistent.\n"

    maxval:   .word 0                    @ maximum value entered by the user
    low:      .word 1                    @ lowest number still possible
    high:     .word 0                    @ highest number still possible
    guess:    .word 0                    @ the computer's current guess
    resp:     .word 0                    @ user's answer (1, 2, or 3)
    gcount:   .word 1                    @ number of guesses made (first guess counts as 1)

    dstring:  .asciz "%d"
    sstring:  .asciz "%s"

.text
.global main

main:
    sub sp, sp, #4
    str lr, [sp,#0]

    @ Ask for the maximum value 
    ldr r0, = sstring
    ldr r1, = mStr
    bl printf

    ldr r0, = dstring
    ldr r1, = maxval
    bl scanf

    @  Validate: maximum must be >= 1 
    ldr r0, = maxval
    ldr r0, [r0]                         @ r0 = maxval
    cmp r0, #1
    blt maxError                         @ maxval < 1 -> print error and quit

    @ Initialize the search range: low = 1, high = maxval, count = 1
    ldr r1, = high
    str r0, [r1]                         @ high = maxval (r0 still holds maxval)

    mov r0, #1
    ldr r1, = low
    str r0, [r1]                         @ low = 1
    ldr r1, = gcount
    str r0, [r1]                         @ gcount = 1

@  Guessing loop 
uStart:
    ldr r0, = low
    ldr r0, [r0]                         @ r0 = low
    ldr r1, = high
    ldr r1, [r1]                         @ r1 = high

    cmp r0, r1
    bgt cheat                            @ low > high -> no number is possible

    add r0, r0, r1                       @ r0 = low + high
    mov r0, r0, lsr #1                   @ r0 = (low + high) / 2  (shift right 1 = divide by 2)
    ldr r1, = guess
    str r0, [r1]                         @ save the guess

@ Ask the user about the guess
ask:
    ldr r0, = gStr                       @ format string contains %d
    ldr r1, = guess
    ldr r1, [r1]                         @ r1 = guess (fills the %d)
    bl printf

    ldr r0, = dstring
    ldr r1, = resp
    bl scanf

    ldr r0, = resp
    ldr r0, [r0]                         @ r0 = user's answer

    cmp r0, #3
    beq end                              @ 3 = correct
    cmp r0, #1
    beq goHigher                         @ 1 = number is higher than guess
    cmp r0, #2
    beq goLower                          @ 2 = number is lower than guess

    @ Anything else: invalid answer
    ldr r0, = sstring
    ldr r1, = badStr
    bl printf
    b ask

goHigher:
    ldr r0, = guess
    ldr r0, [r0]
    add r0, r0, #1                       @ new low = guess + 1
    ldr r1, = low
    str r0, [r1]
    b nextGuess

goLower:
    ldr r0, = guess
    ldr r0, [r0]
    sub r0, r0, #1                       @ new high = guess - 1
    ldr r1, = high
    str r0, [r1]

nextGuess:
    ldr r0, = gcount
    ldr r0, [r0]
    add r0, r0, #1                       @ gcount++
    ldr r1, = gcount
    str r0, [r1]
    b uStart

@ Correct guess: report result
end:
    ldr r0, = eStr                       @ format string
    ldr r1, = guess
    ldr r1, [r1]                         @ first %d = the number
    ldr r2, = gcount
    ldr r2, [r2]                         @ second %d = number of guesses
    bl printf
    b exit

@ Invalid maximum: report error
maxError:
    ldr r0, = sstring
    ldr r1, = errStr
    bl printf
    b exit

@ Inconsistent answers: report error
cheat:
    ldr r0, = sstring
    ldr r1, = cheatStr
    bl printf

@ Restore return address and return
exit:
    ldr lr, [sp, #0]
    add sp, sp, #4
    mov pc, lr








