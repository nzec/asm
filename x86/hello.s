.global _start

.data
hello:
	.ascii "hello world\n"
hellolen = . - hello

.text
_start:
	mov $4, %eax
	mov $1, %ebx
	mov $hello, %ecx
	mov $12 , %edx
	int $0x80

	mov $1, %eax
	xor %ebx, %ebx
	int $0x80
