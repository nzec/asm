.syntax unified
.text
.global _start

_start:
    // .arm
    .code 32
    // mov r3, pc
    // add r3, pc, #2
    add r3, pc, #1
    bx r3

    // .thumb
    .code 16
    cmp r0, #10
    ite eq
    addeq r1, #2
    addne r1, #3
    bkpt
