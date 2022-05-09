run: hello.img
	qemu-system-x86_64 -hda hello.img

hello.img: hello.o link.ld
	ld --oformat binary -T link.ld hello.o -o hello.img 

hello.o: hello.s
	as -g hello.s -o hello.o

clean:
	rm -rf hello.o hello.img
