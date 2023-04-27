extern printf
extern scanf

global _start

section .text


_start:


;Prompt for weight
    mov     rax, SYS_WRITE
    mov     rdi, STDOUT
    mov     rsi, weightPrompt ;moving promt to memory
    mov     rdx, weightlen ;moving promt size to memory
    syscall ;print
;get weight input
    mov     rdi, fmtin
    mov     rsi, weight
    xor     rax, rax
    call    scanf
;prompt for height
    mov     rax, SYS_WRITE
    mov     rdi, STDOUT
    mov     rsi, heightPrompt ;moving promt to memory
    mov     rdx, heightlen ;moving promt size to memory
    syscall ;print
;get height
    mov     rdi, fmtin
    mov     rsi, height
    xor     rax, rax
    call    scanf
;prmopt for age
    mov     rax, SYS_WRITE
    mov     rdi, STDOUT
    mov     rsi, agePrompt ;moving promt to memory
    mov     rdx, agelen ;moving promt size to memory
    syscall ;print
;get age
    mov     rdi, fmtin
    mov     rsi, age
    xor     rax, rax
    call    scanf
;prompt for sex
    mov     rax, SYS_WRITE
    mov     rdi, STDOUT
    mov     rsi, sexPrompt ;moving promt to memory
    mov     rdx, sexlen ;moving promt size to memory
    syscall ;print
;get sex
    mov     rdi, fmtin
    mov     rsi, sex
    xor     rax, rax
    call    scanf

;from here do compare jump on sex input
    mov     r12, [sex];
    mov     r13, [sexComp];


    cmp     r12, r13
    je      female
    jne     male
    jmp     done


male:
;make the values in multipliers
    mov     constant, 66.00
    mov     weightMult, 6.30
    mov     heightMult, 12.90
    mov     ageMult, 6.8
    mov     sexString, "Male "

    jmp     done


female:
;make the values in multipliers
    mov     constant, 655.00
    mov     weightMult, 4.30
    mov     heightMult, 4.70
    mov     ageMult, 4.70
    mov     sexString, "Female "

    jmp     done

done:


;converting weight into a double and multiplying it by its constant
    mov         r14, [weight]
    cvtsi2sd    xmm0, r14
    mov         xmm1, xmm0
    mulsd       [weightMult], xmm1
;converting height into a double and multiplying it by its constant
    mov         r14, [height]
    cvtsi2sd    xmm0, r14
    mov         xmm1, xmm0
    mulsd       [heightMult], xmm1
;converting age into a double and multiplying by its constant
    mov         r14, [age]
    cvtsi2sd    xmm0, r14
    mov         xmm1, xmm0
    mulsd       [ageMult], xmm1


;do the additions
    pxor    xmm2, xmm2

    mov     xmm0, [constant]
    addsd   xmm2, xmm0

    pxor    xmm0, xmm0

    mov     xmm0, [weightMult]
    addsd   xmm2, [xmm0]

    pxor    xmm0, xmm0

    mov     xmm0, [heightMult]
    addsd   xmm2, [xmm0]

    pxor    xmm0, xmm0

    mov     xmm0, [ageMult]
    subsd   xmm2, [xmm0]














;add the constant and converted weight

;add that sum to converted height

;subtract converted age from that sum

;format print on homework specifications






section .data

    fmtin           db  "%d", 0


    weightPrompt    db   "Please Enter Your weight in pounds: ", 10, 0
    weightlen       equ  $- weightPrompt
    heightPrompt    db  "Please enter your height in inches: ", 10, 0
    heightlen       equ $- heightPrompt
    agePrompt       db  "Please enter your age in years: ", 10, 0
    agelen          equ $- agePrompt
    sexPrompt       db  "Please enter your sex (0) Male (1) Female: ", 10, 0
    sexlen          equ $- sexPrompt

    sexComp         db  1;check if valid




    SYS_EXIT        equ 60
    SYS_WRITE       equ 1
    STDOUT          equ 1


section .bss


    weight      resb    4
    height      resb    4
    age         resb    4
    sex         resb    4

    weightMult  resq    8
    heightMult  resq    8
    ageMult     resq    8
    constant    resq    8
    sexString   resq    8;check if valid
