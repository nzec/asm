# start position of each field
.equ NODE_VALUE, 0
.equ NODE_NEXT, 8
.equ NODE_SIZE, 16

.section .text

/*
* signature    : list_new()
* description  : returns a null pointer
* parameters   : -
* return value : %rax - null pointer
* variables    : -
*/
.global list_new
.type list_new, @function
list_new:
	xorq %rax, %rax              # return a null pointer
	ret

/*
* signature    : list_insert(value, node)
* description  : returns a new node with the given value and next pointing to
                 the given node
* parameters   : %rdi - value
                 %rsi - pointer to node
* return value : %rax - pointer to new node
* variables    : %rdi - value
                 %rsi - pointer to node
		 ST_NODE_VALUE(%rbp) - value
		 ST_NODE_NEXT(%rbp) - pointer to node
*/
.global list_insert
.type list_insert, @function
.equ ST_NODE_VALUE, -8
.equ ST_NODE_NEXT, -16
list_insert:
	pushq %rbp
	movq %rsp, %rbp

	# save the value and the node on the stack
	subq $NODE_SIZE, %rsp
	movq %rdi, ST_NODE_VALUE(%rbp)
	movq %rsi, ST_NODE_NEXT(%rbp)

	# %rax will contain the new node
	movq $NODE_SIZE, %rdi
	call malloc

	# save the value and the pointer to the old node on the new node
	movq ST_NODE_VALUE(%rbp), %r8
	movq %r8, NODE_VALUE(%rax)
	movq ST_NODE_NEXT(%rbp), %r8
	movq %r8, NODE_NEXT(%rax)

	leaveq
	ret

.section .data
PRINTF_FMT:
	.asciz "%lld "
PRINTF_NEWLINE:
	.asciz "\n"

.section .text

/*
* signature    : list_print(node)
* description  : walks the linked list and prints each element
* parameters   : %rdi - node
* return value : -
* variables    : %rdi - node
		 %rbx - current node we are iterating on
*/
.global list_print
.type list_print, @function
.equ ST_RBX, -8
list_print:
	pushq %rbp
	movq %rsp, %rbp

	# save old value of %rbx
	subq $16, %rsp
	movq %rbx, ST_RBX(%rbp)

	# move starting node to %rbx
	movq %rdi, %rbx

list_print_loop_start:
	# check if %rbx is a null pointer, in which case, end loop
	cmp $0, %rbx
	je list_print_loop_end

	# call printf("%lld ", %rbx)
	movq $PRINTF_FMT, %rdi
	movq NODE_VALUE(%rbx), %rsi
	xor %rax, %rax
	call printf

	# repeat the loop with the next node
	movq NODE_NEXT(%rbx), %rbx
	jmp list_print_loop_start

list_print_loop_end:
	# call printf("\n")
	movq $PRINTF_NEWLINE, %rdi
	xorq %rax, %rax
	call printf

	# restore %rbx
	movq ST_RBX(%rbp), %rbx

	leaveq
	ret
