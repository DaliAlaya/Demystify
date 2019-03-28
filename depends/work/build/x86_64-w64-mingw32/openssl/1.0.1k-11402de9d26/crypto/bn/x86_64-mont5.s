.text	

.globl	bn_mul_mont_gather5
.def	bn_mul_mont_gather5;	.scl 2;	.type 32;	.endef
.p2align	6
bn_mul_mont_gather5:
	movq	%rdi,8(%rsp)
	movq	%rsi,16(%rsp)
	movq	%rsp,%rax
.LSEH_begin_bn_mul_mont_gather5:
	movq	%rcx,%rdi
	movq	%rdx,%rsi
	movq	%r8,%rdx
	movq	%r9,%rcx
	movq	40(%rsp),%r8
	movq	48(%rsp),%r9

	testl	$3,%r9d
	jnz	.Lmul_enter
	cmpl	$8,%r9d
	jb	.Lmul_enter
	jmp	.Lmul4x_enter

.p2align	4
.Lmul_enter:
	movl	%r9d,%r9d
	movl	56(%rsp),%r10d
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	leaq	-40(%rsp),%rsp
	movaps	%xmm6,(%rsp)
	movaps	%xmm7,16(%rsp)
.Lmul_alloca:
	movq	%rsp,%rax
	leaq	2(%r9),%r11
	negq	%r11
	leaq	(%rsp,%r11,8),%rsp
	andq	$-1024,%rsp

	movq	%rax,8(%rsp,%r9,8)
.Lmul_body:
	movq	%rdx,%r12
	movq	%r10,%r11
	shrq	$3,%r10
	andq	$7,%r11
	notq	%r10
	leaq	.Lmagic_masks(%rip),%rax
	andq	$3,%r10
	leaq	96(%r12,%r11,8),%r12
	movq	0(%rax,%r10,8),%xmm4
	movq	8(%rax,%r10,8),%xmm5
	movq	16(%rax,%r10,8),%xmm6
	movq	24(%rax,%r10,8),%xmm7

	movq	-96(%r12),%xmm0
	movq	-32(%r12),%xmm1
	pand	%xmm4,%xmm0
	movq	32(%r12),%xmm2
	pand	%xmm5,%xmm1
	movq	96(%r12),%xmm3
	pand	%xmm6,%xmm2
	por	%xmm1,%xmm0
	pand	%xmm7,%xmm3
	por	%xmm2,%xmm0
	leaq	256(%r12),%r12
	por	%xmm3,%xmm0

.byte	102,72,15,126,195

	movq	(%r8),%r8
	movq	(%rsi),%rax

	xorq	%r14,%r14
	xorq	%r15,%r15

	movq	-96(%r12),%xmm0
	movq	-32(%r12),%xmm1
	pand	%xmm4,%xmm0
	movq	32(%r12),%xmm2
	pand	%xmm5,%xmm1

	movq	%r8,%rbp
	mulq	%rbx
	movq	%rax,%r10
	movq	(%rcx),%rax

	movq	96(%r12),%xmm3
	pand	%xmm6,%xmm2
	por	%xmm1,%xmm0
	pand	%xmm7,%xmm3

	imulq	%r10,%rbp
	movq	%rdx,%r11

	por	%xmm2,%xmm0
	leaq	256(%r12),%r12
	por	%xmm3,%xmm0

	mulq	%rbp
	addq	%rax,%r10
	movq	8(%rsi),%rax
	adcq	$0,%rdx
	movq	%rdx,%r13

	leaq	1(%r15),%r15
	jmp	.L1st_enter

.p2align	4
.L1st:
	addq	%rax,%r13
	movq	(%rsi,%r15,8),%rax
	adcq	$0,%rdx
	addq	%r11,%r13
	movq	%r10,%r11
	adcq	$0,%rdx
	movq	%r13,-16(%rsp,%r15,8)
	movq	%rdx,%r13

