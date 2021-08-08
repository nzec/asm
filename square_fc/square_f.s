.text
.global square
.type square, @function
square:
	pushq %rbp
	movq %rsp, %rbp

	movq %rdi, %rax
	imul %rax, %rax

	movq %rbp, %rsp
	popq %rbp
	ret
