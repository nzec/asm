/*
* purpose   : upper(buffer, buf_size)
              overwrite buffer with upper-case
* input     : %rdi buffer
*             %rsi buf_size
* output    : nothing
* variables : %rdi - beginning of buffer
            : %rsi - length of buffer
            : %rdx - current buffer offset
	    : %cl  - current byte being examined (first part of %cx)
*/
.section .text
.global upper
.type upper, @function

# constants
.equiv LOWERCASE_A, 'a'
.equiv LOWERCASE_Z, 'z'
.equiv UPPPER_CONV, 'A' - 'a'

upper:
	pushq %rbp                   # save old base pointer
	movq %rsp, %rbp              # make stack pointer the base pointer

	movq $0, %rdx                # initialize current buffer offset = 0

	# exit if buffer is zero length
	cmpq $0, %rsi
	je upper_loop_end

upper_loop_start:
	# get the current character [%rdi + %rdx * 1]
	movb (%rdi, %rdx, 1), %cl

	# go to the next byte unless it is between 'a' and 'z'
	cmpb $LOWERCASE_A, %cl
	jl upper_next_byte
	cmpb $LOWERCASE_Z, %cl
	jg upper_next_byte

	# convert byte to uppercase
	addb $UPPPER_CONV, %cl
	movb %cl, (%rdi, %rdx, 1)

upper_next_byte:
	incq %rdx

	# continue unless reached the end
	cmpq %rdx, %rsi
	jne upper_loop_start

upper_loop_end:
	movq %rbp, %rsp              # restore stack pointer (redundant here)
	popq %rbp                    # restore base pointer
	ret                          # return %rax
