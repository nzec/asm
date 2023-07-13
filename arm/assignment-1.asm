.data
mem_j: .word 0

.text
.global _start

_start:
    mov r0, #0
    mov r1, #0
loop_start:
    cmp r0, #15
    beq loop_end
    add r1, r1, #2
    add r0, r0, #1
    b loop_start
loop_end:
    ldr r2, =mem_j
    str r1, [r2]
    // syscall exit()
    mov r7, #0x1
    mov r0, r1
    swi 0
