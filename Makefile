wc: wc.l 
		flex wc.l
		gcc -o $@ lex.yy.c -lfl