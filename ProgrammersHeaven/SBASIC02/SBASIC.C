/**********************************************************/
/* SMALL BASIC Interpeter (sbasic.c) V0.2                 */
/* Copyright (C) 1994 James J. Bielman                    */
/* Adapted from _C Power User's Guide_ by Herbert Schildt */
/**********************************************************/

#include<stdio.h>
#include<setjmp.h>
#include<math.h>
#include<ctype.h>
#include<stdlib.h>

#define NUM_LAB         100
#define LAB_LEN         10
#define FOR_NEST        25
#define SUB_NEST        25
#define PROG_SIZE       0xFFFF

#define DELIMITER       1
#define VARIABLE        2
#define NUMBER          3
#define COMMAND         4
#define STRING          5
#define QUOTE           6

#define PRINT           1
#define INPUT           2
#define IF              3
#define THEN            4
#define FOR             5
#define NEXT            6
#define TO              7
#define GOTO            8
#define EOL             9
#define FINISHED        10
#define GOSUB           11
#define RETURN          12
#define END             13
#define ELSE		14

char    *prog;          /* holds expression to be analyzed */
jmp_buf e_buf;          /* holds env for longjmp() */
int 	source_line = 1;

int variables[26] = { 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0 
};

struct commands {       /* keyword lookup table */
	char command[20];
	char tok;
} table[] = {
	"print",  PRINT,
	"input",  INPUT,
	"if",     IF,
	"then",   THEN,
	"else",   ELSE,
	"goto",   GOTO,
	"for",    FOR,
	"next",   NEXT,
	"to",     TO,
	"gosub",  GOSUB,
	"return", RETURN,
	"end",    END,
	"",       END,
};

char token[80];
char token_type, tok;

struct label {
	char name[LAB_LEN];
	char *p;
};
struct label label_table[NUM_LAB];

struct for_stack {
	int var;
	int target;
	char *loc;
} fstack[FOR_NEST];

char *gstack[SUB_NEST];

int ftos;               /* index to top of FOR stack */
int gtos;               /* index to top of GOTO stack */

int main(int argc, char **argv)
{
	char in[80];
	int answer;
	char *p_buf;
	char *t;

	if(argc < 2)
	{
		printf("usage: %s filename ..\n", argv[0]);
		exit(1);
	}

	printf("Small BASIC V0.2\n");
	printf("Copyright (C) 1994 James J. Bielman\n");
	printf("All Rights Reserved\n");
	printf("\nThis is free software, with ABSOLUTELY NO WARANTEE\n");
	printf("Read the file GNU.LIC for details\n\n");

	/* Allocating memory for the program */
	if(!(p_buf = (char *)malloc(PROG_SIZE)))
	{
		printf("memory allocation error. .\n");
		exit(1);
	}

	/* Load the program */
	if(!load_program(p_buf, argv[1])) exit(2);

	if(setjmp(e_buf)) exit(1);

	prog = p_buf;
	scan_labels();
	ftos = 0;
	gtos = 0;
	do
	{
		token_type = get_token();

		exec_command();
	} while(1);
}

/* Modified 4.11.94 JJB */
exec_command()
{
	if(token_type == VARIABLE)
	{
		putback();
		assignment();
	}
	else
		switch(tok)
		{
			case PRINT:
				print();
				break;

			case GOTO:
				exec_goto();
				break;

			case IF:
				exec_if();
				break;

			case FOR:
				exec_for();
				break;

			case NEXT:
				next();
				break;

			case INPUT:
				input();
				break;

			case GOSUB:
				gosub();
				break;

			case RETURN:
				greturn();
				break;

			case END:
			case FINISHED:
				exit(0);
				break;
		}
}

int load_program(char *p, char *fname)
{
	FILE *fp;
	int i = 0;

	if(!(fp = fopen(fname, "r"))) return 0;

	i = 0;
	do
	{
		*p = getc(fp);
		p++; i++;

	} while(!feof(fp) && i < PROG_SIZE);
	fclose(fp);
	return 1;
}

int assignment()
{
	int var, value;

	/* Get the variable name */
	get_token();
	if(!isalpha(*token))
	{
		serror(4);
		return;
	}

	var = toupper(*token) - 'A';

	/* get the = */
	get_token();
	if(*token != '=')
	{
		serror(3);
		return;
	}

	/* get the value */
	get_exp(&value);

	/* assign the var */
	variables[var] = value;
}

int print()
{
	int answer;
	int len=0, spaces;
	char last_delim;

	do
	{
		get_token();	/* get next list item */

		if(token_type == QUOTE)  /* is string */
		{
			printf(token);
			len += strlen(token);
			get_token();
		}
		else /* is expression */
		{
			putback();
			get_exp(&answer);
			get_token();
			len += printf("%d", answer);
		} 

		last_delim = *token;

		if(*token == ',')
		{
			spaces = 8 - (len % 8);
			len += spaces;
			while(spaces)
			{
				printf(" ");
				spaces--;
			}
		}
		else if(*token == ';') /* nothin */ ;
		else break;

	} while(*token == ';' || *token == ',');

	if(last_delim != ';' && last_delim != ',') printf("\n");
}

