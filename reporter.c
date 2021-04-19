#include <stdio.h>
#include "tokens.h"

extern int yylex();
extern int yylineno;
extern const char* yytext;

int main() {
    int number_token, value_token;
    number_token = yylex();
    while(number_token) {
        printf("%d\n", number_token);
        number_token = yylex();
    }
}