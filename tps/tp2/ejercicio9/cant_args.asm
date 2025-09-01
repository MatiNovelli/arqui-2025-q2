global _start
extern puts
extern num2str
extern exit

section .bss
    buffer resb 16   ; espacio para guardar el número convertido en string

section .text
_start:
    push ebp
    mov ebp, esp

    ; Si se ejecuta este programa de la siguiente manera: ./prueba_args hola mundo
    ; El stack queda:

    ;PREGUNTAR SI ESTO ES CORRECTO

    ; 0xBFFFEFFC → EBP del SO 
    ; 0xBFFFF000 → argc = 3
    ; 0xBFFFF004 → argv[0] ; prueba_args
    ; 0xBFFFF008 → argv[1] ; hola
    ; 0xBFFFF00C → argv[2] ; mundo
    ; 0xBFFFF010 → NULL
    

    mov eax, [ebp+4]      ; eax = argc (entero)
    mov ebx, buffer     ; ebx = dirección del buffer destino
    push eax            ; argumento #1 para num2str (número)
    push ebx            ; argumento #2 para num2str (buffer)
    call num2str
    
    mov ebx, buffer     ; ebx = string convertido
    call puts           ; imprime el número + salto de línea

    ; salir del programa
    call exit
