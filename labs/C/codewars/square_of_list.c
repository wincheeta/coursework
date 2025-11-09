#include <stddef.h>
#include <stdio.h>

int square_sum(const int values[/* count */], size_t count)
{
  int sum = 0;
  for (int i=0; i < count; i++){
    sum += values[i] * values[i];
  }
  printf("%i", sum);
  return 0;
}