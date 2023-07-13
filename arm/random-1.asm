.section .text
.global _start

_start:
    mov r0, #4
    mov r1, #2
    cmp r0, r1
    cmp r1, r0
