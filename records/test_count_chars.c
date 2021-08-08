#include <stdio.h>
#include <stdlib.h>

extern long long count_chars(char *s);

int main(int argc, char **argv) {
	if (argc != 2) {
		printf("usage: %s <string>\n", argv[0]);
		return 0;
	}

	printf("count_chars(argv[1]) = %lld\n", count_chars(argv[1]));

	return 0;
}
