global _start
extern puts
extern print
extern num2str
extern exit

section .data
    cant_arg_msg db "Cantidad de argumentos: ",0
    argv_msg_1 db "argv[",0
    argv_msg_2 db "]: ",0

section .bss
    buffer resb 32   ; espacio para guardar el número convertido en string

section .text
_start:
    push ebp
    mov ebp, esp

    mov eax, [ebp+4] ; En eax tengo al cantidad de argumentos

    mov ecx, 0 ; Index (i)

    push eax ; Cantidad de argumentos
    push buffer
    call num2str

    mov ebx, cant_arg_msg ; Imprimo el mensaje de cantidad de argumentos
    call print

    mov ebx, buffer ; Imprimo la cantidad de argumentos
    call puts
    
    .CICLO:
    cmp eax, ecx ; Cuando index es igual a la cantidad de argumentos.
    je .FIN             ; Ya termine de imprimir todos los argumentos
    
    mov ebx, argv_msg_1 ; Imprimo la primera parte de el mensaje de argv
    call print

    push ecx
    push buffer
    call num2str

    mov ebx, buffer ; Printeo el numero del argumento
    call print

    mov ebx, argv_msg_2 ; Prineto la ultima parte del argumento
    call print

    mov edx, [ebp+8 + ecx*4]

    mov ebx, edx ; Agarro el argumento numero n=index_argv
    call puts ; Printeo el argumento

    inc ecx
    jmp .CICLO

    .FIN:
    ; salir del programa
    call exit