.L1st_enter:
	mulq	%rbx
	addq	%rax,%r11
	movq	(%rcx,%r15,8),%rax
	adcq	$0,%rdx
	leaq	1(%r15),%r15
	movq	%rdx,%r10

	mulq	%rbp
	cmpq	%r9,%r15
	jne	.L1st

.byte	102,72,15,126,195

	addq	%rax,%r13
	movq	(%rsi),%rax
	adcq	$0,%rdx
	addq	%r11,%r13
	adcq	$0,%rdx
	movq	%r13,-16(%rsp,%r15,8)
	movq	%rdx,%r13
	movq	%r10,%r11

	xorq	%rdx,%rdx
	addq	%r11,%r13
	adcq	$0,%rdx
	movq	%r13,-8(%rsp,%r9,8)
	movq	%rdx,(%rsp,%r9,8)

	leaq	1(%r14),%r14
	jmp	.Louter
.p2align	4
.Louter:
	xorq	%r15,%r15
	movq	%r8,%rbp
	movq	(%rsp),%r10

	movq	-96(%r12),%xmm0
	movq	-32(%r12),%xmm1
	pand	%xmm4,%xmm0
	movq	32(%r12),%xmm2
	pand	%xmm5,%xmm1

	mulq	%rbx
	addq	%rax,%r10
	movq	(%rcx),%rax
	adcq	$0,%rdx

	movq	96(%r12),%xmm3
	pand	%xmm6,%xmm2
	por	%xmm1,%xmm0
	pand	%xmm7,%xmm3

	imulq	%r10,%rbp
	movq	%rdx,%r11

	por	%xmm2,%xmm0
	leaq	256(%r12),%r12
	por	%xmm3,%xmm0

	mulq	%rbp
	addq	%rax,%r10
	movq	8(%rsi),%rax
	adcq	$0,%rdx
	movq	8(%rsp),%r10
	movq	%rdx,%r13

	leaq	1(%r15),%r15
	jmp	.Linner_enter

.p2align	4
.Linner:
	addq	%rax,%r13
	movq	(%rsi,%r15,8),%rax
	adcq	$0,%rdx
	addq	%r10,%r13
	movq	(%rsp,%r15,8),%r10
	adcq	$0,%rdx
	movq	%r13,-16(%rsp,%r15,8)
	movq	%rdx,%r13

.Linner_enter:
	mulq	%rbx
	addq	%rax,%r11
	movq	(%rcx,%r15,8),%rax
	adcq	$0,%rdx
	addq	%r11,%r10
	movq	%rdx,%r11
	adcq	$0,%r11
	leaq	1(%r15),%r15

	mulq	%rbp
	cmpq	%r9,%r15
	jne	.Linner

.byte	102,72,15,126,195

	addq	%rax,%r13
	movq	(%rsi),%rax
	adcq	$0,%rdx
	addq	%r10,%r13
	movq	(%rsp,%r15,8),%r10
	adcq	$0,%rdx
	movq	%r13,-16(%rsp,%r15,8)
	movq	%rdx,%r13

	xorq	%rdx,%rdx
	addq	%r11,%r13
	adcq	$0,%rdx
	addq	%r10,%r13
	adcq	$0,%rdx
	movq	%r13,-8(%rsp,%r9,8)
	movq	%rdx,(%rsp,%r9,8)

	leaq	1(%r14),%r14
	cmpq	%r9,%r14
	jl	.Louter

	xorq	%r14,%r14
	movq	(%rsp),%rax
	leaq	(%rsp),%rsi
	movq	%r9,%r15
	jmp	.Lsub
.p2align	4
.Lsub:	sbbq	(%rcx,%r14,8),%rax
	movq	%rax,(%rdi,%r14,8)
	movq	8(%rsi,%r14,8),%rax
	leaq	1(%r14),%r14
	decq	%r15
	jnz	.Lsub

	sbbq	$0,%rax
	xorq	%r14,%r14
	andq	%rax,%rsi
	notq	%rax
	movq	%rdi,%rcx
	andq	%rax,%rcx
	movq	%r9,%r15
	orq	%rcx,%rsi
