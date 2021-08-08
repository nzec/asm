/*
* purpose   : find the length of string
* output    : return (length & 0xFF) as status code
*             (because exit codes range from 0-255)
*             check using echo $?
* variables : %rdi index
*             %al current character
*/

.global _start

.data
test_str:
	.ascii "hello world ....\0"

.text
_start:
	mov $0, %rdi

loop_start:
	# in Intel: [rdi*1 + test_str]
	movb test_str(, %rdi, 1), %al
	cmp $0, %al
	je loop_exit
	inc %rdi
	jmp loop_start

loop_exit:
	# exit(%rdi)
	mov $60, %rax
	syscall
