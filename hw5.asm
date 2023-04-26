 extern printf
 extern scanf
 
        global _start

        section .text
_start:
        mov rax, SYS_WRITE
        mov rdi, STDOUT
        mov rsi, message1
        mov rdx, mess1len
        syscall

        ;getting weight input
        mov rdi, fmtin
        mov rsi, weight
        xor rax, rax
        call scanf


        ;height promt
        mov rax, SYS_WRITE
        mov rdi, STDOUT
        mov rsi, message2
        mov rdx, mess2len
        syscall

        ;getting height input
        mov rdi, fmtin
        mov rsi, height
        xor rax, rax
        call scanf

        ;age promt
        mov rax, SYS_WRITE
        mov rdi, STDOUT
        mov rsi, message3
        mov rdx, mess3len
        syscall

        ;getting height input
        mov rdi, fmtin
        mov rsi, age
        xor rax, rax
        call scanf

        ;sex promt
        mov rax, SYS_WRITE
        mov rdi, STDOUT
        mov rsi, message4
        mov rdx, mess4len
        syscall

        ;getting height input
        mov rdi, fmtin
        mov rsi, sex
        xor rax, rax
        call scanf

        mov r12, [weight]
        mov r13, [age] ;this should be replpaced with a constant
        mov r14, r12
        imul r14, r13
        mov [weightResult], r14






        mov r12, [height]
        mov r13, [age]
        mov r14, r12
        imul r14, r13


        mov r12, [age]
        mov r13, [age]
        mov r14, r12
        imul r14, r13
         

    

        ;output
        mov rdi, fmt
        mov rsi, weightResult
        mov rdx, r13
        mov rcx, weightResult
        xor rax, rax
        call printf






        mov rax, SYS_EXIT
        xor rdi, rdi
        syscall


        section .data

fmt:    db  "%d X %d = %d", 10, 0
fmtin   db  "%d", 0

message1    db  "Please Enter Your weight in pounds: ", 10, 0
mess1len    equ $- message1
message2    db  "Please enter your height in inches: ", 10, 0
mess2len    equ $- message2
message3    db  "Please enter your age in years: ", 10, 0
mess3len    equ $- message3
message4    db  "Please enter your sex (0) Male (1) Female: ", 10, 0
mess4len    equ $-  message4
weightMult  dq  4.3


SYS_EXIT    equ 60
SYS_WRITE   equ 1
STDOUT      equ 1


section .bss
    weight  resb    4
    height  resb    4
    age     resb    4
    sex     resb    4
    weightResult resb 4

