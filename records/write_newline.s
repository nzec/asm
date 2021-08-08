.include "linux.s"

/*
* purpose   : write_newline(fd)
              write a newline to the given file descriptor
* input     : %rdi fd
* output    : status code given by syscall read
* variables : %rdi - fd
*/

.section .data
newline:
	.ascii "\n"

.section .text
.global write_newline
.type write_newline, @function

write_newline:
	pushq %rbp                   # save old base pointer
	movq %rsp, %rbp              # make stack pointer the base pointer

	# %rdi = fd
	movq $newline, %rsi
	movq $1, %rdx
	movq $SYS_WRITE, %rax
	syscall                      # syscall write(fd, "\n", 1)

	# %rax has the return value

	movq %rbp, %rsp              # restore stack pointer
	popq %rbp                    # restore base pointer
	ret                          # return %rax
