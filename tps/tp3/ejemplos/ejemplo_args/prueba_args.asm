; main.asm
GLOBAL main
EXTERN printf
EXTERN puts

section .rodata
    fmt db "Nombre del programa: %s",10,0

section .text
    main:
        push ebp              ; Armado del stack frame
        mov ebp, esp

        mov eax, [ebp+12]     ; eax = argv  
        mov eax, [eax]        ; eax = argv[0] (nombre del programa)

        push eax              ; argumento: cadena con el nombre del programa
        push fmt              ; argumento: formato
        call printf

        add esp, 2*4          ; limpiar pila (dos argumentos de 4 bytes)

        mov eax, 0            ; return 0

        mov esp, ebp          ; Desarmado del stack frame
        pop ebp
        ret
