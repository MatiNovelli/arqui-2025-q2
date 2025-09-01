section .bss
    buffer resb 32

section .data
    array dd 10, 1, 0, 2
    len equ ($-array)/4

section .text
    GLOBAL _start
    EXTERN exit
    EXTERN puts
    EXTERN num2str


_start:
    push ebp
    mov ebp, esp

    mov eax, 0 ; Indice (i)
    mov ebx, [array] ; ebx = array[0] 

    .CICLO:
    cmp eax, len  ; Si i == len -> fin
    jge .FIN

    inc eax ; i++

    mov ecx, [array+(eax*4)]

    cmp ebx, ecx ; Si el que ya tenia era menor, paso al proximo elemento
    jl .CICLO

    mov ebx, ecx ; Si ecx < ebx -> actualizo ebx con el menor
    jmp .CICLO
    
    .FIN:
    push ebx
    push buffer
    call num2str
    mov ebx, buffer
    call puts
    call exit