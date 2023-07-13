a.out: upper.o caller.o
	ld upper.o caller.o

upper.o: upper.s
	as upper.s -o upper.o

caller.o: caller.s
	as caller.s -o caller.o

clean: 
	rm -f a.out upper.o caller.o
