section .text
    GLOBAL sys_read, sys_write, sys_close, sys_open, sys_exit

    sys_read:
    ;Armado de Stack Frame
    push ebp
    mov ebp, esp

    and esp, -16 ;Alinieamiento para optimizar

    push ebx ;Preservo el registro ebx

    mov eax, 0x03 ;ID de la syscall
    mov ebx, [ebp+8] ;FD
    mov ecx, [ebp+12] ;Buff
    mov edx, [ebp+16] ;Count
    int 0x80

    pop ebx ;Restauro el valor de ebx

    ;Desarmado de Stack Frame
    mov esp, ebp ;En este caso no es necesario
    pop ebp ;Restauro el valor del EBP, al de la funcion que lo llamo
    ret 

    sys_write:
	push ebp 	;armo el stack frame
	mov ebp, esp

    and esp, -16

	push ebx

	mov eax, 4	; ID del Syscall WRITE
	mov ebx, [ebp+8] ; FileDescriptor
	mov ecx, [ebp+12] ; cadena a imprimir
	mov edx, [ebp+16] ; largo de la cadena

	int 80h
	
	pop ebx	

	mov esp, ebp	; desarmo el stack frame
	pop ebp
	ret	

    sys_open:
    push ebp
    mov ebp, esp

    and esp, -16

    mov eax, 0x05
    mov ebx, [ebp+8] ;filename
    mov ecx, [ebp+12]
    mov edx, [ebp+16]
    int 0x80

    pop EBX

    mov esp, ebp
    pop ebp
    ret

    sys_close:
    push ebp
    mov ebp, esp

    and esp, -16

    push ebx

    mov eax, 0x06
    mov ebx, [ebp+8]
    int 0x80

    pop ebx

    mov esp, ebp
    pop ebp
    ret

    sys_exit:
	mov eax, 1	; ID del Syscall EXIT
	int 80h	; Ejecucion de la llamada


