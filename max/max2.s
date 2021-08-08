/*
* purpose   : find maximum in a list
*             stopping at an ending address $data_end
* output    : return (max & 0xFF) as status code
*             (because exit codes range from 0-255)
*             check using echo $?
* variables : %rax current number's address
*             %rdi largest
*/

.global _start

.data
data_items:
	# use the .quad assembly directive to emit 8-byte integers
	.quad 3, 67, 34, 222, 45, 75, 54, 34, 44, 33, 22, 11, 66
data_end:

.text
_start:
	mov $data_items, %rax
	mov (%rax), %rdi

loop_start:
	cmpq $data_end, %rax
	je loop_exit
	addq $8, %rax
	cmp %rdi, (%rax)
	jle loop_start

	mov (%rax), %rdi
	jmp loop_start

loop_exit:
	# exit(%rdi)
	mov $60, %rax
	syscall
