.data
num_n:
	.quad 11
.text
.global _start
_start:
	movq num_n, %rdi
	call square

	movq %rax, %rdi
	movq $60, %rax
	syscall
