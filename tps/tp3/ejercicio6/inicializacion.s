	.file	"inicializacion.c"
	.intel_syntax noprefix
# GNU C17 (Ubuntu 14.2.0-4ubuntu2~24.04) version 14.2.0 (x86_64-linux-gnu)
#	compiled by GNU C version 14.2.0, GMP version 6.3.0, MPFR version 4.2.1, MPC version 1.3.1, isl version isl-0.26-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -m32 -masm=intel -mtune=generic -march=i686 -O0 -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection
	.text
	.globl	foo
	.type	foo, @function
foo:
.LFB0:
	.cfi_startproc
	push	ebp	#
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp	#,
	.cfi_def_cfa_register 5
	sub	esp, 104	#,
	call	__x86.get_pc_thunk.ax	#
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_	# tmp98,
# inicializacion.c:1: void foo() {
	mov	eax, DWORD PTR gs:20	# tmp99, MEM[(<address-space-2> unsigned int *)20B]
	mov	DWORD PTR -12[ebp], eax	# D.2381, tmp99
	xor	eax, eax	# tmp99
# inicializacion.c:3: }
	nop	
	mov	eax, DWORD PTR -12[ebp]	# tmp100, D.2381
	sub	eax, DWORD PTR gs:20	# tmp100, MEM[(<address-space-2> unsigned int *)20B]
	je	.L2	#,
	call	__stack_chk_fail_local	#
.L2:
	leave	
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	
	.cfi_endproc
.LFE0:
	.size	foo, .-foo
	.globl	foo2
	.type	foo2, @function
foo2:
.LFB1:
	.cfi_startproc
	push	ebp	#
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp	#,
	.cfi_def_cfa_register 5
	sub	esp, 24	#,
	call	__x86.get_pc_thunk.ax	#
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_	# tmp98,
# inicializacion.c:5: void foo2() {
	mov	eax, DWORD PTR gs:20	# tmp99, MEM[(<address-space-2> unsigned int *)20B]
	mov	DWORD PTR -12[ebp], eax	# D.2383, tmp99
	xor	eax, eax	# tmp99
# inicializacion.c:6:     char msg[] = "mensaje";
	mov	DWORD PTR -20[ebp], 1936614765	# msg,
	mov	DWORD PTR -16[ebp], 6646369	# msg,
# inicializacion.c:7: }
	nop	
	mov	eax, DWORD PTR -12[ebp]	# tmp100, D.2383
	sub	eax, DWORD PTR gs:20	# tmp100, MEM[(<address-space-2> unsigned int *)20B]
	je	.L4	#,
	call	__stack_chk_fail_local	#
.L4:
	leave	
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	
	.cfi_endproc
.LFE1:
	.size	foo2, .-foo2
	.globl	foo3
	.type	foo3, @function
foo3:
.LFB2:
	.cfi_startproc
	push	ebp	#
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp	#,
	.cfi_def_cfa_register 5
	sub	esp, 104	#,
	call	__x86.get_pc_thunk.ax	#
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_	# tmp98,
# inicializacion.c:9: void foo3() {
	mov	eax, DWORD PTR gs:20	# tmp99, MEM[(<address-space-2> unsigned int *)20B]
	mov	DWORD PTR -12[ebp], eax	# D.2384, tmp99
	xor	eax, eax	# tmp99
# inicializacion.c:11:     numeros[10] = 123;
	mov	DWORD PTR -52[ebp], 123	# numeros[10],
# inicializacion.c:12: }
	nop	
	mov	eax, DWORD PTR -12[ebp]	# tmp100, D.2384
	sub	eax, DWORD PTR gs:20	# tmp100, MEM[(<address-space-2> unsigned int *)20B]
	je	.L6	#,
	call	__stack_chk_fail_local	#
.L6:
	leave	
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	
	.cfi_endproc
.LFE2:
	.size	foo3, .-foo3
	.globl	foo4
	.type	foo4, @function
foo4:
.LFB3:
	.cfi_startproc
	push	ebp	#
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp	#,
	.cfi_def_cfa_register 5
	push	edi	#
	sub	esp, 100	#,
	.cfi_offset 7, -12
	call	__x86.get_pc_thunk.ax	#
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_	# tmp98,
# inicializacion.c:14: void foo4() {
	mov	eax, DWORD PTR gs:20	# tmp99, MEM[(<address-space-2> unsigned int *)20B]
	mov	DWORD PTR -12[ebp], eax	# D.2385, tmp99
	xor	eax, eax	# tmp99
# inicializacion.c:15:     int numeros[20] = {0};
	lea	edx, -92[ebp]	# tmp100,
	mov	eax, 0	# tmp101,
	mov	ecx, 20	# tmp102,
	mov	edi, edx	# tmp100, tmp100
	rep stosd
# inicializacion.c:16:     numeros[10] = 123;
	mov	DWORD PTR -52[ebp], 123	# numeros[10],
# inicializacion.c:17: }
	nop	
	mov	eax, DWORD PTR -12[ebp]	# tmp103, D.2385
	sub	eax, DWORD PTR gs:20	# tmp103, MEM[(<address-space-2> unsigned int *)20B]
	je	.L8	#,
	call	__stack_chk_fail_local	#
.L8:
	mov	edi, DWORD PTR -4[ebp]	#,
	leave	
	.cfi_restore 5
	.cfi_restore 7
	.cfi_def_cfa 4, 4
	ret	
	.cfi_endproc
.LFE3:
	.size	foo4, .-foo4
	.globl	numeros_foo5
	.bss
	.align 32
	.type	numeros_foo5, @object
	.size	numeros_foo5, 80
numeros_foo5:
	.zero	80
	.globl	numeros_foo6
	.align 32
	.type	numeros_foo6, @object
	.size	numeros_foo6, 80
numeros_foo6:
	.zero	80
	.section	.text.__x86.get_pc_thunk.ax,"axG",@progbits,__x86.get_pc_thunk.ax,comdat
	.globl	__x86.get_pc_thunk.ax
	.hidden	__x86.get_pc_thunk.ax
	.type	__x86.get_pc_thunk.ax, @function
__x86.get_pc_thunk.ax:
.LFB4:
	.cfi_startproc
	mov	eax, DWORD PTR [esp]	#,
	ret
	.cfi_endproc
.LFE4:
	.hidden	__stack_chk_fail_local
	.ident	"GCC: (Ubuntu 14.2.0-4ubuntu2~24.04) 14.2.0"
	.section	.note.GNU-stack,"",@progbits
