/*
* purpose   : count_chars(string)
              count the number of characters until a null byte is reached
* input     : %rdi address of beginning of string
* output    : nothing
* variables : %rdi - address of beginning of string
            : %rcx - character count
	    : %al  - current character (first part of %ax)
*/

.section .text
.global count_chars
.type count_chars, @function

count_chars:
	pushq %rbp                   # save old base pointer
	movq %rsp, %rbp              # make stack pointer the base pointer

	movq $0, %rcx                # initialize counter = 0

count_chars_loop_start:
	# [%rdi + %rcx * 1]
	movb (%rdi, %rcx, 1), %al    # get current character

	# exit if current character is null
	cmpb $0, %al
	je count_chars_loop_end

	incq %rcx                    # increment counter
	jmp count_chars_loop_start

count_chars_loop_end:
	movq %rcx, %rax              # return counter

	movq %rbp, %rsp              # restore stack pointer (redundant here)
	popq %rbp                    # restore base pointer

	ret                          # return %rax
