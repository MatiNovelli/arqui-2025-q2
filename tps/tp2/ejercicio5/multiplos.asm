section .bss 
    buffer resb 32

section .data
    parameters_error_msg db "Usage: ./multiplos <n> <k>",10,0
    number_error_msg db "<k> must be greater than 0",10,0

section .text
    GLOBAL _start
    EXTERN print
    EXTERN puts
    EXTERN exit
    EXTERN str2num
    EXTERN num2str

_start:
    push ebp
    mov ebp, esp

    mov byte [buffer+31], 0

    cmp byte [ebp+4], 3
    jl .ERROR_INVALID_PARAMETRS

    mov ebx, [ebp+12] ;El numero n recibido por parametro
    call str2num
    mov eax, ebx

    mov ebx, [ebp+16] ;El numero k recibido por parametro
    call str2num
    mov ecx, ebx

    cmp ecx, 1 ; Chequeo que k sea mayor o igual a 1
    jl .ERROR_INVALID_NUMBER

    ; En eax tengo n
    ; En ecx tengo k
    
    .CICLO:
    cmp ecx, 0
    je .FIN
    mov ebx, eax
    imul ebx, ecx

    push ebx 
    push buffer
    call num2str

    mov ebx, buffer
    call puts
    
    dec ecx
    call .CICLO

    .FIN:    
    call exit

    .ERROR_INVALID_PARAMETRS:
    mov ebx, parameters_error_msg
    call print
    call exit

    .ERROR_INVALID_NUMBER:
    mov ebx, number_error_msg
    call print
    call exit
