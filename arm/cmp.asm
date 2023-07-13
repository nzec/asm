.global _start

_start:
    mov     r0, #2
    cmp     r0, #3
    addlt   r0, r0, #1
    cmp     r0, #3
    addlt   r0, r0, #1
    bx      lr
