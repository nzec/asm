/*
* purpose   : fib(n) = fib(n - 1) + fib(n - 2); n > 1
              fib(n) = n; n <= 1
* input     : %rdi n
* output    : %rax fib(n)
* variables : %rdi n
            : -8(%rbp) actual n
            : -16(%rbp) fib(n - 1)
            : %rax result
*/
.text
.global fib
.type fib, @function
fib:
	pushq %rbp               # save old base pointer
	movq %rsp, %rbp          # make stack pointer the base pointer

	movq %rdi, %rax          # %rax = n
	cmpq $1, %rdi
	jle fib_end              # base case, fib(n) = n if n <= 1

	pushq %rdi               # push n onto the stack

	decq %rdi                # %rdi = n - 1
	call fib                 # call fib(n - 1)

	pushq %rax               # push fib(n - 1) onto the stack

	movq -8(%rbp), %rdi      # load n into %rdi
	subq $2, %rdi            # %rdi = n - 2
	call fib                 # call fib(n - 2)

	addq -16(%rbp), %rax     # %rax = fib(n - 1) + fib(n - 2)
fib_end:
	movq %rbp, %rsp          # restore stack pointer
	popq %rbp                # restore base pointer
	ret                      # return %rax
