#include <stdio.h>
#include <stdlib.h>

extern void allocate_init();
extern void *allocate(size_t size);
extern void deallocate(void *ptr);

int main(int argc, char **argv) {
	if (argc != 2) {
		printf("usage: %s seed\n", argv[0]);
		return 1;
	}
	allocate_init();
	
	srand(atoi(argv[1]));

	int max = 4;
	
	int m = rand() % max;
	printf("%d\n", m);
	for (int i = 0; i < m; i++) {
		int t = rand() % max;
		printf(">%d\n", t);
		int *arr[t];
		for (int j = 0; j < t; j++) {
			int n = rand() % max;
			printf(">>%d\n", n);
			arr[j] = (int *)allocate(n * sizeof(int));
			for (int k = 0; k < n; k++) {
				arr[j][k] = k;
				printf(">>>%d\n", arr[j][k]);
			}
		}
		for (int j = 0; j < t; j++) {
			deallocate(arr[j]);
		}
	}
}
