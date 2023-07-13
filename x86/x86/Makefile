hello: hello.o
	ld -m elf_i386 hello.o -o hello

hello.o: hello.s
	as --32 hello.s -o hello.o

clean: hello hello.o
	rm -f hello.o hello
