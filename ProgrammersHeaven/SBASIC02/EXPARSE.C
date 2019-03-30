/**********************************************************/
/* Recursive descent parser (exparse.c) V0.1		  */
/* Copyright (C) 1994 James J. Bielman   		  */
/* Adapted from _C Power User's Guide_ by Herbert Schildt */
/**********************************************************/
#include<setjmp.h>
#include<math.h>
#include<ctype.h>
#include<stdlib.h>
#include<stdio.h>

#define DELIMITER	1
#define VARIABLE	2
#define NUMBER		3
#define COMMAND		4
#define STRING		5
#define QUOTE		6

#define EOL		9
#define FINISHED	10

extern char *prog;	/* Expression to be analyzed */
extern jmp_buf e_buf;
extern int variables[26];
extern int source_line;

extern struct commands {
	char command[20];
	char tok;
} table[];

extern char token[];	/* Holds string represtation of token */
extern char token_type;
extern char tok;

void get_exp(int *result);
void level2(int *result);
void level3(int *result);
void level4(int *result);
void level5(int *result);
void level6(int *result);
void primitive(int *result);
void arith(char o, int *r, int *h);
void unary(char o, int *r);
void serror(int error); 
void putback();
int  get_token();
int  look_up(char *s);
int  isdelim(char c);
int  iswhite(char c);
int  find_var(char *s);

/* Main entry point into parser */
void get_exp(int *result)
{
	get_token();

	if(!*token)
	{
		serror(2);
		return;
	}
	level2(result);
	putback();
}

/* +- */
void level2(int *result)
{
	register char op;
	int hold;

	level3(result);
	while((op = *token) == '+' || op == '-')
	{
		get_token();
		level3(&hold);
		arith(op, result, &hold);
	}
}

/* /%* */
void level3(int *result)
{
	register char op;
	int hold;

	level4(result);
	while((op = *token) == '*' || op == '/' || op == '%')
	{
		get_token();
		level4(&hold);
		arith(op, result, &hold);
	}
}

void level4(int *result)
{
	int hold;

	level5(result);
	while(*token == '^')
	{
		get_token();
		level4(&hold);
		arith('^', result, &hold);
	}
}

void level5(int *result)
{
	register char op;

	op = 0;
	if((token_type == DELIMITER) && *token == '+' || *token == '-')
	{
		op = *token;
		get_token();
	}
	level6(result);
	if(op) unary(op, result);
}

void level6(int *result)
{
	if((*token == '(') && (token_type == DELIMITER))
	{
		get_token();
		level2(result);
		if(*token != ')')
			serror(1);
		get_token();
	}
	else primitive(result);
}

void primitive(int *result)
{
	switch(token_type)
	{
		case VARIABLE:
			*result = find_var(token);
			get_token();
			return;

		case NUMBER:
			*result = atoi(token);
			get_token();
			return;

		default:
			serror(0);
	}
}

void arith(char o, int *r, int *h)
{
	register int t, ex;

	switch(o)
	{
		case '-':
			*r = *r - *h;
			break;

		case '+':
			*r = *r + *h;
			break;

		case '*':
			*r = *r * *h;
			break;

		case '/':
			*r = (*r) / (*h);
			break;

		case '%':
			t = (*r) / (*h);
			*r = *r - (t * (*h));
			break;

		case '^':
			ex = *r;
			if(*h == 0)
			{
				*r = 1;
				break;
			}
			for(t = *h-1; t > 0; --t) *r = (*r) * ex;
			break;
	}
}

void unary(char o, int *r)
{
	if(o == '-') *r = -(*r);
}

int find_var(char *s)
{
	if(!isalpha(*s))
	{
		serror(4);
		return 0;
	}
	return variables[toupper(*token) - 'A'];
}

void serror(int error)
{
	static char *e[] = {
		"Syntax error",
		"Unbalanced parens",
		"No expression present",
		"Expected: =",
		"Not a variable",
		"Lable table full",
		"Duplicate label",
		"Undefined label",
		"Expected: THEN",
		"Expected: TO",
		"Too many nested FOR loops",
		"NEXT without FOR",
		"Too many nested GOSUBs",
		"RETURN without GOSUB"
	};

	printf("Line %d: %s\n", source_line, e[error]);
	longjmp(e_buf, 1);
}

int get_token()
{
	register char *temp;

	token_type = tok = 0;
	temp = token;
	if(*prog == EOF)
	{
		*token = 0;
		tok = FINISHED;
		return(token_type = DELIMITER);
	}

	while(iswhite(*prog)) prog++;

	if(*prog == '\n')
	{
		prog++;
		source_line++;
		tok = EOL;
		*token = '\n';
		token[1] = 0;
		return(token_type = DELIMITER);
	}

	if(strchr("+-*^/%=;(),<>", *prog))
	{
		*temp = *prog;
		prog++;
		temp++;
		*temp = 0;
		return(token_type = DELIMITER);
	}

	if(*prog == '"')
	{
		prog++;
		while(*prog != '"' && *prog != '\r') *temp++ = *prog++;
		if(*prog == '\n') serror(1);
		prog++;
		*temp = 0;
		return(token_type = QUOTE);
	}

	if(isdigit(*prog))
	{
		while(!isdelim(*prog)) *temp++ = *prog++;
		*temp = 0;
		return(token_type = NUMBER);
	}

	if(isalpha(*prog))
	{
		while(!isdelim(*prog)) *temp++ = *prog++;
		token_type = STRING;
	}

	*temp = '\0';

	if(token_type == STRING)
	{
		tok = look_up(token);
		if(!tok) token_type = VARIABLE;
		else token_type = COMMAND;
	}
	return token_type;
}

void putback()
{
	char *t;

	if(tok == EOL) source_line--;

	t = token;
	for(; *t; t++) prog--;
}

int look_up(char *s)
{
	register i, j;
	char *p;

	p = s;
	while(*p) { *p = tolower(*p); p++; }
	for(i = 0; *table[i].command; i++)
		if(!strcmp(table[i].command, s)) return table[i].tok;
	return 0;
}

int isdelim(char c)
{
	if(strchr(" ;,+-<>/*%^=()", c) || c == 9 || c == '\n' || c == 0)
		return 1;
	return 0;
}

int iswhite(char c)
{
	if(c == ' ' || c == '\t') return 1;
	else return 0;
}
