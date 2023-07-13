.global main

main:
	push   {r11, lr}
	add    r11, sp, #0
	sub    sp, sp, #16
	mov    r0, #1
	mov    r1, #2
	bl     max
	sub    sp, r11, #0
	pop    {r11, pc}

max:
	push   {r11}
	add    r11, sp, #0
	sub    sp, sp, #12
	cmp    r0, r1
	movlt  r0, r1
	add    sp, r11, #0
	pop    {r11}
	bx     lr
