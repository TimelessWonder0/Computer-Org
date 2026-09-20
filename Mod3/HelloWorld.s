.text

.global main

main:
    SUB sp, sp, #4
    STR lr, [sp]

    LDR r0=helloworld
    BL printf


    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data

    helloworld: .asciz "Hello World\n"

#End Main
