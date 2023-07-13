.global _start

.section .data
float_num:
	.float 10.3

.section .text
_start:
	movss float_num, %xmm0

	movq $60, %rax
	movq $0, %rdi
	syscall
