all: call_c call_as

call_c: call_c.c linked.o
	cc -g -no-pie call_c.c linked.o -o call_c

call_as: linked.o call_as.o
	ld --dynamic-linker /lib64/ld-linux-x86-64.so.2 linked.o call_as.o -o call_as -lc

linked.o: linked.s
	as -g linked.s -o linked.o

call_as.o: call_as.s
	as -g call_as.s -o call_as.o

clean:
	rm -f linked.o call_as.o call_as call_c
