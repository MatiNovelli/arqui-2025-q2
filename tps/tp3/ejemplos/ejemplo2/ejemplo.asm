section .text
    GLOBAL main
    EXTERN printf

    main:
        push 20
        push msg
        call printf

        add esp, 2*4

        mov eax, 0
        ret

section .rodata
    msg db "Hola mundo, tengo %d años",10,0