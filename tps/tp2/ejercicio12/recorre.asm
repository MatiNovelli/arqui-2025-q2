section .text
    GLOBAL _start
    EXTERN puts
    EXTERN exit
    
_start:
    push ebp
    mov ebp, esp

    mov eax, 4  

    .CICLO:
    add eax, 4
    mov ebx, [ebp+eax]
    
    cmp ebx, 0
    je .CICLO

    call puts   
    jmp .CICLO

    call exit