/*
* purpose   : compute square(n) = n * n
* output    : return (square(n) & 0xFF) as status code
*             (because exit codes range from 0-255)
*             check using echo $?
* variables : none
*/

.global _start

.data
num_n:
	.quad 9

.text
_start:
	movq num_n, %rdi
	call square              # call square(%rdi)

	movq %rax, %rdi
	movq $60, %rax
	syscall                  # syscall exit(%rdi)

/*
* purpose   : square(n) -> n * n
* input     : %rdi n
* output    : %rax n * n
* variables : %rdi n
            : -8(%rbp) actual n
            : %rax result
*/
.type square, @function
square:
	pushq %rbp               # save old base pointer
	movq %rsp, %rbp          # make stack pointer the base pointer

	movq %rdi, %rax
	imul %rax, %rax

	movq %rbp, %rsp          # restore stack pointer
	popq %rbp                # restore base pointer
	ret                      # return %rax
