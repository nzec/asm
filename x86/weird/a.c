void main() {
    __asm__ (
            // write(1, "Hello World\n", 13)
            "movq $1, %rax;"
            "movq $1, %rdi;"
            "lea message(%rip), %rsi;"
            "movq $13, %rdx;"
            "syscall;"

            // exit(0)
            "movq $60,%rax;"
            "xor %rdi,%rdi;"
            "syscall;"
            "message: .ascii \"Hello World!\\n\";"
            );
}
