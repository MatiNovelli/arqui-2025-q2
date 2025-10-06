section .text
    GLOBAL _start
    EXTERN print, puts, exit, printNewLine

    _start:
        mov eax, 0          ; función 0 = Vendor ID
        cpuid

        mov [buffer], ebx
        mov byte [buffer+4], 0
        mov ebx, buffer

        call print ;Printeo ebx

        mov [buffer], edx
        mov byte [buffer+4], 0
        mov ebx, buffer
        
        call print ;Prineto edx

        mov [buffer], ecx
        mov byte [buffer+4], 0
        mov ebx, buffer
        
        call print ;Prineto ecx

        call printNewLine
            
        call exit