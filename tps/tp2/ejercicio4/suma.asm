section .text
  GLOBAL _start
  EXTERN num2str
  EXTERN puts
  EXTERN exit

_start:
  push ebp
  mov ebp, esp
  
  push 5
  call _addall

  mov byte [buffer + 31], 0
  push eax
  push buffer
  call num2str

  mov ebx, buffer
  call puts
  call exit
  
  
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

section .bss
  buffer resb 32
