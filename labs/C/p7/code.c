#include <stdio.h>
#include <string.h>

void stringconversion(int length, int chars, size_t newarray[], char counties[][chars]){
    for (int i = 0; i < length; i++){
        printf("%i\n", strlen(counties[i]));
        newarray[i] = strlen(counties[i]);
    }
}

double arraycompare(int a, int b, int* arr1, int* arr2){
    double mean1, mean2;
    for (int i = 0; i < a; i++){
        mean1 += (1/(double)arr1[i]);
    }
    for (int i = 0; i < b; i++){
        mean2 += (1/(double)arr2[i]);
    }
    mean1 = a/mean1;
    mean2 = b/mean2;
    if (mean1 >mean2){
        return mean1;
    }
    else{
        return mean2;
    }
}   


void matrixproduct(int r1, int c1, int r2, int c2, int arr1[r1][c1], int arr2[r2][c2]){
    int arrr[r1][c2];

    if (c1 == r2 && r1 > 0 && c1 > 0 && r2 > 0 && c2 > 0){
        for (int r = 0; r<r1;r++){
            for (int c = 0; c <c2; c++){
                int sum = 0;
                for (int k = 0; k < c1; k++){
                    sum += arr1[r][k] * arr2[k][c];
                }
                arrr[r][c] = sum;
                printf("%4i", arrr[r][c]);

            }
        printf("\n");
        }
    }
    else{
        printf("Invalid arguments");
    }
}

void stringsort(int elements, int length, char counties[elements][length]){
    int flag = 1;
    while (flag){
        flag = 0;
        for (int i = 0; i <elements-1; i++){
            if ( strcmp(counties[i],counties[i+1]) > 0 ){
                flag = 1;
                char temp[length];
                strcpy(temp,counties[i]);
                strcpy(counties[i],counties[i+1]);
                strcpy(counties[i+1],temp);
            }
        }
    }
    for (int i = 0; i < elements; i++){

        printf("%s\n", counties[i]);
    }
}

int main(){
    char counties[48][40] = {
        "Oxfordshire", "Kent", "Lancashire", "Cornwall", "Devon", "Essex", "Hampshire", "Surrey",
        "West Sussex", "East Sussex", "Norfolk", "Suffolk", "Cambridgeshire", "Bedfordshire",
        "Hertfordshire", "Buckinghamshire", "Berkshire", "Gloucestershire", "Somerset", "Dorset",
        "Wiltshire", "Warwickshire", "Worcestershire", "Herefordshire", "Shropshire", "Staffordshire",
        "Cheshire", "Derbyshire", "Nottinghamshire", "Leicestershire", "Rutland", "Lincolnshire",
        "Northamptonshire", "Yorkshire", "Durham", "Northumberland", "Cumbria", "Greater London",
        "Merseyside", "Tyne and Wear", "West Midlands", "Greater Manchester", "South Yorkshire",
        "West Yorkshire", "East Riding of Yorkshire", "Isle of Wight", "Bristol", "Rutland"
    };
    stringsort(48, 40, counties);
}