.include "record_def.s"
.include "linux.s"

.section .data
file_name:
	.ascii "test.dat\0"




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
	movq $file_name, %rdi
	movq $O_RDONLY, %rsi
	movq $0666, %rdx
	syscall                       # syscall open(file_name, O_RDONLY, 0666)

	movq %rax, ST_FD_IN(%rbp)     # store the file descriptor on the stack
	movq $STDOUT, ST_FD_OUT(%rbp) # store stdout as output fd

records_read_loop_start:
	movq ST_FD_IN(%rbp), %rdi
	movq $record_buffer, %rsi
	call record_read              # call record_read(ST_FD_IN, record_buffer)

	# end if number of bytes read != number of bytes requested
	# means either error or end-of-file
	cmpq $RECORD_SIZE, %rax
	jne records_read_loop_end

	movq $(record_buffer + RECORD_FIRSTNAME), %rdi
	call count_chars              # call cnt = count_chars(record_buffer + RECORD_FIRSTNAME)
	
	# %rax has output of count_chars

	movq %rax, %rdx
	movq ST_FD_OUT(%rbp), %rdi
	movq $(record_buffer + RECORD_FIRSTNAME), %rsi
	movq $SYS_WRITE, %rax
	syscall                       # syscall write(ST_FD_OUT, record_buffer + RECORD_FIRSTNAME, cnt)

	movq ST_FD_OUT(%rbp), %rdi
	call write_newline            # call write_newline(ST_FD_OUT)

	jmp records_read_loop_start

records_read_loop_end:
	movq $SYS_EXIT, %rax
	movq $0, %rdi
	syscall                       # syscall exit(0)
