flex lexer.l
gcc lex.yy.c -o ext
./ext < test 