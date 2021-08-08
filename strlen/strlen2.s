/*
* purpose   : find the length of string
* output    : return (length & 0xFF) as status code
*             (because exit codes range from 0-255)
*             check using echo $?
* variables : %rdi current character's memory address
*/

.global _start

.data
test_str:
	.ascii "hello world ....\0"

.text
_start:
	mov $test_str, %rdi

loop_start:
	cmpb $0, (%rdi)
	je loop_exit
	inc %rdi
	jmp loop_start

loop_exit:
	sub $test_str, %rdi
	# exit(%rdi)
	mov $60, %rax
	syscall
