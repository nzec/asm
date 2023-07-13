.include "record_def.s"
.include "linux.s"

.section .data
input_file_name:
	.ascii "test.dat\0"
output_file_name:
	.ascii "testout.dat\0"
no_file_open_code:
	.ascii "0001: \0"
no_file_open_msg:
	.ascii "can't open input file\0"




.section .bss
.lcomm record_buffer, RECORD_SIZE




.section .text
.equiv ST_FD_IN, -8
.equiv ST_FD_OUT, -16

.global _start
_start:
	movq %rsp, %rbp               # make stack pointer the base pointer
	subq $16, %rsp                # allocate space for fd

	movq $SYS_OPEN, %rax
	movq $input_file_name, %rdi
	movq $O_RDONLY, %rsi
	movq $0666, %rdx
	syscall                      # syscall open(input_file_name, O_RDONLY, 0666)

	movq %rax, ST_FD_IN(%rbp)

	cmpq $0, %rax
	jl give_error

	movq $SYS_OPEN, %rax
	movq $output_file_name, %rdi
	movq $(O_WRONLY | O_CREAT), %rsi
	movq $0666, %rdx
	syscall                      # syscall open(output_file_name, O_WRONLY | O_CREAT, 0666)

	movq %rax, ST_FD_OUT(%rbp)

add_year_loop_start:
	movq ST_FD_IN(%rbp), %rdi
	movq $record_buffer, %rsi
	call record_read              # call record_read(ST_FD_IN, record_buffer)

	# end if number of bytes read != number of bytes requested
	# means either error or end-of-file
	cmpq $RECORD_SIZE, %rax
	jne add_year_loop_end

	# increment the age
	incl record_buffer + RECORD_AGE

	movq ST_FD_OUT(%rbp), %rdi
	movq $record_buffer, %rsi
	call record_write            # call record_write(ST_FD_OUT, record_buffer)

	jmp add_year_loop_start

add_year_loop_end:
	movq $SYS_EXIT, %rax
	movq $0, %rdi
	syscall                      # syscall exit(0)

give_error:
	movq $no_file_open_code, %rdi
	movq $no_file_open_msg, %rsi
	call error_exit              # call error_exit(no_file_open_code, no_file_open_msg)
