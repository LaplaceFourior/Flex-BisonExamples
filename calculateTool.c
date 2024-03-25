#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <math.h>
#include "calculateTool.h"

extern FILE* yyin;

void yyerror(char* s, ...)
{
    va_list ap;
    va_start(ap, s);

    fprintf(stderr, "%d: error: ", yylineno);
    vfprintf(stderr, s, ap);
    fprintf(stderr, "\n");
}
// read file
int main(int argc, char** argv)
{
    if( argc > 1 ) {
        yyin = fopen(argv[1], "r");
        if( !yyin ) {
            perror(argv[1]);
            return 1;
        }

        yyparse();
        fclose(yyin);
    } else {
        printf("> ");
        yyparse();
    }

    return 0;
}


