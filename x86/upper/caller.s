/*
* purpose   : converts input file to output file with all letters converted
              from lower to upper case
* usage     : command line argument (./upper <input file> <output file>)
*/




.section .data

# constants

# syscall numbers (/usr/include/asm/unistd_64.h)
.equiv SYS_OPEN, 2
.equiv SYS_WRITE, 1
.equiv SYS_READ, 0
.equiv SYS_CLOSE, 3
.equiv SYS_EXIT, 60

# options for open
# (/usr/include/asm-generic/fcntl.h)
# (/usr/include/bits/fcntl-linux.h)
.equiv O_RDONLY, 0
# in octal (leading zero)
.equiv O_WRONLY, 01
.equiv O_CREAT, 0100
.equiv O_TRUNC, 01000
.equiv O_APPEND, 02000
.equiv O_CREAT_WRONLY_TRUNC, O_CREAT | O_WRONLY | O_TRUNC

# standard file descriptors (/usr/include/unistd.h)
.equiv STDIN, 0
.equiv STDOUT, 1
.equiv STDERR, 2

# return value of read when end of file is reached (man 2 read)
.equiv END_OF_FILE, 0

# usage text
usage:
	.ascii "usage: ./a.out <inupt file> <output file>\n"
usage_len = . - usage




.section .bss

# buffer
.equiv BUFFER_SIZE, 500
.lcomm BUFFER_DATA, BUFFER_SIZE




.section .text

# stack positions
.equiv ST_SIZE_REVERSED, 16
.equiv ST_FD_OUT, -16
.equiv ST_FD_IN, -8
.equiv ST_ARGC, 0                      # number of arguments
.equiv ST_ARGV_0, 8                    # executable name
.equiv ST_ARGV_1, 16                   # input file
.equiv ST_ARGV_2, 24                   # output file



.global _start

_start:
	movq %rsp, %rbp              # make stack pointer the base pointer

	cmpq $2, ST_ARGC(%rbp)
	jle give_usage               # if argc <= 2, print usage

	# allocate space for file descriptors on the stack
	subq $ST_SIZE_REVERSED, %rsp

open_files:
open_fd_in:
	# open input file
	movq $SYS_OPEN, %rax
	movq ST_ARGV_1(%rbp), %rdi
	movq $O_RDONLY, %rsi
	movq $0666, %rdx
	syscall                      # syscall open(argv[1], O_RDONLY, 0666)

store_fd_in:
	movq %rax, ST_FD_IN(%rbp)    # save the fd on stack

open_fd_out:
	# open output file
	movq $SYS_OPEN, %rax
	movq ST_ARGV_2(%rbp), %rdi
	movq $O_CREAT_WRONLY_TRUNC, %rsi
	movq $0666, %rdx
	syscall                      # syscall open(argv[2], O_CREAT_WRONLY_TRUNC, 0666)
	
store_fd_out:
	movq %rax, ST_FD_OUT(%rbp)   # save the fd on stack

read_loop_start:
	# read in a block from input file
	movq $SYS_READ, %rax
	movq ST_FD_IN(%rbp), %rdi
	movq $BUFFER_DATA, %rsi
	movq $BUFFER_SIZE, %rdx
	syscall                      # syscall sz = read(ST_FD_IN, BUFFER_DATA, BUFFER_SIZE)

	# exit if end of file or error
	cmpq $END_OF_FILE, %rax
	# read returns 0 on EOF, -1 on error
	jle read_loop_end

read_loop_continue:
	pushq %rax                   # save the size of buffer on the stack

	# convert block to uppercase
	movq $BUFFER_DATA, %rdi      # location of buffer
	movq %rax, %rsi              # size of buffer
	call upper                   # call upper(BUFFER_DATA, sz)

	popq %rax                    # get the size of buffer back

	# write block to output file
	movq %rax, %rdx              # size of buffer
	movq $SYS_WRITE, %rax
	movq ST_FD_OUT(%rbp), %rdi
	movq $BUFFER_DATA, %rsi
	syscall                      # syscall write(ST_FD_OUT, BUFFER_DATA, sz)

	jmp read_loop_start          # continue the loop

read_loop_end:
	movq $SYS_CLOSE, %rax
	movq ST_FD_OUT(%rbp), %rdi
	syscall                      # syscall close(ST_FD_OUT)

	movq $SYS_CLOSE, %rax
	movq ST_FD_IN(%rbp), %rdi
	syscall                      # syscall close(ST_FD_IN)

prog_exit:
	movq $SYS_EXIT, %rax
	movq $0, %rdi
	syscall                      # syscall exit(0)

give_usage:
	movq $SYS_WRITE, %rax
	movq $STDOUT, %rdi
	movq $usage, %rsi
	movq $usage_len, %rdx
	syscall                      # syscall write(STDOUT, usage, usage_len)

	jmp prog_exit
