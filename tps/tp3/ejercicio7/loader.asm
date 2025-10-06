section .text
    GLOBAL _start
    EXTERN main

    _start:
    push ebp
    mov ebp, esp

    ;Stack al iniciar el programa:
     
;    ebp/esp -> [ saved EBP ]        ; 4 bytes (valor viejo de EBP, puede ser 0 o basura)
;               [ argc ]              ; ebp + 4    <-- aquí está argc (no es return address)
;               [ argv[0] ]           ; ebp + 8
;               [ argv[1] ]           ; ebp + 12
;               [ argv[2] ]           ; ebp + 16
;               [ NULL ]              ; ebp + 20
;               [ envp[0] ]           ; ebp + 24
;               ...

    mov ebx, ebp
    add ebx, 8

    push ebx ;Argv (Dirrecion de argv[0])
    push dword [ebp+4] ;Argc 
    call main
    add esp, 2*4 ;Restauro el esp

    .END:
    mov esp, ebp
    pop ebp

    mov ebx, eax ;Valor de retorno del main
    mov eax, 1	; ID del Syscall EXIT
	int 80h	; Ejecucion de la llamada        
