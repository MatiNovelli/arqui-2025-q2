section .bss
    buffer resb 128

section .text
    GLOBAL _start
    EXTERN print
    EXTERN write
    EXTERN exit

_start:
    push ebp
    mov ebp, esp

    mov eax, 0x03
    mov ebx, 0
    mov ecx, buffer
    mov edx, 127
    int 80h

    push eax
    push buffer
    call write

    .FIN:
    leave
    call exit


