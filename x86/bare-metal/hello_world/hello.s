	# write 16-bit code
	# https://sourceware.org/binutils/docs-2.36/as/i386_002d16bit.html
	.code16
	mov $msg, %si
	# write character in tty mode
	# https://en.wikipedia.org/wiki/BIOS_interrupt_call#Interrupt_table
	mov $0x0e, %ah

loop_hello:
	lodsb
	# check if %al = 0 (end of string)
	# this is preferred over cmp $0, %al because this generates shorter machine code
	or %al, %al
	jz chars

	# bios video service
	# al = character, bh = page number, bl = color (only in graphics mode)
	# https://en.wikipedia.org/wiki/INT_10H
	int $0x10
	jmp loop_hello

chars:
	mov $'A', %al
loop_chars:
	int $0x10
	inc %al

	cmp $'Z', %al
	jle loop_chars

halt:
	hlt
msg:
	# have to use newline + carriage return (because we are in msdos world)
	.asciz "hello world\n\r"