.p2align	4
.Lcopy:
	movq	(%rsi,%r14,8),%rax
	movq	%r14,(%rsp,%r14,8)
	movq	%rax,(%rdi,%r14,8)
	leaq	1(%r14),%r14
	subq	$1,%r15
	jnz	.Lcopy

	movq	8(%rsp,%r9,8),%rsi
	movq	$1,%rax
	movaps	(%rsi),%xmm6
	movaps	16(%rsi),%xmm7
	leaq	40(%rsi),%rsi
	movq	(%rsi),%r15
	movq	8(%rsi),%r14
	movq	16(%rsi),%r13
	movq	24(%rsi),%r12
	movq	32(%rsi),%rbp
	movq	40(%rsi),%rbx
	leaq	48(%rsi),%rsp
.Lmul_epilogue:
	movq	8(%rsp),%rdi
	movq	16(%rsp),%rsi
	.byte	0xf3,0xc3
.LSEH_end_bn_mul_mont_gather5:
.def	bn_mul4x_mont_gather5;	.scl 3;	.type 32;	.endef
.p2align	4
bn_mul4x_mont_gather5:
	movq	%rdi,8(%rsp)
	movq	%rsi,16(%rsp)
	movq	%rsp,%rax
.LSEH_begin_bn_mul4x_mont_gather5:
	movq	%rcx,%rdi
	movq	%rdx,%rsi
	movq	%r8,%rdx
	movq	%r9,%rcx
	movq	40(%rsp),%r8
	movq	48(%rsp),%r9

.Lmul4x_enter:
	movl	%r9d,%r9d
	movl	56(%rsp),%r10d
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	leaq	-40(%rsp),%rsp
	movaps	%xmm6,(%rsp)
	movaps	%xmm7,16(%rsp)
.Lmul4x_alloca:
	movq	%rsp,%rax
	leaq	4(%r9),%r11
	negq	%r11
	leaq	(%rsp,%r11,8),%rsp
	andq	$-1024,%rsp

	movq	%rax,8(%rsp,%r9,8)
.Lmul4x_body:
	movq	%rdi,16(%rsp,%r9,8)
	movq	%rdx,%r12
	movq	%r10,%r11
	shrq	$3,%r10
	andq	$7,%r11
	notq	%r10
	leaq	.Lmagic_masks(%rip),%rax
	andq	$3,%r10
	leaq	96(%r12,%r11,8),%r12
	movq	0(%rax,%r10,8),%xmm4
	movq	8(%rax,%r10,8),%xmm5
	movq	16(%rax,%r10,8),%xmm6
	movq	24(%rax,%r10,8),%xmm7

	movq	-96(%r12),%xmm0
	movq	-32(%r12),%xmm1
	pand	%xmm4,%xmm0
	movq	32(%r12),%xmm2
	pand	%xmm5,%xmm1
	movq	96(%r12),%xmm3
	pand	%xmm6,%xmm2
	por	%xmm1,%xmm0
	pand	%xmm7,%xmm3
	por	%xmm2,%xmm0
	leaq	256(%r12),%r12
	por	%xmm3,%xmm0

.byte	102,72,15,126,195
	movq	(%r8),%r8
	movq	(%rsi),%rax

	xorq	%r14,%r14
	xorq	%r15,%r15

	movq	-96(%r12),%xmm0
	movq	-32(%r12),%xmm1
	pand	%xmm4,%xmm0
	movq	32(%r12),%xmm2
	pand	%xmm5,%xmm1

	movq	%r8,%rbp
	mulq	%rbx
	movq	%rax,%r10
	movq	(%rcx),%rax

	movq	96(%r12),%xmm3
	pand	%xmm6,%xmm2
	por	%xmm1,%xmm0
	pand	%xmm7,%xmm3

	imulq	%r10,%rbp
	movq	%rdx,%r11

	por	%xmm2,%xmm0
	leaq	256(%r12),%r12
	por	%xmm3,%xmm0

	mulq	%rbp
	addq	%rax,%r10
	movq	8(%rsi),%rax
	adcq	$0,%rdx
	movq	%rdx,%rdi

	mulq	%rbx
	addq	%rax,%r11
	movq	8(%rcx),%rax
	adcq	$0,%rdx
	movq	%rdx,%r10

	mulq	%rbp
	addq	%rax,%rdi
	movq	16(%rsi),%rax
	adcq	$0,%rdx
	addq	%r11,%rdi
	leaq	4(%r15),%r15
	adcq	$0,%rdx
	movq	%rdi,(%rsp)
	movq	%rdx,%r13
	jmp	.L1st4x
