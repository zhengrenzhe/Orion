#include "stdio.h"

int add(int x, int y) {
  int res = x + y;
  res += res;
  return res;
}

int main() {
  int a = add(1, 2);
  int b = add(3, 4);
  int c = add(5, 6);
  int d = add(7, 8);
  int e = add(9, 0);

  printf("%d %d %d %d %d", a, b, c, d, e);
}
