section .data
  msg db "h4ppy c0d1ng",10,0

section .text
  GLOBAL _start
  EXTERN print
  EXTERN exit

_start:
  mov ecx, msg ; Puntero al mensaje

.CICLO:
  mov al, [ecx]     ; Cargar el carácter actual
  cmp al, 0         ; ¿Es el final del string?
  je .FIN
  
  cmp al, 'a'       ; ¿Es menor que 'a'?
  jl .CONTINUE
  
  cmp al, 'z'       ; ¿Es mayor que 'z'?
  jg .CONTINUE
  
  sub al, 32        ; Convertir a mayúscula (restar 32)
  mov [ecx], al     ; Guardar el carácter modificado

.CONTINUE:
  inc ecx           ; Avanzar al siguiente carácter
  jmp .CICLO

.FIN:
  mov ex, msg      ; Pasar el mensaje modificado a print
  call print
  call exit