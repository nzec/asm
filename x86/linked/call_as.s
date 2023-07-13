.section .data
SCANF_FMT:
	.asciz "%lld"

.section .text

.global _start
.equ ST_NODE_VALUE, -8
.equ ST_NODE_START, -16
# %rsp is guaranteed to be 16-byte aligned at process entry
# however %rsp is 8-bytes away from 16-byte alignment at the start of main
_start:
	pushq %rbp
	movq %rsp, %rbp

	# get a null pointer and save it on stack
	# align stack to 16-byte before calling scanf
	subq $24, %rsp
	call list_new
	movq %rax, ST_NODE_START(%rbp)

insert_loop_start:
	# call scanf("%lld", ST_NODE_VALUE)
	movq $SCANF_FMT, %rdi
	leaq ST_NODE_VALUE(%rbp), %rsi
	xorq %rax, %rax
	call scanf

	cmpq $1, %rax
	jne insert_loop_end

	# call insert(ST_NODE_VALUE, ST_NODE_START)
	movq ST_NODE_VALUE(%rbp), %rdi
	movq ST_NODE_START(%rbp), %rsi
	call list_insert
	# returns pointer to new node

	# make the new returned node the node start
	movq %rax, ST_NODE_START(%rbp)

	# print the new node
	movq %rax, %rdi
	call list_print

	jmp insert_loop_start

insert_loop_end:
	leaveq

	# syscall exit(0)
	movq $60, %rax
	movq $0, %rdi
	syscall
