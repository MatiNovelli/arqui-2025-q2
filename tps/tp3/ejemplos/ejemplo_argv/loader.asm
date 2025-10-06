section .text
    GLOBAL _start
    EXTERN main

    _start:
    ;Por que no funciona asi? 
    ;si se supone que al iniciar un programa en assembler en la pila esta esto:

    ; [ argc ] 
    ; [ argv[0] ] 
    ; [ argv[1] ] 
    ; [ argv[2] ] 
    ; [ NULL ] 
    ; [ envp[0] ]

    ;En teoria si no pusheo nada main recibira este stack

    ; [ret _start]
    ; [ argc ] 
    ; [ argv[0] ] 
    ; [ argv[1] ] 
    ; [ argv[2] ] 
    ; [ NULL ] 
    ; [ envp[0] ]

    ;pero hay que tener en cuenta que main esta compilado con gcc, por lo tanto espera que
    ;el stack tenga setea el ebp del contexto anterior al llamado
    ;esto es lo que espera c:

    ; [Ebp _start]
    ; [ret _start]
    ; [ argc ] 
    ; [ argv[0] ] 
    ; [ argv[1] ] 
    ; [ argv[2] ] 
    ; [ NULL ] 
    ; [ envp[0] ]

    call main

    mov ebx, eax ;Valor de retorno del main
    mov eax, 1	; ID del Syscall EXIT
	int 80h	; Ejecucion de la llamada        
