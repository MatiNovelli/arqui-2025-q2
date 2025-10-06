; fibonacci.s  (nasm / intel-style pseudocode)
global fibonacci

section .text

fibonacci:
    push    ebp
    mov     ebp, esp
    sub     esp, 16         ; espacio para variables locales: [ebp-4] = a, [ebp-8] = b

    mov     eax, DWORD PTR [ebp+8]   ; eax = n
    cmp     eax, 1
    jle     .Lbase                 ; si n <= 1 ir a base

    ; --- calcular a = fibonacci(n-1)
    mov     eax, DWORD PTR [ebp+8] ; eax = n
    dec     eax                    ; eax = n-1
    push    eax                    ; push arg
    call    fibonacci
    add     esp, 4                 ; limpiar el arg
    mov     DWORD PTR [ebp-4], eax ; a = result (en eax)

    ; --- calcular b = fibonacci(n-2)
    mov     eax, DWORD PTR [ebp+8] ; eax = n
    sub     eax, 2                 ; eax = n-2
    push    eax
    call    fibonacci
    add     esp, 4
    mov     DWORD PTR [ebp-8], eax ; b = result (en eax)

    ; sumar a + b -> retorno en eax
    mov     eax, DWORD PTR [ebp-4]
    add     eax, DWORD PTR [ebp-8]
    jmp     .Lleave

.Lbase:
    ; caso base: devolver n (0 o 1). n está en [ebp+8]
    mov     eax, DWORD PTR [ebp+8]

.Lleave:
    mov     esp, ebp
    pop     ebp
    ret
