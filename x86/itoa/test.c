#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

extern char *itoa(long long value, char *str, long long base);

int main(int argc, char **argv) {
	if (argc != 3) {
		printf("usage: %s <value in base 10> <base>\n", argv[0]);
		return 1;
	}

	long long n = atoll(argv[1]);
	long long b = atoll(argv[2]);
	char s[100] = {};
	char *r = itoa(n, s, b);
	printf("itoa(%d, str, %d) = \"%s\"\n", n, b, s);

	printf("str = %p\nret = %p\n", s, r);
	assert(s == r);

	return 0;
}
