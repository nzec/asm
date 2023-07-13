.include "linux.s"

/*
* purpose   : error_exit(error_code_string, message_string)
              count the number of characters until a null byte is reached
* input     : %rdi error code string
              %rsi message string
* output    : nothing
* variables : %rdi - error code string
            : %rsi - message string
*/

.section .text
.global error_exit
.type error_exit, @function

.equiv ST_ERROR_CODE, -8
.equiv ST_ERROR_MSG, -16

error_exit:
	pushq %rbp                   # save old base pointer
	movq %rsp, %rbp              # make stack pointer the base pointer

	subq $16, %rsp

	movq %rdi, ST_ERROR_CODE(%rbp)
	movq %rsi, ST_ERROR_MSG(%rbp)

error_code_write:
	call count_chars             # call cnt = count_chars(ST_ERROR_CODE)

	movq %rax, %rdx
	movq $STDERR, %rdi
	movq ST_ERROR_CODE(%rbp), %rsi
	movq $SYS_WRITE, %rax
	syscall                      # syscall write(STDERR, ST_ERROR_CODE, cnt)

error_msg_write:
	movq ST_ERROR_MSG(%rbp), %rdi
	call count_chars             # call cnt = count_chars(ST_ERROR_MSG)

	movq %rax, %rdx
	movq $STDERR, %rdi
	movq ST_ERROR_MSG(%rbp), %rsi
	movq $SYS_WRITE, %rax
	syscall                      # syscall write(STDERR, ST_ERROR_MSG, cnt)

	movq $STDERR, %rdi
	call write_newline           # call write_newline(STDERR)

	# exit with status code 1
	movq $SYS_EXIT, %rax
	movq $1, %rdi
	syscall                      # syscall exit(1)
