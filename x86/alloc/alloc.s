/*
* manaage memory usage (allocate and deallocate memory)
*/

.section .data

# beginning of the memory we are managing
heap_begin:
	.quad 0
# one location past the memory we are managing
# break is the first location after the end of data segment
current_break:
	.quad 0

# size of space for memory region header
.equiv HEADER_SIZE, 16
# location of "available" flag in the header
.equiv HEADER_AVAILABLE_OFFSET, 0
# location of size field of the header
.equiv HEADER_SIZE_OFFSET, 8

# constants
.equiv UNAVAILABLE, 0
.equiv AVAILABLE, 1
.equiv SYS_BRK, 12




.section .text

/*
* allocate_init(): initialize the functions (sets heap_begin, current_break)
*/

.global allocate_init
.type allocate_init, @function
allocate_init:
	pushq %rbp                   # save old base pointer
	movq %rsp, %rbp              # make stack pointer the base pointer

	# this returns the last valid address into %rax
	movq $SYS_BRK, %rax
	movq $0, %rdi
	syscall                      # syscall brk(0)

	incq %rax                    # get the current break

	movq %rax, current_break     # store the current break
	movq %rax, heap_begin        # our first managed address is the current break

	movq %rbp, %rsp              # restore stack pointer
	popq %rbp                    # restore base pointer
	ret

/*
* signature    : allocate(size)
* description  : allocates size bytes and returns a pointer to the allocated memory
* parameters   : %rdi - size of memory to allocate
* return value : %rax - address of the allocated memory. if no memory available, returns 0
* working      : grab a section of memory, check if there are free blocks, if not, ask Linux for a new one
* variables    : %rdi - size of memory to allocate
                 %rax - current memory position being examined
                 %rbx - current break position
                 %rdx - size of current memory region
*/

.global allocate
.type allocate, @function
allocate:
	pushq %rbp                   # save old base pointer
	movq %rsp, %rbp              # make stack pointer the base pointer

	movq heap_begin, %rax
	movq current_break, %rbx

allocate_loop_start:
	cmpq %rbx, %rax              # need more memory if they are equal
	je allocate_move_break

	# get the current size of the memory
	movq HEADER_SIZE_OFFSET(%rax), %rdx
	
	# go to the next location if this region is unavailable
	cmpq $UNAVAILABLE, HEADER_AVAILABLE_OFFSET(%rax)
	je allocate_next_location

	# allocate here if this region is big enough
	cmpq %rdx, %rdi
	jle allocate_here

allocate_next_location:
	# next memory region = (current memory region + $HEADER_SIZE + size of memory region (%rdx))
	addq $HEADER_SIZE, %rax
	addq %rdx, %rax
	
	# do the same procedure for the next memory location
	jmp allocate_loop_start

allocate_here:
	# the start of memory region where we will allocate is in %rax
	movq $UNAVAILABLE, HEADER_AVAILABLE_OFFSET(%rax)
	# move %rax to the start of writable section
	addq $HEADER_SIZE, %rax

	movq %rbp, %rsp              # restore stack pointer
	popq %rbp                    # restore base pointer
	ret                          # return %rax

allocate_move_break:
	# set %rbx to where we want the memory to end
	addq $HEADER_SIZE, %rbx
	addq %rdi, %rbx

	# save the registers
	pushq %rax
	pushq %rbx
	pushq %rdi
	
	movq %rbx, %rdi
	movq $SYS_BRK, %rax
	syscall                      # syscall brk(current break + HEADER_SIZE + size we want to allocate)

	# check for errors
	cmpq $0, %rax
	je allocate_error

	# get our registers back
	popq %rdi
	popq %rbx
	popq %rax

	movq $UNAVAILABLE, HEADER_AVAILABLE_OFFSET(%rax)
	movq %rdi, HEADER_SIZE_OFFSET(%rax)

	addq $HEADER_SIZE, %rax

	movq %rbx, current_break     # save the current break

	movq %rbp, %rsp              # restore stack pointer
	popq %rbp                    # restore base pointer
	ret                          # return %rax

allocate_error:
	movq $0, %rax                # return zero on error

	movq %rbp, %rsp              # restore stack pointer
	popq %rbp                    # restore base pointer
	ret                          # return %rax

/*
* signature    : deallocate(size)
* description  : give back a region of memory to pool after we are done
* parameters   : %rdi - memory we want to deallocate
* return value : %rax - nothing
* variables    : %rdi - memory we want to deallocate
*/

.global deallocate
.type deallocate, @function
deallocate:
	# get the location of the actual beginning of the memory region
	subq $HEADER_SIZE, %rdi
	# mark it as available
	movq $AVAILABLE, HEADER_AVAILABLE_OFFSET(%rdi)

	ret                          # return %rax
