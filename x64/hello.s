/*
* assemble : as hello.s -o hello.o
* link     : ld hello.o -o hello
* run      : ./hello
*/

# make _start symbol visible to the linker ld
.global _start

# data section
.data
# hello label (symbol)
# label refers to current address (value of the active location counter)
hello:
	# use the .ascii assembler directive to put the
	# following string constant in the object file generated
	.ascii "hello world\n"

# assign the symbol hellolen a particular value
# . refers to the current address
# (current address) - (address of start of the hello string) = len of string
hellolen = . - hello

# text section
.text
# start label (symbol)
# label refers to current address (value of the active location counter)
_start:
	                    # write(1, "hello world\n", 12)
	mov $1, %rax        # 1 is the code of write system call in x86-64 assembly
	mov $1, %rdi        # use the file descriptor 1 (stdin)
	mov $hello, %rsi    # the starting address of the buffer
	mov $hellolen, %rdx # number of bytes to write
	syscall             # syscall instruction which tells the OS to perform the syscall

	                    # exit(0)
	mov $60, %rax       # 1 in the code of exit system call in x86-64 assembly
	mov $0, %rdi        # value to return
	syscall             # perform the syscall
