%{
    void yyerror(char* s);
    #include <stdio.h>
    #include <stdlib.h>
    int symbols[52];
    int getSymbolVal(char symbol);
    void setSymbolVal(char symbol, int val);  
%}

%union {
    int num; 
    char id;
}
%start line
%token print
%token exit_cmd
%token <num> number
%token <id> identifier
%type <num> line exp term
%type <id> assignment

%%
    line : assignment ';' {;}
        | exit_cmd ';' {
            exit(EXIT_SUCCESS);
        }
        | print exp ';' {
            printf("%d\n", $2);
        }
        | line assignment ';' {;}
        | line print exp ';' {
            printf("%d\n", $3);
        }
        | line exit_cmd ';' {
            exit(EXIT_SUCCESS);
        }
        ;

    assignment : identifier '=' exp {
        setSymbolVal($1, $3);
    };

    exp : term {$$ = $1;}
        | exp '+' term {$$ = $1 + $3;}
        | exp '-' term {$$ = $1 - $3;}
        ;

    term : number {$$ = $1;}
        | identifier {$$ = getSymbolVal($1);} 
        ;
%%

int computeSymbolIndex(char token) {
    int idx = -1;
    if(islower(token)) {
        idx = token - 'a' + 26;
    }
    else if(isupper(token)) {
        idx = token - 'A';
    }
    return idx;
}

int getSymbolVal(char symbol) {
    int index = computeSymbolIndex(symbol);
    return symbols[index];
}

void setSymbolVal(char symbol, int value) {
    int index = computeSymbolIndex(symbol);
    symbols[index] = value;
}

int main() {
    int i;
    for(i=0; i<52; ++i) {
        symbols[i] = 0;
    }
    return yyparse();
}

void yyerror(char* s) {
    fprintf(stderr, "%s\n", s);
}