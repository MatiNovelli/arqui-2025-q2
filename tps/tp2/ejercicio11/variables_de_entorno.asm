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
    
    cmp ebx, 0 ; Checkeo que no haya levantado NULL
    je .CICLO

    cmp dword [ebx], "USER"
    je .FIN

    jmp .CICLO


    .FIN:
    call puts
    call exit
