#include <stdio.h>
#include <stdlib.h>

struct node {
	long long value;
	struct node *next;
};

extern struct node *list_new();
extern struct node *list_insert(long long value, struct node *top);
extern void list_print(struct node *top);

int main(int argc, char **argv) {
	struct node *top = list_new();

	int v;
	while (scanf("%lld", &v) == 1) {
		top = list_insert(v, top);
		list_print(top);
	}

	return 0;
}

