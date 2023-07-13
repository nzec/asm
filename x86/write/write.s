/*
* purpose   : writes "Hello world!" to given file
* usage     : command line argument (./upper <output file>)
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

hello:
	.asciz "Hello world!\n"
hello_len = . - hello

.section .text
.global _start

_start:
	movq %rsp, %rbp                  # make stack pointer the base pointer

	movq $SYS_OPEN, %rax
	movq 16(%rbp), %rdi
	movq $O_CREAT_WRONLY_TRUNC, %rsi
	movq $0666, %rdx
	syscall                          # syscall open(argv[1], O_CREAT_WRONLY_TRUNC, 0666)

	pushq %rax                       # push fd to stack

	movq %rax, %rdi
	movq $SYS_WRITE, %rax
	movq $hello, %rsi
	movq $hello_len, %rdx
	syscall                          # syscall write(fd, hello, hello_len)

	popq %rdi                        # retrieve fd from stack

	movq $SYS_CLOSE, %rax
	syscall                          # syscall close(fd)

	movq $SYS_EXIT, %rax
	movq $0, %rdi
	syscall                          # syscall exit(0)
