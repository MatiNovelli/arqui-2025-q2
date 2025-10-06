;Compilado con gcc -m32 -S -O0 -masm=intel -fno-asynchronous-unwind-tables -fno-exceptions -fno-pic fibo.c -o fibo.s

	.file	"fibo.c"
	.intel_syntax noprefix
	.text
	.globl	fibo
	.type	fibo, @function
fibo:
	push	ebp
	mov	ebp, esp
	push	ebx
	sub	esp, 4
	cmp	DWORD PTR [ebp+8], 1
	je	.L2
	cmp	DWORD PTR [ebp+8], 2
	jne	.L3
.L2:
	mov	eax, 1
	jmp	.L4
.L3:
	mov	eax, DWORD PTR [ebp+8]
	sub	eax, 1
	sub	esp, 12
	push	eax
	call	fibo
	add	esp, 16
	mov	ebx, eax
	mov	eax, DWORD PTR [ebp+8]
	sub	eax, 2
	sub	esp, 12
	push	eax
	call	fibo
	add	esp, 16
	add	eax, ebx
.L4:
	mov	ebx, DWORD PTR [ebp-4]
	leave
	ret
	.size	fibo, .-fibo
	.section	.rodata
.LC0:
	.string	"%d\n"
	.text
	.globl	main
	.type	main, @function
main:
	lea	ecx, [esp+4]
	and	esp, -16
	push	DWORD PTR [ecx-4]
	push	ebp
	mov	ebp, esp
	push	ecx
	sub	esp, 4
	sub	esp, 12
	push	3
	call	fibo
	add	esp, 16
	sub	esp, 8
	push	eax
	push	OFFSET FLAT:.LC0
	call	printf
	add	esp, 16
	mov	eax, 0
	mov	ecx, DWORD PTR [ebp-4]
	leave
	lea	esp, [ecx-4]
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 14.2.0-4ubuntu2~24.04) 14.2.0"
	.section	.note.GNU-stack,"",@progbits
