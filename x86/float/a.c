#include <stdio.h>

float square(float a) {
	return a*a;
}

int main() {
	float a = 10.23;
	printf("%f\n", square(a));
}
