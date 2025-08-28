section .data
    msg db "Hello, World",10,0
    len equ $-msg

section .text
    GLOBAL _start
    EXTERN write
    EXTERN exit

_start:
	push ebp 	;armo el stack frame
	mov ebp, esp

    push len 
    push msg
    call write
    call exit

    mov esp, ebp	; desarmo el stack frame                                                                                                            
	pop ebp                                                                                                                                                                                                                                                                     

    ret