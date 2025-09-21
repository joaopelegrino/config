#include <stdio.h>
#include <stdlib.h>

int main() {
    printf("Hello, World! This is a test file for copy-paste workflow.\n");

    int numbers[] = {1, 2, 3, 4, 5};
    int size = sizeof(numbers) / sizeof(numbers[0]);

    printf("Array contents: ");
    for(int i = 0; i < size; i++) {
        printf("%d ", numbers[i]);
    }
    printf("\n");

    return 0;
}