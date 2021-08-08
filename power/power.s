/*
* purpose   : compute ans = a^b + b^a
* output    : return (ans & 0xFF) as status code
*             (because exit codes range from 0-255)
*             check using echo $?
* variables : none
*/

.global _start

.data
num_a:
	.quad 2
num_b:
	.quad 3

.text
_start:
	movq num_a, %rdi
	movq num_b, %rsi
	call power               # call power(%rdi, %rsi)
	pushq %rax               # save first answer

	movq num_b, %rdi
	movq num_a, %rsi
	call power               # call power(%rdi, %rsi)

	popq %rdi                # get the first answer saved earlier
	addq %rax, %rdi          # add the second answer into first

	movq $60, %rax
	syscall                  # syscall exit(%rdi)

/*
* purpose   : power(a, b) -> a^b
* input     : %rdi a
*           : %rsi b
* output    : %rax a^b
* variables : %rdi a
            : %rsi power counter
            : %rax result
*/
.type power, @function
power:
	pushq %rbp               # save old base pointer
	movq %rsp, %rbp          # make stack pointer the base pointer

	movq $1, %rax            # initialize result to $1

power_loop_start:
	cmpq $0, %rsi            # if power counter is $0, exit
	je power_loop_exit

	imulq %rdi, %rax         # result *= a
	decq %rsi                # decrement power
	jmp power_loop_start     # run again

power_loop_exit:
	movq %rbp, %rsp          # restore stack pointer (redundant here)
	popq %rbp                # restore base pointer
	ret                      # return %rax
