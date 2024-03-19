includefile: includefile.l 
		flex includefile.l
		gcc -o $@ lex.yy.c -lfl