%option noyywrap nodefault yylineno
%{
# include "calculateTool.h"
# include "calculate.tab.h"
%}

%%
"<mml:math"[^>]*">"     { return MATH_START; }
"</mml:math>"           { return MATH_END; }

"<mml:mo"[^>]*">" |
"<mml:mi"[^>]*">" |
"<mml:mn"[^>]*">"       { return CONTENT_START; }     
"</mml:mo>" |
"</mml:mi>" |           
"</mml:mn>"             { return CONTENT_END; }
              
"<mml:msqrt"[^>]*">"    { return SQRT_START; }
"</mml:msqrt>"          { return SQRT_END; }

"<mml:msup"[^>]*">"     { return POWER_START; }
"</mml:msup>"           { return POWER_END; }

"<mml:mrow"[^>]*">" |
"<mml:mfenced"[^>]*">"  { return ROW_START; }
"</mml:mrow>" |
"</mml:mfenced>"        { return ROW_END; }

"<mml:mfrac"[^>]*">"    { return FRAC_START; }
"</mml:mfrac>"          { return FRAC_END; }

"<mml:msubsup"[^>]*">"  { return SUBPOWER_START; }
"</mml:msubsup>"        { return SUBPOWER_END; }


"+" |
"-" |
"*" |
"/" |
"(" |     
")" |
"," |
"=" |
";" |
">" |
"<" |
[a-zA-Z0-9]+             { yylval.s = strdup(yytext); return CONTENT; }

[ \t\n]                 { }
.                       { }
%%