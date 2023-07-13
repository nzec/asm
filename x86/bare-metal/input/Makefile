run: input.img
	qemu-system-x86_64 -hda input.img

input.img: input.o link.ld
	ld --oformat binary -T link.ld input.o -o input.img 

input.o: input.s
	as -g input.s -o input.o

clean:
	rm -rf input.o input.img
