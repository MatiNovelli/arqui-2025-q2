GLOBAL print
GLOBAL puts
GLOBAL write
GLOBAL exit
GLOBAL numtostr
GLOBAL num2str
GLOBAL str2num
GLOBAL printNewLine

section .data
	new_line db 10,0


section .text

;===============================================================================
; write - imprime una cadena en la salida estandar. Es mas eficiente que print, 
; pero requiere mas argumentos, no usa los registros.
;===============================================================================
; Argumentos (En orden de pusheo):
;	stack: largo de la cadena
;	stack: cadena a imprimir en pantalla
;===============================================================================
write:
	push ebp 	;armo el stack frame
	mov ebp, esp

	pushad		; hago backup de los registros
	

	mov ecx, [ebp+8] ; cadena a imprimir
	mov edx, [ebp+12] ; largo de la cadena

	mov ebx, 1	; FileDescriptor (STDOUT)
	mov eax, 4	; ID del Syscall WRITE
	int 80h
	
	popad 		; restauro los registros	

	mov esp, ebp	; desarmo el stack frame
	pop ebp

	ret	

;===============================================================================
; print - imprime una cadena en la salida estandar
;===============================================================================
; Argumentos:
;	ebx: cadena a imprimer en pantalla, terminada con 0
;===============================================================================
print:
	pushad		; hago backup de los registros

	call strlen
	mov ecx, ebx	; la cadena esta en ebx
	mov edx, eax	; en eax viene el largo de la cadena

	mov ebx, 1	; FileDescriptor (STDOUT)
	mov eax, 4	; ID del Syscall WRITE
	int 80h
	
	popad 		; restauro los registros
	ret	


;===============================================================================
; puts - imprime una cadena en la salida estandar.
; Agrega un salto de linea al final.
;===============================================================================
; Argumentos:
;	ebx: cadena a imprimer en pantalla, terminada con 0
;===============================================================================
puts:
	pushad
	call print
	mov ebx, new_line
	call print
	popad
	ret

;===============================================================================
; imprime un \n en pantalla
;===============================================================================
printNewLine:
	pushad

	mov ecx, new_line 	    ; Puntero a la cadena
	mov edx, 1				; Largo de la cadena 
	mov ebx, 1		    	; FileDescriptor (STDOUT)
	mov eax, 4		    	; ID del Syscall WRITE
	int 80h		        	; Ejecucion de la llamada

	popad
	ret
	
;===============================================================================
; exit - termina el programa
;===============================================================================
; Argumentos:
;	ebx: valor de retorno al sistema operativo
;===============================================================================
exit:
	mov eax, 1	; ID del Syscall EXIT
	int 80h	; Ejecucion de la llamada


;===============================================================================
; strlen - calcula la longitud de una cadena terminada con 0
;===============================================================================
; Argumentos:
;	ebx: puntero a la cadena
; Retorno:
;	eax: largo de la cadena
;===============================================================================
strlen:
	push ecx ; preservo ecx	
	push ebx ; preservo ebx
	pushf	; preservo los flags

	mov ecx, 0	; inicializo el contador en 0
.loop:			; etiqueta local a strlen
	mov al, [ebx] 	; traigo al registo AL el valor apuntado por ebx
	cmp al, 0	; lo comparo con 0 o NULL
	jz .fin 	; Si es cero, termino.
	inc ecx		; Incremento el contador
	inc ebx
	jmp .loop
.fin:				; etiqueta local a strlen
	mov eax, ecx	
	
	popf
	pop ebx ; restauro ebx	
	pop ecx ; restauro ecx
	ret


;===============================================================================
; numtostr - convierte un entero en un string guardandolo en 
; el stack
;===============================================================================
; Argumentos:
;	el numero entero de 32 bit que se recibe en el stack
; ESP +4 a convertir
; Retorno:
;	los caracteres ASCII en el stack se devuelven  
;===============================================================================
numtostr:
	mov ebp,esp ; guardo el puntero del stack
	pushad	
	MOV ECX,10
	MOV EDX,0   ; Pongo en cero la parte mas significativa
	Mov EAX, dword[EBp +4]  ;Cargo el numero a convertir
	MOV EBX,dword[ebp +8]
	ADD EBX,9               ; me posiciono al final del string para empezar a colocar
	mov byte [ebx], 0       ; los caracteres ASCII de derecha a izquierda comenzando con cero
	dec ebx                 ; binario
.sigo:	
	DIV ECX
	OR Dl, 0x30  ; convierto el resto  menor a 10 a ASCII
	mov byte [ebx], Dl  
	DEC EBX      ; si el cociente es mayor a 0 sigo dividiendo
	cmp al,0
	jz .termino
	mov edx,0
	jmp .sigo
.termino:
	inc ebx
	call print
	POPAD
	mov esp,ebp	 
	ret

;===============================================================================
; num2str - Convierte un número en string decimal terminado en 0
;===============================================================================
; Argumentos:
;   Por stack en orden:
;   Número a convertir (entero positivo)
;   Puntero a buffer (zona de memoria donde guardar el string)
; 
; Retorno:
;   El numero en string en la zona de memoria pasada
;===============================================================================

num2str:
    push ebp  ;armo el stackframe
    mov ebp, esp

    pushad ;backup de los registros

    mov ebx, [ebp+8] ;agarro la zona de memoria
    mov eax, dword [ebp+12] ;agarro el numero
    mov esi, 10 

	push -1

    .CICLO:
	xor edx, edx ;Limpio el registro edx porque lo voy a usar
	div esi ; eax /= 10 
	add edx, '0' ; transformo el numero en string
	push edx 

	cmp eax, 0 ; si eax es 0 -> ya termine de dividir el numero y tengo todos sus digitos en el stack
	je .GETNUM
	
	jmp .CICLO ; si no sigo el ciclo

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


;===============================================================================
; str2num - Convierte un string terminado en 0, en un número decimal
;===============================================================================
; Argumentos:
;   ebx: String de un número, terminado en 0
; 
; Retorno:
;   ebx: El string convertido a número
;===============================================================================
str2num:
    push ebp
    mov ebp, esp

    push eax ;Backup de los registros que voy a usar
    push edx

    xor eax, eax        ; acumulador = 0

	.CICLO:
		mov dl, byte [ebx]   ; leo un carácter
		cmp dl, 0              ; fin del string?
		je .FIN
		sub dl, '0'            ; convierto de ascii a número

		imul eax, eax, 10       ; acum = acum * 10
		add  eax, edx           ; acum = acum + dígito

		inc ebx                 ; siguiente carácter
		jmp .CICLO

	.FIN:
		mov ebx, eax            ; retorno en ebx

		pop edx
		pop eax

		mov esp, ebp
		pop ebp
		ret
