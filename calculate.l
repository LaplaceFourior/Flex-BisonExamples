%option noyywrap nodefault yylineno
%{
# include "calculateTool.h"
# include "calculate.tab.h"
%}

EXP ([Ee][-+]?[0-9]+)

%%
"+" |
"-" |
"*" |
"/" |
"(" |     
")"     { return yytext[0]; }
[0-9]+"."[0-9]*{EXP}? |
"."?[0-9]+{EXP}? { yylval.d = atof(yytext); return NUMBER;}
"//".*\n
\n      { return EOL;}
[ \t]   { }
quit    { return EOF; }
.       { yyerror("Mystery character %c\n", *yytext);}
%%