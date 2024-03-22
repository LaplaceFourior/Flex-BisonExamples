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
%token <s> CONTENT

%type <s> elements

%%
mathml:
    MATH_START elements MATH_END        { printf("%s\n", $2); }
    ;
elements:
    CONTENT_START CONTENT CONTENT_END           { 
                                                    $$ = malloc(1024); // 分配内存
                                                    sprintf($$, "%s", $2); 
                                                }
    | FRAC_START elements elements FRAC_END     { 
                                                    $$ = malloc(1024); // 分配内存
                                                    sprintf($$, "(%s/%s)", $2, $3);
                                                }
    | SQRT_START elements elements SQRT_END     {   
                                                    $$ = malloc(1024); // 分配内存
                                                    sprintf($$, "sqrt(%s, %s)", $2, $3);
                                                }
    | POWER_START elements elements POWER_END   {
                                                    $$ = malloc(1024); // 分配内存
                                                    sprintf($$, "pow(%s, %s)", $2, $3);
                                                }
    | ROW_START elements ROW_END                {
                                                    $$ = $2; // 假设$2已经是动态分配的字符串
                                                }
    | elements elements                         {
                                                    $$ = malloc(2048); // 分配更大的内存以容纳两个字符串
                                                    sprintf($$, "%s%s", $1, $2);
                                                }
    ;

%%