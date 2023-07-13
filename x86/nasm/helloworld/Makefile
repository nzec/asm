helloworld: helloworld.o
	ld -m elf_i386 helloworld.o -o helloworld
helloworld.o: helloworld.nasm
	nasm -f elf32 helloworld.nasm
