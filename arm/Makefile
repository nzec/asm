run: $(TARGET).out
	qemu-arm $(TARGET).out

gdb: $(TARGET).out
	qemu-arm -L /usr/arm-linux-gnueabi/ -g 1234 $(TARGET).out &
	gdb-multiarch -q --nh -ex 'set architecture arm' -ex 'file $(TARGET).out' -ex 'target remote localhost:1234' -ex 'layout split' -ex 'layout regs'

gef:
	qemu-arm -L /usr/arm-linux-gnueabi/ -g 1234 $(TARGET).out &
	gdb-multiarch -q -ex 'set architecture arm' -ex 'file $(TARGET).out' -ex "gef-remote --qemu-binary $(TARGET).out --qemu-user localhost 1234"

$(TARGET).out: $(TARGET).o
	arm-linux-gnueabi-ld $(TARGET).o -o $(TARGET).out

$(TARGET).o: $(TARGET).asm
	arm-linux-gnueabi-as $(TARGET).asm -o $(TARGET).o

clean:
	rm -f $(TARGET).o $(TARGET).out
