#include "stdio.h"

#include "./add/add.h"
#include "./division/division.h"
#include "./multiplication/multiplication.h"
#include "./sub/sub.h"

int main() {
  int a = add(1, 2);
  int b = sub(3, 4);
  int c = multiplication(5, 6);
  int d = division(7, 8);

  printf("%d %d %d %d", a, b, c, d);
}