.p2align	4
.L1st4x:
	mulq	%rbx
	addq	%rax,%r10
	movq	-16(%rcx,%r15,8),%rax
	adcq	$0,%rdx
	movq	%rdx,%r11

	mulq	%rbp
	addq	%rax,%r13
	movq	-8(%rsi,%r15,8),%rax
	adcq	$0,%rdx
	addq	%r10,%r13
	adcq	$0,%rdx
	movq	%r13,-24(%rsp,%r15,8)
	movq	%rdx,%rdi

	mulq	%rbx
	addq	%rax,%r11
	movq	-8(%rcx,%r15,8),%rax
	adcq	$0,%rdx
	movq	%rdx,%r10

	mulq	%rbp
	addq	%rax,%rdi
	movq	(%rsi,%r15,8),%rax
	adcq	$0,%rdx
	addq	%r11,%rdi
	adcq	$0,%rdx
	movq	%rdi,-16(%rsp,%r15,8)
	movq	%rdx,%r13

	mulq	%rbx
	addq	%rax,%r10
	movq	(%rcx,%r15,8),%rax
	adcq	$0,%rdx
	movq	%rdx,%r11

	mulq	%rbp
	addq	%rax,%r13
	movq	8(%rsi,%r15,8),%rax
	adcq	$0,%rdx
	addq	%r10,%r13
	adcq	$0,%rdx
	movq	%r13,-8(%rsp,%r15,8)
	movq	%rdx,%rdi

	mulq	%rbx
	addq	%rax,%r11
	movq	8(%rcx,%r15,8),%rax
	adcq	$0,%rdx
	leaq	4(%r15),%r15
	movq	%rdx,%r10

	mulq	%rbp
	addq	%rax,%rdi
	movq	-16(%rsi,%r15,8),%rax
	adcq	$0,%rdx
	addq	%r11,%rdi
	adcq	$0,%rdx
	movq	%rdi,-32(%rsp,%r15,8)
	movq	%rdx,%r13
	cmpq	%r9,%r15
	jl	.L1st4x

	mulq	%rbx
	addq	%rax,%r10
	movq	-16(%rcx,%r15,8),%rax
	adcq	$0,%rdx
	movq	%rdx,%r11

	mulq	%rbp
	addq	%rax,%r13
	movq	-8(%rsi,%r15,8),%rax
	adcq	$0,%rdx
	addq	%r10,%r13
	adcq	$0,%rdx
	movq	%r13,-24(%rsp,%r15,8)
	movq	%rdx,%rdi

	mulq	%rbx
	addq	%rax,%r11
	movq	-8(%rcx,%r15,8),%rax
	adcq	$0,%rdx
	movq	%rdx,%r10

	mulq	%rbp
	addq	%rax,%rdi
	movq	(%rsi),%rax
	adcq	$0,%rdx
	addq	%r11,%rdi
	adcq	$0,%rdx
	movq	%rdi,-16(%rsp,%r15,8)
	movq	%rdx,%r13

.byte	102,72,15,126,195

	xorq	%rdi,%rdi
	addq	%r10,%r13
	adcq	$0,%rdi
	movq	%r13,-8(%rsp,%r15,8)
	movq	%rdi,(%rsp,%r15,8)

	leaq	1(%r14),%r14
