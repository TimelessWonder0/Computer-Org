#
# Program Name: libFunctions.s
# Author: Shreyas K
# Date: 11/01/2026
# Purpose: Function library for Module 9. Provides:
#     ChkAlphaLOG(char inchar)   - alphabetic check using logical operations
#     ChkAlphaNOLOG(char inchar) - alphabetic check using only compares/branches
#     findMAXOf3(int val1, int val2, int val3) - largest of three values
#     Grade(int score)           - letter grade for a score in 0..100
# Notes: All functions follow the ARM ABI: arguments arrive in r0-r3 and
#     the result is returned in r0. The stack is managed manually
#     (SUB/STR and LDR/ADD on sp) - PUSH and POP are not used.
#

.text

#
# Function: ChkAlphaLOG
# Purpose: Determine whether a character is alphabetic (A-Z or a-z) by
#     building boolean values for each range test and combining them
#     with the logical AND and ORR instructions.
#     isAlpha = ((c >= 'A') AND (c <= 'Z')) OR ((c >= 'a') AND (c <= 'z'))
# Input: r0 - the character to test (inchar)
# Output: r0 - 1 if the character is alphabetic, 0 if it is not
#
.global ChkAlphaLOG
ChkAlphaLOG:
    # push the stack: save lr and r4
    SUB sp, sp, #8
    STR lr, [sp, #0]
    STR r4, [sp, #4]

    # r1 = (inchar >= 'A')
    MOV r1, #0
    CMP r0, #'A'
    MOVGE r1, #1

    # r2 = (inchar <= 'Z')
    MOV r2, #0
    CMP r0, #'Z'
    MOVLE r2, #1

    # r1 = (inchar >= 'A') AND (inchar <= 'Z')  -> uppercase test
    AND r1, r1, r2

    # r3 = (inchar >= 'a')
    MOV r3, #0
    CMP r0, #'a'
    MOVGE r3, #1

    # r4 = (inchar <= 'z')
    MOV r4, #0
    CMP r0, #'z'
    MOVLE r4, #1

    # r3 = (inchar >= 'a') AND (inchar <= 'z')  -> lowercase test
    AND r3, r3, r4

    # r0 = uppercase OR lowercase -> return value
    ORR r0, r1, r3

    # pop the stack and return
    LDR lr, [sp, #0]
    LDR r4, [sp, #4]
    ADD sp, sp, #8
    MOV pc, lr
# END ChkAlphaLOG

#
# Function: ChkAlphaNOLOG
# Purpose: Determine whether a character is alphabetic (A-Z or a-z)
#     without logical operations. Only compares and conditional
#     branches are used to walk through the ranges:
#         c < 'A'          -> not alpha
#         'A' <= c <= 'Z'  -> alpha
#         c < 'a'          -> not alpha  (characters between 'Z' and 'a')
#         c > 'z'          -> not alpha
#         otherwise        -> alpha
# Input: r0 - the character to test (inchar)
# Output: r0 - 1 if the character is alphabetic, 0 if it is not
#
.global ChkAlphaNOLOG
ChkAlphaNOLOG:
    # push the stack: save lr
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # below 'A' is never a letter
    CMP r0, #'A'
    BLT ChkAlphaNOLOG_NotAlpha

    # 'A' through 'Z' is an uppercase letter
    CMP r0, #'Z'
    BLE ChkAlphaNOLOG_IsAlpha

    # between 'Z' and 'a' ( [ \ ] ^ _ ` ) is not a letter
    CMP r0, #'a'
    BLT ChkAlphaNOLOG_NotAlpha

    # above 'z' is not a letter
    CMP r0, #'z'
    BGT ChkAlphaNOLOG_NotAlpha

    # otherwise fall through: 'a' through 'z' is a lowercase letter
    ChkAlphaNOLOG_IsAlpha:
        MOV r0, #1
        B ChkAlphaNOLOG_End

    ChkAlphaNOLOG_NotAlpha:
        MOV r0, #0

    ChkAlphaNOLOG_End:
    # pop the stack and return
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
# END ChkAlphaNOLOG

#
# Function: findMAXOf3
# Purpose: Compare three signed integers and return the largest.
#     max = val1
#     if (val2 > max) max = val2
#     if (val3 > max) max = val3
# Input: r0 - val1
#        r1 - val2
#        r2 - val3
# Output: r0 - the largest of the three values
#
.global findMAXOf3
findMAXOf3:
    # push the stack: save lr
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # max = val1 (already in r0)
    # if (max < val2) max = val2
    CMP r0, r1
    MOVLT r0, r1

    # if (max < val3) max = val3
    CMP r0, r2
    MOVLT r0, r2

    # pop the stack and return
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
# END findMAXOf3

#
# Function: Grade
# Purpose: Convert a numeric score to a letter grade.
#     score < 0 or score > 100 -> error
#     90 - 100 -> 'A'
#     80 - 89  -> 'B'
#     70 - 79  -> 'C'
#     0  - 69  -> 'F'
# Input: r0 - the score (int)
# Output: r0 - ASCII code of the letter grade ('A', 'B', 'C', or 'F'),
#              or -1 if the score is out of range (error)
#
.global Grade
Grade:
    # push the stack: save lr
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # error check: score < 0
    CMP r0, #0
    BLT Grade_Error

    # error check: score > 100
    CMP r0, #100
    BGT Grade_Error

    # score >= 90 -> A
    CMP r0, #90
    BGE Grade_A

    # score >= 80 -> B
    CMP r0, #80
    BGE Grade_B

    # score >= 70 -> C
    CMP r0, #70
    BGE Grade_C

    # anything left (0 - 69) -> F
    MOV r0, #'F'
    B Grade_End

    Grade_A:
        MOV r0, #'A'
        B Grade_End

    Grade_B:
        MOV r0, #'B'
        B Grade_End

    Grade_C:
        MOV r0, #'C'
        B Grade_End

    Grade_Error:
        MOV r0, #-1

    Grade_End:
    # pop the stack and return
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
# END Grade







