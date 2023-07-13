mul: mul.o
	ld -m elf_i386 mul.o -o mul
mul.o: mul.nasm
	nasm -f elf32 mul.nasm
