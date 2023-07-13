.equ a_val, 10
.equ b_val, 20
.equ x_val, 13
.equ y_val, 24
.equ c_val, 50
.equ d_val, 40

// r0 = a
// r1 = b
// r2 = x
// r3 = y
// r4 = c
// r5 = d
.text
.global _start
_start:
    ldr r0, =a_val  // load value of a
    ldr r1, =b_val  // load value of b
    ldr r2, =x_val  // load value of x
    ldr r3, =y_val  // load value of y
    ldr r4, =c_val  // load value of c
    ldr r5, =d_val  // load value of d
if_start:
    cmp r0, r1
    bge else_start
    mov r2, #5      // x = 5
    add r3, r4, r5  // y = c + d
    b if_finish
else_start:
    sub r2, r4, r5
if_finish:
    bkpt
