/*
	Written in x86 convention
	Assemble : as forth.s -o forth.o
	Link     : ld -m elf_i386 forth.o -o forth
	Run      : ./forth

	Linux system call numbers: /usr/include/asm/unistd_32.h

	<--- DICTIONARY ENTRY (HEADER) ----------------------->
	+------------------------+--------+-------------- - - +----------- - -
	| LINK POINTER           | LENGTH/| NAME	      | DEFINITION
	|			 | FLAGS  |     	      |
	+---- 4 bytes -----------+- byte -+- 4n - 1 bytes - - +----------- - -
*/

	.macro NEXT
	lodsl
	jmp *(%eax)
	.endm

