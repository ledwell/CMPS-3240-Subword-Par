	.file	"myblas.c"
	.text
	.globl	faxpy
	.type	faxpy, @function
faxpy:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)	#n
	movss	%xmm0, -24(%rbp) #a
	movq	%rsi, -32(%rbp) #result
	movq	%rdx, -40(%rbp) #y
	movq	%rcx, -48(%rbp) #result
	movl	$0, -4(%rbp)	#counter i = 0
	jmp	.L2
.L3:
	movl	-4(%rbp), %eax
	cltq	# 64 bit promotion 
	leaq	0(,%rax,4), %rdx #rdx -< 4*i
	movq	-32(%rbp), %rax	#rax <- result
	addq	%rdx, %rax	# result = result +4*1
	movss	(%rax), %xmm0 
	movaps	%xmm0, %xmm1
	mulss	-24(%rbp), %xmm1
	movl	-4(%rbp), %eax #get i
	cltq #promote to 64 bits
	leaq	0(,%rax,4), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movss	(%rax), %xmm0
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	addss	%xmm1, %xmm0
	movss	%xmm0, (%rax)
	addl	$1, -4(%rbp)
.L2:
	movl	-4(%rbp), %eax #i
	cmpl	-20(%rbp), %eax #n
	jl	.L3
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	faxpy, .-faxpy
	.ident	"GCC: (Debian 8.3.0-6) 8.3.0"
	.section	.note.GNU-stack,"",@progbits
