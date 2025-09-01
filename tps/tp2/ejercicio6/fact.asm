section .bss 
    buffer resb 32

section .data
    parameters_error_msg db "Usage: ./fact <n>",10,0
    number_error_msg db "<n> must be greater than 0",10,0

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

    cmp byte [ebp+4], 2
    jl .ERROR_INVALID_PARAMETRS

    mov ebx, [ebp+12] ;El numero n recibido por parametro
    call str2num
    mov eax, ebx

    cmp eax, 0
    jle .ERROR_INVALID_NUMBER

    .CICLO:
    cmp eax, 1
    jle .FIN
    dec eax
    imul ebx, eax
    jmp .CICLO

    .FIN:
    push ebx
    push buffer
    call num2str
    mov ebx, buffer
    call puts
    call exit

    .ERROR_INVALID_PARAMETRS:
    mov ebx, parameters_error_msg
    call print
    call exit

    .ERROR_INVALID_NUMBER:
    mov ebx, number_error_msg
    call print
    call exit