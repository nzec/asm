.equ a_val, 40
.equ b_val, 25

.text
.global _start

_start:
    ldr r0, =a_val // load a
    ldr r1, =b_val // load b
loop_start:
    cmp r0, r1
    beq loop_end
if_start:
    cmp r0, r1
    ble else_start
    sub r0, r0, #1
    b loop_finish
else_start:
    sub r1, r1, #1
loop_finish:
    b loop_start
loop_end: bkpt #0
