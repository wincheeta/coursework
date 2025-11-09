#include <stdio.h>
#include <math.h>

struct point {
    double x;
    double y;
};

double distance(struct point a,struct point b){
    return sqrt((a.x-b.x)*(a.x-b.x)+(a.y-b.y)*(a.y-b.y));
}

int analyse(double *prod , double *sum, double d1, double d2){
    int r;
    if ((d1 > 0 && d2 >0) || (d1 > 0 && d2 >0)){
        int r = 1;
    }
    else{
        int r = -1;
    }
    d1 = round(d1);
    d2 = round(d2);
    *prod = d1*d2;
    *sum = d1 + d2;
    return r;
}

struct date
{
    int day;
    int month;
    int year;
};

#include <stdio.h>
#include <math.h>
#include <stdbool.h>

bool leap (struct date *test_date){
    struct date wa = *test_date;
    int rem_4, rem_100, rem_400;
    rem_4 = wa.year % 4;
    rem_100 = wa.year % 100;
    rem_400 = wa.year % 400;

    if ( (rem_4 == 0 && rem_100 != 0) || rem_400 == 0 ){
        return 1;
    }
    else{
        return 0;
    }

}

int count (struct date *test_date){
    struct date wa = *test_date;
    int thir[] ={4,6,9,11};
    int one[7] ={1,3,5,7,8,10,12};
    for (int i = 0; i < 5; i++){
        if (thir[i] == wa.month){
            return 30;
        }
    }
    for (int i = 0; i < 7; i++){
        if (one[i] == wa.month){
            return 31;
        }
    }
    if (wa.month == 2){
        if (leap(&wa)){
            return 29;
        }
        else {
            return 28;
        }
    }
    return 0;
}

struct date *next_day (struct date *test_date){
    struct date *current = malloc(sizeof(struct date));
    * current = *test_date;
    (*current).day++;
    if ((*current).day > count(test_date)){
        (*current).month++;
        (*current).day = 1;
        if ((*current).month == 13){
            (*current).month = 1;
            (*current).year++;
        }
        return current;
    } else{
        return current;
    }
}

int main(void)
{

    return 0;
}