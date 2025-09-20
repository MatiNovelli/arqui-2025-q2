;main.asm
GLOBAL main
EXTERN printf

section .rodata
    fmt db "Cantidad de argumentos: %d",10,0
    msg db "argv[%d]: %s",10,0

section .text
    main:
        push ebp ;Armado de stack frame
        mov ebp, esp ;  

        mov eax, [ebp+8] ; eax = cant de argumentos

        push eax 
        push fmt
        call printf
        add esp, 2*4

        mov ecx, 0 ; ecx = 0 (i)
        mov eax, [ebp + 8]
        mov esi, [ebp + 12]

        .CICLO:
            cmp dword [esi], 0
            jge FIN

            push dword [esi]
            push ecx
            push msg
            call printf
            add esp, 3*4
            add esi, 4
            add ecx, 1

            jmp .CICLO

        FIN:
        mov eax, 0
        mov esp, ebp ;Desarmado de stack frame
        pop ebp ;
        ret