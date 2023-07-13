.include "record_def.s"
.include "linux.s"

/*
* purpose   : record_write(fd, buffer)
              write record from the buffer into file descriptor
* input     : %rdi fd
*             %rsi buffer
* output    : status code given by syscall read
* variables : %rdi - fd
            : %rsi - buffer
*/

.section .text
.global record_write
.type record_write, @function

record_write:
	pushq %rbp                   # save old base pointer
	movq %rsp, %rbp              # make stack pointer the base pointer

	# %rdi = fd
	# %rsi = buffer
	movq $RECORD_SIZE, %rdx
	movq $SYS_WRITE, %rax
	syscall                      # syscall write(fd, buffer, RECORD_SIZE)

	# %rax has the return value

	movq %rbp, %rsp              # restore stack pointer
	popq %rbp                    # restore base pointer
	ret                          # return %rax
