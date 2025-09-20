;main.asm
GLOBAL main
EXTERN printf

section .rodata
    fmt db "Cantidad de argumentos: %d",10,0
    fmt2 db "%s"
    msg db "Hola Mundo",10,0

section .text
    main:
        push ebp ;Armado de stack frame
        mov ebp, esp ;  

        mov eax, [ebp+8] ; eax = cant de argumentos

        push eax 
        push fmt
        call printf
        add esp, 2*4

        xor esi, esi

        .CICLO:
            cmp esi, eax
            je .FIN

            pushad

            push msg
            push fmt2
            call printf

            add esp, 2*4
            
            popad   

            inc esi
            jmp .CICLO

        .FIN:

        mov eax, 0

        mov esp, ebp ;Desarmado de stack frame
        pop ebp ;
        ret 