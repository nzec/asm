test: test.c itoa.o
	cc test.c itoa.o -o test

itoa.o: itoa.s
	as itoa.s -o itoa.o

clean:
	rm -rf test itoa.o
