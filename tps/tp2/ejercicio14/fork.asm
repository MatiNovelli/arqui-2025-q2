section .data
    msg_parent db "Soy el padre",10,0
    msg_child db "Soy el hijo",10,0
    msg_error db "Algo salio mal",10,0

section .text
    GLOBAL _start
    EXTERN print
    EXTERN exit

_start:
    push ebp
    mov ebp, esp

    mov eax, 0x02
    int 80h

    cmp eax, 0
    je .CHILD
    jl .ERROR

    .PARENT:
    mov ebx, msg_parent
    call print
    jmp .FIN

    .CHILD:
    mov ebx, msg_child
    call print
    jmp .FIN

    .ERROR:
    mov ebx, msg_parent
    call print
    jmp .FIN

    .FIN:
    call exit
