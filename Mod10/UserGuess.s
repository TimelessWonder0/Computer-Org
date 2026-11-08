@ Program: User guesses the computer's number
@ Asks for a maximum value, picks a hidden number from 1 to max,
@ then loops on the user's guesses, printing "Too Low" / "Too High"
@ until correct, and finally reports the number of guesses.

.data
    @ ---- Strings ----
    mStr:    .asciz "\nEnter the Maximum Value: "
    gStr:    .asciz "\nEnter your Guess: "
    eStr:    .asciz "\nYou are correct! the answer is %d you got it in %d tries!"
    errStr:  .asciz "\nError: the maximum value must be at least 1."
    higher:  .asciz "\nToo Low"           @ shown when the guess is below the answer
    lower:   .asciz "\nToo High"          @ shown when the guess is above the answer

    @ ---- Variables ----
    maxval:  .word 0                     @ maximum value entered by the user
    randval: .word 0                     @ hidden number (1..maxval)
    guess:   .word 0                     @ the user's latest guess
    gcount:  .word 1                     @ number of guesses so far (first guess counts as 1)

    @ ---- Format strings for printf/scanf ----
    sstring: .asciz "%s"
    dstring: .asciz "%d"

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

    @ Validate: maximum must be >= 1
    ldr r0, = maxval
    ldr r0, [r0]                         @ r0 = maxval
    cmp r0, #1
    blt maxError                         @ maxval < 1 -> print error and quit

    @ Create a random number
    mov r0, #0                           @ time(0) takes a NULL pointer
    bl time                              @ r0 = current time
    bl srand                             @ seed the generator with r0 (done once, before the loop)
    bl rand                              @ r0 = large random number
    ldr r1, = randval
    str r0, [r1]                         @ save the raw random number

    @ Compute remainder: randval - (randval / maxval) * maxval
    ldr r0, = randval
    ldr r0, [r0]                         @ numerator = randval
    ldr r1, = maxval
    ldr r1, [r1]                         @ denominator = maxval
    bl __aeabi_idiv                      @ r0 = randval / maxval (quotient)

    mov r1, r0                           @ r1 = quotient
    ldr r0, = maxval
    ldr r0, [r0]                         @ r0 = maxval
    mul r0, r0, r1                       @ r0 = quotient * maxval

    ldr r1, = randval
    ldr r1, [r1]                         @ r1 = original random number
    sub r0, r1, r0                       @ r0 = remainder (0 .. maxval-1)
    add r0, r0, #1                       @ shift range to 1 .. maxval

    ldr r1, = randval
    str r0, [r1]                         @ store the hidden number

    @First guess
    ldr r0, = sstring
    ldr r1, = gStr
    bl printf

    ldr r0, = dstring
    ldr r1, = guess
    bl scanf

@ Guessing loop
uStart:
    ldr r0, = guess
    ldr r0, [r0]                         @ r0 = guess
    ldr r1, = randval
    ldr r1, [r1]                         @ r1 = hidden number

    cmp r1, r0                           @ compare hidden number to guess
    beq end                              @ equal -> correct, leave the loop

    ldr r0, = sstring
    ldrgt r1, = higher                   @ hidden > guess -> guess is too low
    ldrlt r1, = lower                    @ hidden < guess -> guess is too high
    bl printf

    @ ---- Count this wrong guess ----
    ldr r0, = gcount
    ldr r0, [r0]
    add r0, r0, #1                       @ gcount++
    ldr r1, = gcount
    str r0, [r1]

    @ ---- Ask for the next guess ----
    ldr r0, = sstring
    ldr r1, = gStr
    bl printf

    ldr r0, = dstring
    ldr r1, = guess
    bl scanf

    b uStart

@  Correct guess: report result
end:
    ldr r0, = eStr                       @ format string
    ldr r1, = guess
    ldr r1, [r1]                         @ first %d = the answer
    ldr r2, = gcount
    ldr r2, [r2]                         @ second %d = number of guesses
    bl printf
    b exit

@ Invalid maximum: report error 
maxError:
    ldr r0, = sstring
    ldr r1, = errStr
    bl printf

@ Restore return address and return 
exit:
    ldr lr, [sp, #0]
    add sp, sp, #4
    mov pc, lr







