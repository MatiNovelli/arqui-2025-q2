section .bss
    extra_time resd 2

section .data
    time dd 5

section .text
    GLOBAL _start
    EXTERN exit
    

_start:
    push ebp
    mov ebp, esp

    mov eax, 0xa2
    mov ebx, time
    mov ecx, extra_time
    int 80h

    leave
    call exit
