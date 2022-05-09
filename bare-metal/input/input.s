	.code16
loop:
	# read character
	mov $0x0, %ah
	# read keypress
	# returns %ah = scan code of key pressed
	# %al = ascii character of the key pressed
	# https://en.wikipedia.org/wiki/INT_16H
	int $0x16

	# print %al (the character that was input)
	mov $0x0e, %ah
	int $0x10

	jmp loop
