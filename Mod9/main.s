

#
# Program Name: main.s
# Author: Shreyas K
# Date: 11/01/2026
# Purpose: Driver program for the Module 9 function library
#     (libFunctions.s). It:
#     1. Reads a character, calls ChkAlphaLOG, prints Y or N
#     2. Reads a character, calls ChkAlphaNOLOG, prints Y or N
#     3. Reads three integers, calls findMAXOf3, prints the maximum value
#     4. Reads a student name and score, calls Grade, prints the
#        student name and letter grade (or an error message)
# Notes: All input/output uses the C library functions printf and scanf.
#     The stack is managed manually (SUB/STR and LDR/ADD on sp) - PUSH
#     and POP are not used.
#

.text
.global main
main:
    # push the stack: save lr and r4 (8 bytes keeps sp 8-byte aligned
    # for the calls to printf and scanf)
    SUB sp, sp, #8
    STR lr, [sp, #0]
    STR r4, [sp, #4]

    #
    # Part 1: ChkAlphaLOG
    #
    # printf("Enter a character for ChkAlphaLOG: ")
    LDR r0, =promptLOG
    BL printf

    # scanf(" %c", &inchar)
    LDR r0, =charFormat
    LDR r1, =inchar
    BL scanf

    # r0 = ChkAlphaLOG(inchar)
    LDR r0, =inchar
    LDRB r0, [r0, #0]
    BL ChkAlphaLOG

    # r1 = (r0 == 1) ? 'Y' : 'N'
    MOV r1, #'N'
    CMP r0, #1
    MOVEQ r1, #'Y'

    # printf("ChkAlphaLOG result: %c\n", r1)
    LDR r0, =outputLOG
    BL printf

    #
    # Part 2: ChkAlphaNOLOG
    #
    # printf("Enter a character for ChkAlphaNOLOG: ")
    LDR r0, =promptNOLOG
    BL printf

    # scanf(" %c", &inchar)
    LDR r0, =charFormat
    LDR r1, =inchar
    BL scanf

    # r0 = ChkAlphaNOLOG(inchar)
    LDR r0, =inchar
    LDRB r0, [r0, #0]
    BL ChkAlphaNOLOG

    # r1 = (r0 == 1) ? 'Y' : 'N'
    MOV r1, #'N'
    CMP r0, #1
    MOVEQ r1, #'Y'

    # printf("ChkAlphaNOLOG result: %c\n", r1)
    LDR r0, =outputNOLOG
    BL printf

    #
    # Part 3: findMAXOf3
    #
    # printf("Enter three integers separated by spaces: ")
    LDR r0, =promptMax
    BL printf

    # scanf("%d %d %d", &val1, &val2, &val3)
    LDR r0, =threeIntFormat
    LDR r1, =val1
    LDR r2, =val2
    LDR r3, =val3
    BL scanf

    # r0 = findMAXOf3(val1, val2, val3)
    LDR r0, =val1
    LDR r0, [r0, #0]
    LDR r1, =val2
    LDR r1, [r1, #0]
    LDR r2, =val3
    LDR r2, [r2, #0]
    BL findMAXOf3

    # printf("Maximum value: %d\n", r0)
    MOV r1, r0
    LDR r0, =outputMax
    BL printf

    #
    # Part 4: Grade
    #
    # printf("Enter the student name: ")
    LDR r0, =promptName
    BL printf

    # scanf(" %99[^\n]", studentName) - reads a full name with spaces
    LDR r0, =nameFormat
    LDR r1, =studentName
    BL scanf

    # printf("Enter the student score (0-100): ")
    LDR r0, =promptScore
    BL printf

    # scanf("%d", &score)
    LDR r0, =intFormat
    LDR r1, =score
    BL scanf

    # r0 = Grade(score)
    LDR r0, =score
    LDR r0, [r0, #0]
    BL Grade

    # keep the grade in r4 (preserved across printf)
    MOV r4, r0

    # if (grade == -1) print error, else print name and grade
    CMN r4, #1
    BEQ Main_GradeError

        # printf("Student Name: %s\nGrade: %c\n", studentName, grade)
        LDR r0, =outputGrade
        LDR r1, =studentName
        MOV r2, r4
        BL printf
        B Main_GradeEnd

    Main_GradeError:
        # printf("Student Name: %s\nGrade: Error - ...\n", studentName)
        LDR r0, =outputGradeError
        LDR r1, =studentName
        BL printf

    Main_GradeEnd:

    # pop the stack and return 0 to the OS
    MOV r0, #0
    LDR lr, [sp, #0]
    LDR r4, [sp, #4]
    ADD sp, sp, #8
    MOV pc, lr

.data
    # prompts
    promptLOG:        .asciz "Enter a character for ChkAlphaLOG: "
    promptNOLOG:      .asciz "Enter a character for ChkAlphaNOLOG: "
    promptMax:        .asciz "Enter three integers separated by spaces: "
    promptName:       .asciz "Enter the student name: "
    promptScore:      .asciz "Enter the student score (0-100): "

    # scanf formats (leading space skips leftover whitespace/newlines)
    charFormat:       .asciz " %c"
    intFormat:        .asciz "%d"
    threeIntFormat:   .asciz "%d %d %d"
    nameFormat:       .asciz " %99[^\n]"

    # output formats
    outputLOG:        .asciz "ChkAlphaLOG result: %c\n\n"
    outputNOLOG:      .asciz "ChkAlphaNOLOG result: %c\n\n"
    outputMax:        .asciz "Maximum value: %d\n\n"
    outputGrade:      .asciz "Student Name: %s\nGrade: %c\n"
    outputGradeError: .asciz "Student Name: %s\nGrade: Error - score must be between 0 and 100\n"

    # input storage
    inchar:           .byte 0
    .align 2
    val1:             .word 0
    val2:             .word 0
    val3:             .word 0
    score:            .word 0
    studentName:      .space 100




