section .text
    GLOBAL checkLong
    GLOBAL msg
    GLOBAL len

    checkLong:
    push ebp
    mov ebp, esp

    push ebx ;Hay que preservar ebx

    mov ebx, dword [ebp+8]   ;ebx = vec
    mov ecx, dword [ebp+12]  ;ecx = dim
    mov eax, 0

    .loop:
    cmp byte [ebx], 0
    je .end
    inc eax
    inc ebx
    jmp .loop

    .end:
    sub eax, ecx
    pop ebx
    leave
    ret

section .data
    msg db "Hola Mundo", 0
    len db 10