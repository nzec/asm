square: square_c.o square_f.o
	ld square_c.o square_f.o -o square

square_c.o: square_c.s
	as square_c.s -o square_c.o

square_s.o: square_f.s
	as square_f.s -o square_f.o

clean:
	rm -f *.o square
