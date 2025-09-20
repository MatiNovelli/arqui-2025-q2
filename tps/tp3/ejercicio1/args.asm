;main.asm
GLOBAL main
EXTERN printf

section .rodata
    fmt db "Cantidad de argumentos: %d",10,0
    msg db "argv[%d]: %s",10,0

section .text
    main:
        push ebp ;Armado de stack frame
        mov ebp, esp 

        push dword [ebp+8] 
        push fmt
        call printf
        add esp, 2*4

        mov ebx, [ebp+8]
        mov edx, [ebp+12]
        xor ecx, ecx
        xor esi, esi

        .CICLO:
            cmp ebx, 0
            je .FIN

            pushad

            push dword [edx+ecx]
            push esi
            push msg
            call printf
            add esp, 3*4

            popad

            add ecx, 4
            inc esi
            dec ebx

            jmp .CICLO


        .FIN:

        mov eax, 0

        mov esp, ebp ;Desarmado de stack frame
        pop ebp ;
        ret 	