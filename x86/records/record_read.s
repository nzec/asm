.include "record_def.s"
.include "linux.s"

/*
* purpose   : record_read(fd, buffer)
              read record from the file descriptor into buffer
* input     : %rdi fd
*             %rsi buffer
* output    : status code given by syscall read
* variables : %rdi - fd
            : %rsi - buffer
*/

.section .text
.global record_read
.type record_read, @function

record_read:
	pushq %rbp                   # save old base pointer
	movq %rsp, %rbp              # make stack pointer the base pointer

	# %rdi = fd
	# %rsi = buffer
	movq $RECORD_SIZE, %rdx
	movq $SYS_READ, %rax
	syscall                      # syscall read(fd, buffer, RECORD_SIZE)

	# %rax has the return value

	movq %rbp, %rsp              # restore stack pointer
	popq %rbp                    # restore base pointer
	ret                          # return %rax
