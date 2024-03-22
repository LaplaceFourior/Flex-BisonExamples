%{
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
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
                                                    $$ = malloc(1024); 
                                                    sprintf($$, "%s", $2); 
                                                }
    | CONTENT_START CONTENT_END                   { 
                                                     
                                                }
    | FRAC_START elements elements FRAC_END     { 
                                                    $$ = malloc(1024); 
                                                    sprintf($$, "(%s/%s)", $2, $3);
                                                }
    | SQRT_START elements elements SQRT_END     {   
                                                    $$ = malloc(1024); 
                                                    sprintf($$, "sqrt(%s, %s)", $2, $3);
                                                }
    | POWER_START elements elements POWER_END   {
                                                    $$ = malloc(1024); 
                                                    sprintf($$, "pow(%s, %s)", $2, $3);
                                                }
    | SUBPOWER_START elements elements elements SUBPOWER_END    {
                                                                    $$ = malloc(1024); 
                                                                    sprintf($$, "pow(%s, %s)", $3, $4);
                                                                }
    | ROW_START elements ROW_END                {
                                                    $$ = $2; 
                                                }
    | ROW_START ROW_END                         {

                                                }
    | elements elements                         {
                                                    $$ = malloc(2048); 
                                                    sprintf($$, "%s%s", $1, $2);
                                                }
    ;

%%