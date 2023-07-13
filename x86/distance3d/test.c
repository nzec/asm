#include <stdio.h>
#include <stdlib.h>

extern float distance3d(float x, float y, float z);

int main(int argc, char **argv) {
	if (argc <= 1) {
		printf("usage: %s [x] [y] [z]\n", argv[0]);
		return 0;
	}
	float v[3] = {};
	for (int i = 1; i <= 3; i++) {
		if (argc >= i + 1) {
			v[i - 1] = atof(argv[i]);
		}
	}
	printf("%f\n", distance3d(v[0], v[1], v[2]));
}
