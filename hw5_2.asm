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

    mov     eax, 660
    mov     [constant], eax
    mov     ebx, 63
    mov     [weightMult], eax
    mov     ecx, 129
    mov     [heightMult], ecx
    mov     eax, 68
    mov     [ageMult], eax
    mov     rsi, "Male "
    mov     [sexString], rsi


female:
;make the values in multipliers
    mov     eax, 6550
    mov     [constant], eax
    mov     ebx, 43
    mov     [weightMult], ebx
    mov     ecx, 47
    mov     [heightMult], ecx
    mov     [ageMult], ecx
    mov     rsi, "Female "
    mov     [sexString], rsi

    jmp     done

done:


;converting weight into a double and multiplying it by its constant
    mov         r13, [weightMult]
    mov         r14, [weight]
    cvtsi2sd    xmm0, r13
    cvtsi2sd    xmm1, r14
    mulsd       xmm0, xmm1
;converting height into a double and multiplying it by its constant
    mov         r13, [heightMult]
    mov         r14, [height]
    cvtsi2sd    xmm1, r13
    cvtsi2sd    xmm2, r14
    mulsd       xmm1, xmm2
;converting age into a double and multiplying by its constant
    mov         r13, [ageMult]
    mov         r14, [age]
    cvtsi2sd    xmm2, r13
    cvtsi2sd    xmm3, r14
    mulsd       xmm2, xmm3


;do the additions

    mov         r13, constant
    cvtsi2sd    xmm3, r13
    addsd   xmm3, xmm0
    addsd   xmm3, xmm1
    subsd   xmm3, xmm2

    
    
    ;call for print here 

    mov       rax, SYS_EXIT           ; system call for exit
    xor       rdi, rdi                ; exit code 0
    syscall                           ; invoke operating system to exit



section .data

    fmtoutput    db "As a %s, you would need to consume %2lf to maintain your weight based on your given height %d, weight %d, and age %d", 10, 0
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
    weightMult  resb    4
    heightMult  resb    4
    ageMult     resb    4
    constant    resb    4


    sexString   resq    8;check if valid
