#include <stdio.h>
#include <math.h>
#include <malloc.h>

double *space (int n){
    double *out = malloc(sizeof(int) *(unsigned)n);
    double a;
    for (int i =0; i<n; i++){
        scanf("%lf",&a);
        *(out + i*__SIZEOF_DOUBLE__) = a;
    }
    return out;
}

double manhattan (double *point1, double *point2, int n){
    double sum = 0;
    for (int i = 0; i < n; i++){
        sum += fabs(*(point1+i*__SIZEOF_DOUBLE__)-*(point2+i*__SIZEOF_DOUBLE__));
    }
    return sum;
}


int main(){
    double *first_point = space(4);
    double *second_point = space(4);
    printf("%lg\n", manhattan(first_point, second_point, 4));
}