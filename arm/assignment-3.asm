.text
.global _start
_start:
    and r1, r1, r2  // A.B
    and r3, r3, r4  // C.D
    mvn r3, r3      // !(C.D)
    orr r5, r1, r3  // A.B + !(C.D)
    bkpt
