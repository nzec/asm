#include <stdio.h>
#include <stdlib.h>

extern long long fib(long long n);

int main(int argc, char **argv) {
	if (argc == 1) {
		printf("usage: %s n\n", argv[0]);
		return 1;
	}

	long long n = atoll(argv[1]);
	printf("fib(%d) = %lld\n", n, fib(n));

	return 0;
}
