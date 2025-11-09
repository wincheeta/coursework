#include <stdio.h>

int main() {
    int stud;
    printf("Enter the number of students: ");
    scanf("%i", &stud);
    
    int a[4];
    int sum, total, dis, mer, pas, fal;
    for (int i = 0; i < stud; i++) {
        printf("Enter the marks for Student #%d: ", i + 1);
        scanf("%i %i %i %i", &a[0], &a[1], &a[2], &a[3]);
        for (int j = 0; j <4; j++){
            sum += a[j];
            if (a[j] < 40){
                fal++;
            }else if (a[j] <60){
                pas++;
            }else if (a[j] < 70){
                mer++;
            }else{
                dis++;
            }
        }

        printf("The average for Student #%i is %.2f\n", i+1, (float) sum/4 );
        total += sum;
    }
    printf("The total number of distinctions is %i", dis);
    printf("The total number of merits is %i", mer);
    printf("The total number of passes is %i", pas);
    printf("The total number of fails is %i", fal);
    printf("The overall average is %.2f", (float) total/ (stud*4));
    return 0;
}