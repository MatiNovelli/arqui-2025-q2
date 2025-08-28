section .text  
    GLOBAL _start
    EXTERN num2str
    EXTERN print
    EXTERN exit
    EXTERN write

_start:
    push ebp
    mov ebp, esp

    mov byte [buffer + 3], 0

    push 123
    push buffer
    call num2str
    
    mov ebx, buffer
    call print

    mov ebx, new_line
    call print

    call exit

    mov esp, ebp
    pop ebp

section .bss
    buffer resb 4

section .data
    new_line db 10