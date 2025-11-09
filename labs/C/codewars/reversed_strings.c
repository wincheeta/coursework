#include <string.h>
#include <stdio.h>
#include <limits.h>


int main(){
    int x = 12;
    int * y = &x;
    printf("%i, %i", x,y);
}