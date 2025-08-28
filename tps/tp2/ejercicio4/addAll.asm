section .text
  GLOBAL _start

_start:
  push ebp
  mov ebp, esp
  
  push 15
  call _addall
  push eax
  mov eax, 4
  mov ebx, 1
  mov ecx, [esp]
  mov edx, 
  
_addall:
  push ebp
  mov ebp, esp

  mov eax, 0
  mov ebx, [ebp+8]

  CICLO:
    add eax, ebx
    dec ebx
    jnz CICLO

  mov esp, ebp
  pop ebp
  ret

section .data

section .bss
