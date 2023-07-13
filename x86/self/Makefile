hello: hello.o
	ld -N -o hello hello.o

hello_orig: hello.o
	ld -o hello_orig hello.o

hello.o: hello.nasm
	nasm -f elf64 -o hello.o hello.nasm