.p2align	2
.Louter4x:
	xorq	%r15,%r15
	movq	-96(%r12),%xmm0
	movq	-32(%r12),%xmm1
	pand	%xmm4,%xmm0
	movq	32(%r12),%xmm2
	pand	%xmm5,%xmm1

	movq	(%rsp),%r10
	movq	%r8,%rbp
	mulq	%rbx
	addq	%rax,%r10
	movq	(%rcx),%rax
	adcq	$0,%rdx

	movq	96(%r12),%xmm3
	pand	%xmm6,%xmm2
	por	%xmm1,%xmm0
	pand	%xmm7,%xmm3

	imulq	%r10,%rbp
	movq	%rdx,%r11

	por	%xmm2,%xmm0
	leaq	256(%r12),%r12
	por	%xmm3,%xmm0

	mulq	%rbp
	addq	%rax,%r10
	movq	8(%rsi),%rax
	adcq	$0,%rdx
	movq	%rdx,%rdi

	mulq	%rbx
	addq	%rax,%r11
	movq	8(%rcx),%rax
	adcq	$0,%rdx
	addq	8(%rsp),%r11
	adcq	$0,%rdx
	movq	%rdx,%r10

	mulq	%rbp
	addq	%rax,%rdi
	movq	16(%rsi),%rax
	adcq	$0,%rdx
	addq	%r11,%rdi
	leaq	4(%r15),%r15
	adcq	$0,%rdx
	movq	%rdx,%r13
	jmp	.Linner4x
.p2align	4
.Linner4x:
	mulq	%rbx
	addq	%rax,%r10
	movq	-16(%rcx,%r15,8),%rax
	adcq	$0,%rdx
	addq	-16(%rsp,%r15,8),%r10
	adcq	$0,%rdx
	movq	%rdx,%r11

	mulq	%rbp
	addq	%rax,%r13
	movq	-8(%rsi,%r15,8),%rax
	adcq	$0,%rdx
	addq	%r10,%r13
	adcq	$0,%rdx
	movq	%rdi,-32(%rsp,%r15,8)
	movq	%rdx,%rdi

	mulq	%rbx
	addq	%rax,%r11
	movq	-8(%rcx,%r15,8),%rax
	adcq	$0,%rdx
	addq	-8(%rsp,%r15,8),%r11
	adcq	$0,%rdx
	movq	%rdx,%r10

	mulq	%rbp
	addq	%rax,%rdi
	movq	(%rsi,%r15,8),%rax
	adcq	$0,%rdx
	addq	%r11,%rdi
	adcq	$0,%rdx
	movq	%r13,-24(%rsp,%r15,8)
	movq	%rdx,%r13

	mulq	%rbx
	addq	%rax,%r10
	movq	(%rcx,%r15,8),%rax
	adcq	$0,%rdx
	addq	(%rsp,%r15,8),%r10
	adcq	$0,%rdx
	movq	%rdx,%r11

	mulq	%rbp
	addq	%rax,%r13
	movq	8(%rsi,%r15,8),%rax
	adcq	$0,%rdx
	addq	%r10,%r13
	adcq	$0,%rdx
	movq	%rdi,-16(%rsp,%r15,8)
	movq	%rdx,%rdi

	mulq	%rbx
	addq	%rax,%r11
	movq	8(%rcx,%r15,8),%rax
	adcq	$0,%rdx
	addq	8(%rsp,%r15,8),%r11
	adcq	$0,%rdx
	leaq	4(%r15),%r15
	movq	%rdx,%r10

	mulq	%rbp
	addq	%rax,%rdi
	movq	-16(%rsi,%r15,8),%rax
	adcq	$0,%rdx
	addq	%r11,%rdi
	adcq	$0,%rdx
	movq	%r13,-40(%rsp,%r15,8)
	movq	%rdx,%r13
	cmpq	%r9,%r15
	jl	.Linner4x

	mulq	%rbx
	addq	%rax,%r10
	movq	-16(%rcx,%r15,8),%rax
	adcq	$0,%rdx
	addq	-16(%rsp,%r15,8),%r10
	adcq	$0,%rdx
	movq	%rdx,%r11

	mulq	%rbp
	addq	%rax,%r13
	movq	-8(%rsi,%r15,8),%rax
	adcq	$0,%rdx
	addq	%r10,%r13
	adcq	$0,%rdx
	movq	%rdi,-32(%rsp,%r15,8)
	movq	%rdx,%rdi

	mulq	%rbx
	addq	%rax,%r11
	movq	-8(%rcx,%r15,8),%rax
	adcq	$0,%rdx
	addq	-8(%rsp,%r15,8),%r11
	adcq	$0,%rdx
	leaq	1(%r14),%r14
	movq	%rdx,%r10

	mulq	%rbp
	addq	%rax,%rdi
	movq	(%rsi),%rax
	adcq	$0,%rdx
	addq	%r11,%rdi
	adcq	$0,%rdx
	movq	%r13,-24(%rsp,%r15,8)
	movq	%rdx,%r13

