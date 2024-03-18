calculate: calculate.l calculate.y
		bison -d calculate.y
		flex calculate.l
		cc -o $@ calculate.tab.c lex.yy.c -lfl