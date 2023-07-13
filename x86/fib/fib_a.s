/*
* purpose   : fib(n) = fib(n - 1) + fib(n - 2); n > 1
              fib(n) = n; n <= 1
* input     : command line argument (./fib_a n)
* output    : command line output
* variables : -8(%rbp) n
*             (%rbp)   argc
*             8(%rbp)  argv[0]
*             16(%rbp) argv[1]
*             ...
*/

.global _start

.data
printer:
	.asciz "fib(%d) = %d\n"
usage:
	.asciz "usage: %s n\n"

.text
_start:
	movq %rsp, %rbp          # make stack pointer the base pointer

	cmpq $1, (%rbp)          # compare $1 and argc
	je give_usage            # if argc == 1, print usage

	movq 16(%rbp), %rdi      # %rdi = argv[1]
	call atoll               # n = atoll(argv[1])
	pushq %rax               # push n to stack

	movq -8(%rbp), %rdi      # %rdi = n
	call fib                 # call fib(n)

	movq $printer, %rdi
	movq -8(%rbp), %rsi      # %rsi = n
	movq %rax, %rdx          # %rdx = fib(n)
	xorq %rax, %rax           # clear %rax (printf is variadic)
	call printf              # call printf(printer, n, fin(n))

prog_exit:
	movq $0, %rdi            # %rdi = 0
	call exit                # call exit(0)

give_usage:
	movq $usage, %rdi
	movq 8(%rbp), %rsi       # %rsi = argv[0]
	xorq %rax, %rax          # clear %rax (printf is variadic)
	call printf              # call printf(usage, argv[0])

	jmp prog_exit
