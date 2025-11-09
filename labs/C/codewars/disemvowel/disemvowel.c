#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>
//solution must allocate all required memory
//and return a free-able buffer to the caller.

void *disemvowel(const char *str)
{
  int len = (int)strlen(&str);
  char vowels[5] = {'a', 'e', 'i', 'o', 'u'};
  char new[len];
  int current =0;
  for (int i = 0; i < len -1; i++){
    for (int j = 0; j < 5; j++){
      if (vowels[j] != tolower(str[i])){
        new[current] = str[i];
        current++;
        j = 10;
      }
    }
  }
  printf("%s", new);
	//return calloc(1, 1);
}

void main(){
    disemvowel("HELLO World");
}