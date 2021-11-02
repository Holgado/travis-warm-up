// ----------------------------------------------------------------
// ESPECIFICAÇÃO: O programa deve determinar se um identificador
// é ou não válido. Um identificador válido deve começar com uma
// letra e conter apenas letras ou dígitos. Além disto, deve ter
// no mínimo 1 caractere e no máximo 6 caracteres de comprimento
// ----------------------------------------------------------------

#include "identifier.h"


int valid_s(char ch) {
  if (((ch >= 'A') && (ch <= 'Z')) || ((ch >= 'a') && (ch <= 'z')))
    return 1;
  else
    return 0;
}

int valid_f(char ch) {
  if (((ch >= 'A') && (ch <= 'Z')) || ((ch >= 'a') && (ch <= 'z')) || ((ch >= '0') && (ch <= '9')))
    return 1;
  else
    return 0;
}

int identifier(char str[]) {
  int length, valid_id, i; 

  length = strlen(str);
  
  printf("\nIdentificador: ");
  valid_id = valid_s(str[0]);

  if (length == 0) {
    printf("Invalido\n");
    return 1;
  }

  i = 1;
  while(i < length) {
    if(!(valid_f(str[i]))) {
      valid_id = 0;
    }
    i++;
  }

  if (valid_id && (length >= 1) && (length < 6)) {
    printf("Valido\n");
    return 0;
  }
  else {
    printf("Invalido\n");
    return 1;
  }
  
}
