#include <stdio.h>

int find_even_index(const int *values, int length) {
  int* start = values;
  int* end = (values + length - 1);
  int a= (int) *start;
  int b= (int) *end;
  start++;
  end--;
  
  while (end > start){
    if (a > b){
      end--;
      b += (int) *end;
    }
    else{
      start++;
      a += (int) *start;
    }
  }
  return a;
}

int main(){
    int * arr[] = {1,2,3,4,3,2,1};
    find_even_index(arr,7);
    return 0;
}   



int awd;float awdawd;
