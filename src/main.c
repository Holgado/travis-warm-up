#include "identifier.h"

int main(int argc, char *argv[]) {
  if (argv[1]) {
    printf("Meu argv, %s", argv[1]);
    identifier(argv[1]);
  }
  else {
    identifier("");
  }
}