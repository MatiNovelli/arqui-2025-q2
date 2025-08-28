num2str:
    push ebp  ;armo el stackframe
    mov ebp, esp

    pushad ;backup de los registros

    mov ebx, [ebp+8] ;agarro la zona de memoria
    mov eax, [ebp+12] ;agarro el numero
    mov esi, 10 

	push -1

    .CICLO:
	xor edx, edx ;Limpio el registro edx porque lo voy a usar
	cmp eax, 0
	je .GETNUM
	div esi
	add edx, '0'
	push edx
	jmp .CICLO
	
    .GETNUM:
    pop eax
    cmp eax, -1
    je .FIN 
    mov [ebx], eax
    inc ebx
    jmp .GETNUM

    .FIN:
    popad

    mov esp, ebp ;desarmo el stackframe
    pop ebp
    ret