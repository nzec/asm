.section .text
.global _start

_start:
   ldr r0, =jump
   ldr r1, =0x68DB00AD
jump:
   ldr r2, =511
   bkpt