.byte	102,72,15,126,195
	movq	%rdi,-16(%rsp,%r15,8)

	xorq	%rdi,%rdi
	addq	%r10,%r13
	adcq	$0,%rdi
	addq	(%rsp,%r9,8),%r13
	adcq	$0,%rdi
	movq	%r13,-8(%rsp,%r15,8)
	movq	%rdi,(%rsp,%r15,8)

	cmpq	%r9,%r14
	jl	.Louter4x
	movq	16(%rsp,%r9,8),%rdi
	movq	0(%rsp),%rax
	pxor	%xmm0,%xmm0
	movq	8(%rsp),%rdx
	shrq	$2,%r9
	leaq	(%rsp),%rsi
	xorq	%r14,%r14

	subq	0(%rcx),%rax
	movq	16(%rsi),%rbx
	movq	24(%rsi),%rbp
	sbbq	8(%rcx),%rdx
	leaq	-1(%r9),%r15
	jmp	.Lsub4x
.p2align	4
.Lsub4x:
	movq	%rax,0(%rdi,%r14,8)
	movq	%rdx,8(%rdi,%r14,8)
	sbbq	16(%rcx,%r14,8),%rbx
	movq	32(%rsi,%r14,8),%rax
	movq	40(%rsi,%r14,8),%rdx
	sbbq	24(%rcx,%r14,8),%rbp
	movq	%rbx,16(%rdi,%r14,8)
	movq	%rbp,24(%rdi,%r14,8)
	sbbq	32(%rcx,%r14,8),%rax
	movq	48(%rsi,%r14,8),%rbx
	movq	56(%rsi,%r14,8),%rbp
	sbbq	40(%rcx,%r14,8),%rdx
	leaq	4(%r14),%r14
	decq	%r15
	jnz	.Lsub4x

	movq	%rax,0(%rdi,%r14,8)
	movq	32(%rsi,%r14,8),%rax
	sbbq	16(%rcx,%r14,8),%rbx
	movq	%rdx,8(%rdi,%r14,8)
	sbbq	24(%rcx,%r14,8),%rbp
	movq	%rbx,16(%rdi,%r14,8)

	sbbq	$0,%rax
	movq	%rbp,24(%rdi,%r14,8)
	xorq	%r14,%r14
	andq	%rax,%rsi
	notq	%rax
	movq	%rdi,%rcx
	andq	%rax,%rcx
	leaq	-1(%r9),%r15
	orq	%rcx,%rsi

	movdqu	(%rsi),%xmm1
	movdqa	%xmm0,(%rsp)
	movdqu	%xmm1,(%rdi)
	jmp	.Lcopy4x
