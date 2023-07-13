SECTION .TEXT
	GLOBAL _start 

_start:
	mov eax, 10
	mov ebx, 10
    imul eax, ebx

	mov ebx, eax
	mov eax, 1
	int 80h

