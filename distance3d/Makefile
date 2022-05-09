test: test.c distance3d.o
	cc test.c distance3d.o -o test

distance3d.o: distance3d.s
	as distance3d.s -o distance3d.o

clean:
	rm -rf test distance3d.o
