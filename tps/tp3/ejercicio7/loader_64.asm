section .text
    GLOBAL _start
    extern main

    _start:
        ; stack: [argc][argv][envp]
        pop rdi         ; rdi = argc
        mov rsi, rsp    ; rsi = argv
        call main       ; main(argc, argv)
        mov rax, 0x01
        mov rbx, 1
        int 0x80