int scan_labels()
{
	int addr;
	char *temp;

	label_init();
	temp = prog;

	get_token();
	if(token_type ==  NUMBER)
	{
		strcpy(label_table[0].name, token);
		label_table[0].p = prog;
	}

	find_eol();
	do
	{
		get_token();
		if(token_type == NUMBER)
		{
			addr = get_next_label(token);
			if(addr == -1 || addr == -2)
			 	(addr == -1) ? serror(5) : serror(6);

			strcpy(label_table[addr].name, token);
			label_table[addr].p = prog;
		}
		if(tok != EOL) find_eol();
	} while(tok != FINISHED);
	prog = temp;
}

int find_eol()
{
	while(*prog != '\n' && *prog != '\0') ++prog;
/*	if(*prog) prog++;  */
}

int get_next_label(char *s)
{
	register int t;

	for(t = 0; t < NUM_LAB; ++t)
	{
		if(label_table[t].name[0] == 0) return t;
		if(!strcmp(label_table[t].name, s)) return -2;
	}

	return -1;
}

char *find_label(char *s)
{
	register t;

	for(t = 0; t < NUM_LAB; ++t)
		if(!strcmp(label_table[t].name, s)) return label_table[t].p;
	return '\0';
}

int exec_goto()
{
	char *loc;

	get_token();

	loc = find_label(token);
	if(loc == '\0') serror(7);
	else prog = loc;
}

int label_init()
{
	register t;

	for(t = 0; t < NUM_LAB; ++t) label_table[t].name[0] = '\0';
}

int exec_if()
{
	int x, y, cond;
	char op;

	get_exp(&x);

	get_token();
	if(!strchr("=<>", *token))
	{
		serror(0);
		return;
	}
	op = *token;

	get_exp(&y);

	cond = 0;
	switch(op)
	{
		case '<':
			if(x < y) cond = 1;
			break;

		case '>':
			if(x > y) cond = 1;
			break;

		case '=':
			if(x == y) cond = 1;
			break;
	}

	get_token();

	/* Check for THEN statement */
	if(tok != THEN)
	{
		serror(8);
		return;
	}

	if(cond)
	{
		/* Execute until ELSE or end-of-line */
		do
		{
			get_token();
			exec_command();
		} while(tok != ELSE && tok != EOL && tok != FINISHED);

		if(tok == ELSE) find_eol();
	}
	else
	{
		/* Skip ahead until ELSE */
		while(tok != ELSE && tok != EOL)
			get_token();
	}
}

void fpush(struct for_stack i)
{
	if(ftos > FOR_NEST)
		serror(10);

	fstack[ftos] = i;
	ftos++;
}

struct for_stack fpop()
{
	ftos--;
	if(ftos < 0) serror(11);
	return(fstack[ftos]);
}

int exec_for()
{
	struct for_stack i;
	int value;

	get_token(); /* get control var */
	if(!isalpha(*token))
	{
		serror(4);
		return;
	}

	i.var = toupper(*token) - 'A';

	get_token();
	if(*token != '=')
	{
		serror(3);
		return;
	}

	get_exp(&value);

	variables[i.var] = value;

	get_token();

	if(tok != TO) serror(9);
	get_exp(&i.target);

	if(value >= variables[i.var])
	{
		i.loc = prog;
		fpush(i);
	}
	else
		while(tok != NEXT) get_token();
}

int next()
{
	struct for_stack i;

	i = fpop();

	variables[i.var]++;
	if(variables[i.var] > i.target) return;
	fpush(i);
	prog = i.loc;
}

int input()
{
	char str[80], var;
	int i;

	get_token();
	if(token_type == QUOTE)
	{
		printf(token);
		get_token();
		if(*token != ',' && *token != ';') serror(1);
		get_token();
	}
	else printf("? ");
	var = toupper(*token) - 'A';

	scanf("%d", &i);

	variables[var] = i;
}

int gpush(char *s)
{
	gtos++;

	if(gtos == SUB_NEST)
	{
		serror(12);
		return;
	}

	gstack[gtos] = s;
}

char *gpop()
{
	if(gtos == 0)
	{
		serror(13);
		return 0;
	}
	return(gstack[gtos--]);
}

int gosub()
{
	char *loc;

	get_token();

	loc = find_label(token);
	if(loc == '\0')
		serror(7);
	else
	{
		gpush(prog);
		prog = loc;
	}
}

int greturn()
{
	prog = gpop();
}
