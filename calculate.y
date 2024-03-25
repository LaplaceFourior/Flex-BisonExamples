%{
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "calculateTool.h"
%}

%union {
char* s;
}
%token MATH_START MATH_END  CONTENT_START CONTENT_END FRAC_START FRAC_END 
%token SQRT_START SQRT_END ROW_START ROW_END POWER_START POWER_END
%token SUBPOWER_START SUBPOWER_END
%token <s> CONTENT

%type <s> elements

%%
all: 
    | all mathml
    ;

mathml:
    MATH_START elements MATH_END                { printf("%s\n", $2); }
    ;
elements:
    CONTENT_START CONTENT CONTENT_END           { 
                                                    $$ = malloc(strlen($2) + 1);
                                                    strcpy($$, $2); 
                                                }
    | CONTENT_START CONTENT_END                 { 
                                                     
                                                }
    | FRAC_START elements elements FRAC_END     { 
                                                    int len = strlen($2) + strlen($3) + 4;
                                                    $$ = malloc(len); 
                                                    sprintf($$, "(%s/%s)", $2, $3);
                                                    free($2);
                                                    free($3);
                                                }
    | SQRT_START elements elements SQRT_END     {   
                                                    int len = strlen($2) + strlen($3) + 9;
                                                    $$ = malloc(len); 
                                                    sprintf($$, "sqrt(%s, %s)", $2, $3);
                                                    free($2);
                                                    free($3);
                                                }
    | POWER_START elements elements POWER_END   {
                                                    int len = strlen($2) + strlen($3) + 8;
                                                    $$ = malloc(len); 
                                                    sprintf($$, "pow(%s, %s)", $2, $3);
                                                    free($2);
                                                    free($3);
                                                }
    | SUBPOWER_START elements elements elements SUBPOWER_END    {
                                                                    int len = strlen($3) + strlen($4) + 8;
                                                                    $$ = malloc(len); 
                                                                    sprintf($$, "pow(%s, %s)", $3, $4);
                                                                    free($3);
                                                                    free($4);
                                                                }
    | ROW_START elements ROW_END                {
                                                    $$ = malloc(strlen($2) + 1);
                                                    strcpy($$, $2);
                                                }
    | ROW_START ROW_END                         {

                                                }
    | elements elements                         {
                                                    int len = strlen($1) + strlen($2) + 1;
                                                    $$ = malloc(len); 
                                                    sprintf($$, "%s%s", $1, $2);
                                                    free($1);
                                                    free($2);
                                                }
    ;

%%