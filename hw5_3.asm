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
    mov     r13, 1;


    cmp     r12, r13
    je      female
    jne     male
    jmp     done


male:
;make the values in multipliers



    mov     rax, "Male"
    mov     [sexString], rax
    mov     eax, 66
    mov     [constant], eax
    mov     ebx, 63
    mov     [weightMult], ebx
    mov     ecx, 129
    mov     [heightMult], ecx
    mov     eax, 68
    mov     [ageMult], eax

    mov     rdi, fmtMale
    xor     rax, rax

    jmp     done


female:
;make the values in multipliers

    mov     eax, 655
    mov     [constant], eax
    mov     ebx, 43
    mov     [weightMult], ebx
    mov     ecx, 47
    mov     [heightMult], ecx
    mov     [ageMult], ecx

    mov     rdi, fmtFem
    xor     rax, rax


    jmp     done

done:
   mov          r13, [weight]
   mov          r14, [weightMult]
   imul         r14, r13
   mov          [weightMult], r14

    mov          r13, [height]
    mov          r14, [heightMult]
    imul         r14, r13
    mov          [heightMult], r14

    mov          r13, [age]
    mov          r14, [ageMult]
    imul         r14, r13
    mov          [ageMult], r14


;do the additions

    mov         rax, [constant]
    mov         rbx, [weightMult]
    mov         rcx, [heightMult]

    add         rax, rbx
    add         rax, rcx

    mov         rbx, [ageMult]

    sub         rax, rbx

    mov         [constant], rax


    
    
    ;call for print here 

 

    xor     rax, rax


    call    printf

    mov     rdi, fmtTwo
    mov     rsi, [constant]
    xor     rax, rax
    call    printf

    mov     rdi, fmtThree
    mov     rsi, [weight]
    xor     rax, rax
    call    printf

    mov     rdi, fmtFour
    mov     rsi, [height]
    xor     rax, rax
    call    printf

    mov     rdi, fmtFive
    mov     rsi, [age]
    xor     rax, rax
    call    printf



    mov       rax, SYS_EXIT           ; system call for exit
    xor       rdi, rdi                ; exit code 0
    syscall                           ; invoke operating system to exit



section .data

  
    fmtDebug    db  "This line printed %d", 10, 0
    fmtMale      db  "As a Male"
    fmtFem      db  "As a Female"
    fmtTwo      db  " , you would need to consume %d", 0
    fmtThree    db  " calories to maintain your weight based on your given height %d", 0
    fmtFour     db  ", weight %d", 0
    fmtFive     db  ", and age %d", 10, 0
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


    weight      resb    64
    height      resb    64
    age         resb    64
    sex         resb    64
    weightMult  resb    64
    heightMult  resb    64
    ageMult     resb    64
    constant    resb    64


    sexString   resq    64;check if valid