.p2align	4
.Lcopy4x:
	movdqu	16(%rsi,%r14,1),%xmm2
	movdqu	32(%rsi,%r14,1),%xmm1
	movdqa	%xmm0,16(%rsp,%r14,1)
	movdqu	%xmm2,16(%rdi,%r14,1)
	movdqa	%xmm0,32(%rsp,%r14,1)
	movdqu	%xmm1,32(%rdi,%r14,1)
	leaq	32(%r14),%r14
	decq	%r15
	jnz	.Lcopy4x

	shlq	$2,%r9
	movdqu	16(%rsi,%r14,1),%xmm2
	movdqa	%xmm0,16(%rsp,%r14,1)
	movdqu	%xmm2,16(%rdi,%r14,1)
	movq	8(%rsp,%r9,8),%rsi
	movq	$1,%rax
	movaps	(%rsi),%xmm6
	movaps	16(%rsi),%xmm7
	leaq	40(%rsi),%rsi
	movq	(%rsi),%r15
	movq	8(%rsi),%r14
	movq	16(%rsi),%r13
	movq	24(%rsi),%r12
	movq	32(%rsi),%rbp
	movq	40(%rsi),%rbx
	leaq	48(%rsi),%rsp
.Lmul4x_epilogue:
	movq	8(%rsp),%rdi
	movq	16(%rsp),%rsi
	.byte	0xf3,0xc3
.LSEH_end_bn_mul4x_mont_gather5:
.globl	bn_scatter5
.def	bn_scatter5;	.scl 2;	.type 32;	.endef
.p2align	4
bn_scatter5:
	cmpq	$0,%rdx
	jz	.Lscatter_epilogue
	leaq	(%r8,%r9,8),%r8
.Lscatter:
	movq	(%rcx),%rax
	leaq	8(%rcx),%rcx
	movq	%rax,(%r8)
	leaq	256(%r8),%r8
	subq	$1,%rdx
	jnz	.Lscatter
.Lscatter_epilogue:
	.byte	0xf3,0xc3


.globl	bn_gather5
.def	bn_gather5;	.scl 2;	.type 32;	.endef
.p2align	4
bn_gather5:
.LSEH_begin_bn_gather5:

.byte	0x48,0x83,0xec,0x28		
.byte	0x0f,0x29,0x34,0x24		
.byte	0x0f,0x29,0x7c,0x24,0x10	
	movq	%r9,%r11
	shrq	$3,%r9
	andq	$7,%r11
	notq	%r9
	leaq	.Lmagic_masks(%rip),%rax
	andq	$3,%r9
	leaq	96(%r8,%r11,8),%r8
	movq	0(%rax,%r9,8),%xmm4
	movq	8(%rax,%r9,8),%xmm5
	movq	16(%rax,%r9,8),%xmm6
	movq	24(%rax,%r9,8),%xmm7
	jmp	.Lgather
.p2align	4
.Lgather:
	movq	-96(%r8),%xmm0
	movq	-32(%r8),%xmm1
	pand	%xmm4,%xmm0
	movq	32(%r8),%xmm2
	pand	%xmm5,%xmm1
	movq	96(%r8),%xmm3
	pand	%xmm6,%xmm2
	por	%xmm1,%xmm0
	pand	%xmm7,%xmm3
	por	%xmm2,%xmm0
	leaq	256(%r8),%r8
	por	%xmm3,%xmm0

	movq	%xmm0,(%rcx)
	leaq	8(%rcx),%rcx
	subq	$1,%rdx
	jnz	.Lgather
	movaps	(%rsp),%xmm6
	movaps	16(%rsp),%xmm7
	leaq	40(%rsp),%rsp
	.byte	0xf3,0xc3
.LSEH_end_bn_gather5:

.p2align	6
.Lmagic_masks:
.long	0,0, 0,0, 0,0, -1,-1
.long	0,0, 0,0, 0,0,  0,0
.byte	77,111,110,116,103,111,109,101,114,121,32,77,117,108,116,105,112,108,105,99,97,116,105,111,110,32,119,105,116,104,32,115,99,97,116,116,101,114,47,103,97,116,104,101,114,32,102,111,114,32,120,56,54,95,54,52,44,32,67,82,89,80,84,79,71,65,77,83,32,98,121,32,60,97,112,112,114,111,64,111,112,101,110,115,115,108,46,111,114,103,62,0

