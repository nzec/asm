.global _start
.section .text

_start:
    // exit syscall
    mov r7, #1
    mov r0, #13
    swi 0

.section .data
