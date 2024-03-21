calculate_verson1: calculate.l calculate.y calculateTool.h calculateTool.c
		bison -d calculate.y
		flex -o calculate.lex.c calculate.l
		cc -o $@ calculate.tab.c calculate.lex.c calculateTool.c
