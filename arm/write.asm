.global _start
.section .text

_start:
    // syscall write(int fd, const void *buf, size_t count)
    // syscall write(0, msg, sizeof(msg))
    mov r7, #0x4
    mov r0, #0x0
    ldr r1, =msg
    ldr r2, =len
    swi 0

    // syscall exit(int status)
    // syscall exit(0)
    mov r7, #0x1
    mov r0, #0
    swi 0

.section .data
msg:
    .ascii "Hello, World\n"
len = . - msg
