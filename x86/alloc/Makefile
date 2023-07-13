all: alloc.o test.out

alloc.o: alloc.s
	as alloc.s -o alloc.o

test.out: alloc.o test.c
	cc test.c alloc.o -no-pie -o test.out

clean:
	rm -f alloc.o test.out
