/*
* purpose   : find maximum in a list
* output    : return (max & 0xFF) as status code
*             (because exit codes range from 0-255)
*             check using echo $?
* variables : %rcx index
*             %rax current
*             %rdi largest
*/

.global _start

.data
data_items:
	# use the .quad assembly directive to emit 8-byte integers
	.quad 3, 67, 34, 222, 45, 75, 54, 34, 44, 33, 22, 11, 66, 257, 0

.text
_start:
	mov $0, %rcx
	# in Intel: [rcx*8 + data_items]
	# because each quad value takes 8 bits
	mov data_items(, %rcx, 8), %rax
	mov %rax, %rdi

loop_start:
	cmp $0, %rax
	je loop_exit
	inc %rcx
	mov data_items(, %rcx, 8), %rax
	cmp %rdi, %rax
	jle loop_start

	mov %rax, %rdi
	jmp loop_start

loop_exit:
	# exit(%rdi)
	mov $60, %rax
	syscall
