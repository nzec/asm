/*
* signature    : itoa(value, buffer, base)
* description  : convert a given number to a null-terminated string in the
                 given base and store the result in the given buffer
		 the number is treated as unsigned
		 buffer should be long enough to contain any possible value
* parameters   : %rdi - value
                 %rsi - buffer
		 %rdx - base
* return value : %rax - pointer to buffer
* variables    : %rax - value, quotient
                 %rsi - buffer
                 %rdi - base
		 %rdx - remainder
		 %rcx - current character count
*/

.global itoa
.type itoa, @function
itoa:
	# save old base pointer
	pushq %rbp
	# make stack pointer the base pointer
	movq %rsp, %rbp

	# move value to %rax
	movq %rdi, %rax
	# movq base to %rdi
	movq %rdx, %rdi

	# set current character count = 0
	xorq %rcx, %rcx
	
	# save the starting location of the buffer
	pushq %rsi

convert_loop:
	# division is done on %rdx:%rax
	# so zero out %rdx
	xorq %rdx, %rdx

	# divide %rdx:%rax (value) by base
	# quotient in %rax, remainder in %rdx
	divq %rdi

	# make remainder ascii numeral
	addq $'0', %rdx

	# push %rdx onto the stack
	pushq %rdx

	# increment digit count
	incq %rcx

	# do the same steps with the quotient if it is not zero
	cmpq $0, %rax
	jne convert_loop

copy_loop:
	# pop the byte into %rdx
	popq %rdx
	# move the lowest-byte of %rdx into current buffer position
	movb %dl, (%rsi)

	# decrement the digit count
	decq %rcx
	# move the buffer pointer to the next position
	incq %rsi

	# do the same steps if we are not finished
	cmpq $0, %rcx
	jne copy_loop

	# write the final null-byte to the last position in the buffer
	movb $0, (%rsi)

	# pop the starting of the buffer into %rax (for returning)
	popq %rax

	# restore stack pointer
	movq %rbp, %rsp
	# restore base pointer
	popq %rbp
	# return %rax
	ret

