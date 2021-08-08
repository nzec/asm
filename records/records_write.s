.include "record_def.s"
.include "linux.s"

.section .data

record1:
	# FIRSTNAME
	.ascii "Frederick\0"
	.rept 31
	.byte 0
	.endr

	# LASTNAME
	.ascii "Barlett\0"
	.rept 31
	.byte 0
	.endr

	# ADDRESS
	.ascii "4242 S Prairie\nTulsa, OK 55555\0"
	.rept 209
	.byte 0
	.endr

	# AGE
	.long 45

record2:
	.ascii "Marilyn\0"
	.rept 32
	.byte 0
	.endr

	.ascii "Taylor\0"
	.rept 33
	.byte 0
	.endr

	.ascii "2224 S Johannan St\nChicago, IL 12345\0"
	.rept 203
	.byte 0
	.endr

	.long 29

record3:
	.ascii "Derrick\0"
	.rept 32
	.byte 0
	.endr

	.ascii "McIntire\0"
	.rept 31
	.byte 0
	.endr

	.ascii "500 W Oakland\nSan Diego, CA 54321\0"
	.rept 206
	.byte 0
	.endr

	.long 36

file_name:
	.ascii "test.dat\0"




.section .text
.equiv ST_FD, -8

.global _start
_start:
	movq %rsp, %rbp              # make stack pointer the base pointer
	subq $8, %rsp                # allocate space for fd
	
	movq $SYS_OPEN, %rax
	movq $file_name, %rdi
	movq $(O_WRONLY | O_APPEND | O_CREAT), %rsi
	movq $0666, %rdx
	syscall                      # syscall open(file_name, O_CREAT_WRONLY, 0666)

	movq %rax, ST_FD(%rbp)       # store the file descriptor on the stack

	movq ST_FD(%rbp), %rdi
	movq $record1, %rsi
	call record_write            # call record_write(ST_FD, record1)

	movq ST_FD(%rbp), %rdi
	movq $record2, %rsi
	call record_write            # call record_write(ST_FD, record2)

	movq ST_FD(%rbp), %rdi
	movq $record3, %rsi
	call record_write            # call record_write(ST_FD, record3)

	movq $SYS_CLOSE, %rax
	movq ST_FD(%rbp), %rdi
	syscall                      # syscall close(ST_FD)

	movq $SYS_EXIT, %rax
	movq $0, %rdi
	syscall                      # syscall exit(0)
