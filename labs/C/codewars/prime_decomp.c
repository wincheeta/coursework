#include <stdio.h>

void prime_decomp(long int n, int p) {
    int factors[32];
    int *point = &factors[0];
    int found = 0;
    while (n != 1) {
        for (int i = 2; i <= n; i++) {
            while (n % i == 0) {
                *point = i;
                point++;
                n /= i;
                found += 1;
            }
        }
        if (!found) break; // Exit if no factors are found
    }
    for (int i = 0; i < found; i++){
        printf("%i\n", factors[i]);
    }
}

int main() {
    double n = 1098765;
    int p = 0;
    prime_decomp(n, p);
    return 0;
}