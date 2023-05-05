

extern printf
extern scanf

global _start

section .text


_start:


;Prompt for weight
    mov     rax, SYS_WRITE      ;sytem call for write
    mov     rdi, STDOUT         ;file handle 1 is stdout
    mov     rsi, weightPrompt   ;address of string to display
    mov     rdx, weightlen      ;number of bytes
    syscall                     ;write to terminal
;get weight input
    mov     rdi, fmtin          ;format for scanf
    mov     rsi, weight         ;address to store results
    xor     rax, rax            ;clear rax
    call    scanf               ;call scanf
;prompt for height
    mov     rax, SYS_WRITE      ;sytem call for write
    mov     rdi, STDOUT         ;file handle 1 is stdout
    mov     rsi, heightPrompt   ;address of string to display
    mov     rdx, heightlen      ;number of bytes
    syscall ;print
;get height
    mov     rdi, fmtin          ;format for scanf
    mov     rsi, height         ;address to store result
    xor     rax, rax            ;clear rax
    call    scanf               ;scanf
;prmopt for age
    mov     rax, SYS_WRITE      ;sytem call for write
    mov     rdi, STDOUT         ;file handle 1 is stdout
    mov     rsi, agePrompt      ;address of string to display
    mov     rdx, agelen         ;number of bytes
    syscall ;print
;get age
    mov     rdi, fmtin          ;format for scanf
    mov     rsi, age            ;address to store results
    xor     rax, rax            ;clear rax
    call    scanf               ;scanf
;prompt for sex
    mov     rax, SYS_WRITE      ;sytem call for write
    mov     rdi, STDOUT         ;filehandle 1 is stdout
    mov     rsi, sexPrompt      ;address of string to display
    mov     rdx, sexlen         ;number of bytes
    syscall                     ;printf
;get sex
    mov     rdi, fmtin          ;format for scanf
    mov     rsi, sex            ;address to store results
    xor     rax, rax            ;clear rax    
    call    scanf               ;scanf

    xor     r12, r12            ;clear r12
    mov     r12, [sex]          ;move result of sex into r12


    cmp     r12, 0              ;compare r12 with 0
    je      Male                ;if equal jump to male
    jne     Female              ;if not equal jump to female
    jmp     done                ;jump to done as failsafe






Male:
    
    mov         r13, [weight]   ;move weight into r13
    cvtsi2sd    xmm2, r13       ;convert weight to a single double
    mulsd       xmm2, [mw]      ; multiply double weight by male weight multiplier



    mov         r13, [height]   ;move height into r13
    cvtsi2sd    xmm1, r13       ;convert height into a single double
    mulsd       xmm1, [mh]      ;multiply height by male height multuiplier
    addsd       xmm2, xmm1      ;add that into xmm2 which is storing the running total



    mov         r13, [age]      ;move age into r13
    cvtsi2sd    xmm0, r13       ;convert age into a single double
    mulsd       xmm0, [ma]      ;multiply age by male age multiplier
    subsd       xmm2, xmm0      ;subtract the running total by results 


   

    addsd       xmm2, [mc]      ;adding the male constant into the runnning total
    movsd       [total], xmm2   ;storing the running total into the total variable

    mov         rdi, fmtMale    ;move string to be printed to terminal
    mov         rax, 1          ;clear rax
    call        printf          ;print


    jmp done                    ;jump to done


Female:

    mov         r13, [weight]   ;moving weight into r13
    cvtsi2sd    xmm2, r13       ;converting weight into a single double 
    mulsd       xmm2, [fw]      ;multiplying weight by fem weight multiplier


    mov         r13, [height]   ;move height into r13
    cvtsi2sd    xmm1, r13       ;convert height into single double
    mulsd       xmm1, [fh]      ;multiply heihgt by fem height multiplier
    addsd       xmm2, xmm1      ;add that result to the running total


    mov         r13, [age]      ;move age into r13
    cvtsi2sd    xmm0, r13       ;convert age into a single double
    mulsd       xmm0, [fa]      ;multiply age by fem age multiplier
    subsd       xmm2, xmm0      ;subtract the running total by that result


    addsd       xmm2, [fc]      ;add the fem constant
    movsd       [total], xmm2   ;store the running total into the total variable

    mov         rdi, fmtFem     ;move the female string to be printed
    mov         rax, 1          ;clear rax
    call        printf          ;print
    jmp done





done:


    mov     rdi, fmtTwo         ;mov fmt 2 to be printed
    movsd   xmm0 , [total]      ;mov running to into register as input
    mov     rax, 1              ;clear rax
    call    printf              ;print

    mov     rdi, fmtThree       ;mov fmt 3 to be printed
    mov     rsi, [height]       ;mov height into register
    mov     rax, 1              ;clear rax
    call    printf              ;print

    mov     rdi, fmtFour        ;mov fmt 4 to be printed
    mov     rsi, [weight]       ;move weight into a register
    mov     rax, 1              ;clear rax
    call    printf              ;print

    mov     rdi, fmtFive        ;move format 5 to be printed
    mov     rsi, [age]          ;move age into register
    mov     rax, 1              ;clear rax
    call    printf              ;print

    





    mov     rax, SYS_EXIT   ;system exit to avoid segmentation fault
    xor     rdi, rdi          
    syscall                           



section .data

    fmtin       db  "%d", 0
    fmtDebug    db  "This line printed %.2f", 10, 0
    fmtMale     db  "As a Male", 0
    fmtFem      db  "As a Female", 0
    fmtTwo      db  ", you would need to consume %.2f", 0
    fmtThree    db  " calories to maintain your weight based on your given height %d", 0
    fmtFour     db  ", weight %d", 0
    fmtFive     db  ", and age %d", 10, 0


    weightPrompt    db   "Please Enter Your weight in pounds: ", 10, 0
    weightlen       equ  $- weightPrompt
    heightPrompt    db  "Please enter your height in inches: ", 10, 0
    heightlen       equ $- heightPrompt
    agePrompt       db  "Please enter your age in years: ", 10, 0
    agelen          equ $- agePrompt
    sexPrompt       db  "Please enter your sex (0) Male (1) Female: ", 10, 0
    sexlen          equ $- sexPrompt

    mw      dq  6.3
    mh      dq  12.9
    ma      dq  6.8
    mc      dq  66.0

    fw      dq  4.3
    fh      dq  4.7
    fa      dq  4.7
    fc      dq  655.0

    SYS_EXIT        equ 60
    SYS_WRITE       equ 1
    STDOUT          equ 1


section .bss


    weight      resb    8
    height      resb    8
    age         resb    8
    sex         resb    8
    total       resq    1

