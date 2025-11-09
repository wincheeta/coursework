#include <stdio.h>
#include <math.h>

int digPow(int n, int p) { 
  int arr[100]; 
  int i = 0; 
  int j, r; 
  while (n != 0) { 
    r = n % 10;
    arr[i] = r; 
    i++;
    n = n / 10; 
    }
  int sum = 0;
  for (j = i - 1; j > -1; j--) { 
    sum += (int) pow(arr[j],p);
    p++;
    } 
  if (sum % n){
    return sum / n;
  }
  else{
    return -1;
  }
} 

int main(){
  printf("%i",digPow(89,1));
  return 0;
}