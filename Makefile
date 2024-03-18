calculate_verson1: calculate.l calculate.y calculate.h calculate.c
		bison -d calculate.y
		flex -o calculate.lex.c calculate.l
		cc -o $@ calculate.tab.c calculate.lex.c calculate.c
