/*
* purpose   : compute factorial(n) = 1 * 2 * .. * n
* output    : return (factorial(n) & 0xFF) as status code
*             (because exit codes range from 0-255)
*             check using echo $?
* variables : none
*/

.global _start

.data
num_n:
	.quad 5

.text
_start:
	movq num_n, %rdi
	call factorial           # call factorial(%rdi)

	movq %rax, %rdi
	movq $60, %rax
	syscall                  # syscall exit(%rdi)

/*
* purpose   : factorial(n) -> 1 * 2 * .. * n
* input     : %rdi n
* output    : %rax 1 * 2 * .. * n
* variables : %rdi n
            : -8(%rbp) actual n
            : %rax result
*/
.type factorial, @function
factorial:
	pushq %rbp               # save old base pointer
	movq %rsp, %rbp          # make stack pointer the base pointer

	cmpq $1, %rdi            # base case: n == 1
	je factorial_end

	pushq %rdi               # push n onto the stack

	decq %rdi                # n -= 1
	call factorial           # call factorial(%rdi)

	movq -8(%rbp), %rdi       # put actual n back to %rdi

	imulq %rax, %rdi         # %rax *= %rdi

factorial_end:
	movq %rdi, %rax          # prepare to return %rax
	movq %rbp, %rsp          # restore stack pointer
	popq %rbp                # restore base pointer
	ret                      # return %rax
