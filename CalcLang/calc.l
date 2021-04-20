%{
    #include "calc.tab.h"
%}

%%
"print" {return print;}
"exit" {return exit_cmd;}
[a-zA-z] {yylval.id = yytext[0]; return identifier;}
[0-9]+ {yylval.num = atoi(yytext); return number;}
[ \t\n] ;
[-+=;] {return yytext[0];}
. {ECHO; return printf("unexpected character\n");}
%%

int yywrap() {
    return 1;
}