.def	mul_handler;	.scl 3;	.type 32;	.endef
.p2align	4
mul_handler:
	pushq	%rsi
	pushq	%rdi
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	pushfq
	subq	$64,%rsp

	movq	120(%r8),%rax
	movq	248(%r8),%rbx

	movq	8(%r9),%rsi
	movq	56(%r9),%r11

	movl	0(%r11),%r10d
	leaq	(%rsi,%r10,1),%r10
	cmpq	%r10,%rbx
	jb	.Lcommon_seh_tail

	leaq	88(%rax),%rax

	movl	4(%r11),%r10d
	leaq	(%rsi,%r10,1),%r10
	cmpq	%r10,%rbx
	jb	.Lcommon_seh_tail

	movq	152(%r8),%rax

	movl	8(%r11),%r10d
	leaq	(%rsi,%r10,1),%r10
	cmpq	%r10,%rbx
	jae	.Lcommon_seh_tail

	movq	192(%r8),%r10
	movq	8(%rax,%r10,8),%rax

	movaps	(%rax),%xmm0
	movaps	16(%rax),%xmm1
	leaq	88(%rax),%rax

	movq	-8(%rax),%rbx
	movq	-16(%rax),%rbp
	movq	-24(%rax),%r12
	movq	-32(%rax),%r13
	movq	-40(%rax),%r14
	movq	-48(%rax),%r15
	movq	%rbx,144(%r8)
	movq	%rbp,160(%r8)
	movq	%r12,216(%r8)
	movq	%r13,224(%r8)
	movq	%r14,232(%r8)
	movq	%r15,240(%r8)
	movups	%xmm0,512(%r8)
	movups	%xmm1,528(%r8)

.Lcommon_seh_tail:
	movq	8(%rax),%rdi
	movq	16(%rax),%rsi
	movq	%rax,152(%r8)
	movq	%rsi,168(%r8)
	movq	%rdi,176(%r8)

	movq	40(%r9),%rdi
	movq	%r8,%rsi
	movl	$154,%ecx
.long	0xa548f3fc		

	movq	%r9,%rsi
	xorq	%rcx,%rcx
	movq	8(%rsi),%rdx
	movq	0(%rsi),%r8
	movq	16(%rsi),%r9
	movq	40(%rsi),%r10
	leaq	56(%rsi),%r11
	leaq	24(%rsi),%r12
	movq	%r10,32(%rsp)
	movq	%r11,40(%rsp)
	movq	%r12,48(%rsp)
	movq	%rcx,56(%rsp)
	call	*__imp_RtlVirtualUnwind(%rip)

	movl	$1,%eax
	addq	$64,%rsp
	popfq
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	popq	%rdi
	popq	%rsi
	.byte	0xf3,0xc3


.section	.pdata
.p2align	2
.rva	.LSEH_begin_bn_mul_mont_gather5
.rva	.LSEH_end_bn_mul_mont_gather5
.rva	.LSEH_info_bn_mul_mont_gather5

.rva	.LSEH_begin_bn_mul4x_mont_gather5
.rva	.LSEH_end_bn_mul4x_mont_gather5
.rva	.LSEH_info_bn_mul4x_mont_gather5

.rva	.LSEH_begin_bn_gather5
.rva	.LSEH_end_bn_gather5
.rva	.LSEH_info_bn_gather5

.section	.xdata
.p2align	3
.LSEH_info_bn_mul_mont_gather5:
.byte	9,0,0,0
.rva	mul_handler
.rva	.Lmul_alloca,.Lmul_body,.Lmul_epilogue		
.p2align	3
.LSEH_info_bn_mul4x_mont_gather5:
.byte	9,0,0,0
.rva	mul_handler
.rva	.Lmul4x_alloca,.Lmul4x_body,.Lmul4x_epilogue	
.p2align	3
.LSEH_info_bn_gather5:
.byte	0x01,0x0d,0x05,0x00
.byte	0x0d,0x78,0x01,0x00	
.byte	0x08,0x68,0x00,0x00	
.byte	0x04,0x42,0x00,0x00	
.p2align	3
