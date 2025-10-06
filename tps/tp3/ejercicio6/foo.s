	.file	"foo.c"
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
# foo.c:1: void foo() {
	mov	eax, DWORD PTR gs:20	# tmp99, MEM[(<address-space-2> unsigned int *)20B]
	mov	DWORD PTR -12[ebp], eax	# D.2367, tmp99
	xor	eax, eax	# tmp99
# foo.c:3: }
	nop	
	mov	eax, DWORD PTR -12[ebp]	# tmp100, D.2367
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
	.section	.text.__x86.get_pc_thunk.ax,"axG",@progbits,__x86.get_pc_thunk.ax,comdat
	.globl	__x86.get_pc_thunk.ax
	.hidden	__x86.get_pc_thunk.ax
	.type	__x86.get_pc_thunk.ax, @function
__x86.get_pc_thunk.ax:
.LFB1:
	.cfi_startproc
	mov	eax, DWORD PTR [esp]	#,
	ret
	.cfi_endproc
.LFE1:
	.hidden	__stack_chk_fail_local
	.ident	"GCC: (Ubuntu 14.2.0-4ubuntu2~24.04) 14.2.0"
	.section	.note.GNU-stack,"",@progbits
