section .bss
    buffer resb 32

section .data
    GLOBAL _start
    EXTERN puts
    EXTERN num2str
    EXTERN exit


_start:
    push ebp
    mov ebp, esp

    mov eax, 20
    int 80h

    push eax
    push buffer
    call num2str

    mov ebx, buffer
    call puts

    call exit