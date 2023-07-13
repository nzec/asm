all: fib_a fib_c

fib_a: fib_a.o fib.o
	ld --dynamic-linker /lib64/ld-linux-x86-64.so.2 fib.o fib_a.o -o fib_a -lc

fib_c: fib.o fib_c.c
	cc fib_c.c fib.o -o fib_c

fib_a.o: fib_a.s
	as fib_a.s -o fib_a.o

fib.o: fib.s
	as fib.s -o fib.o

clean:
	rm -f fib.o fib_a.o fib_a fib_c
