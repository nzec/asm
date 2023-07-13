/*
* purpose   : exit peacefully with exit status 2
* input     : none
* output    : status code (echo $?)
* variables : %rax system call number
*             %rdi return code status
*/

.global _start

.data

.text
_start:
	mov $60, %rax # exit system call
	mov $2, %rdi  # exist status
	syscall       # syscall instruction to run the syscall
