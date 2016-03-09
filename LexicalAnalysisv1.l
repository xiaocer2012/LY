%{
#include <stdio.h> 

#define IF 1
#define ELSE 2
#define WHILE 3
#define RETURN 4
#define INT 5
#define BOOL 6
#define STRUCT 7
#define TRUE 8
#define FALSE 9

#define EQ 10
#define NE 11
#define LT 12
#define GT 13
#define LE 14
#define GE 15

#define LPARENTHESIS 16
#define RPARENTHESIS 17
#define LBRACKET 18
#define RBRACKET 19
#define LBRACE 20
#define RBRACE 21

#define COMMA 22
#define SEMICOLON 23

#define PLUS 24
#define MINUS 25
#define MULTI 26
#define DIVIDE 27
#define MOD 28
#define ASSIGN 29
#define AND 30
#define OR 31
#define NOT 32

#define IDENT 33
#define NUMBER 34
#define WS 35
#define NEWLINE 36
#define ERRORCHAR 37

%}
/*变量*/
ident [A-Za-z][0-9A-Za-z]
/*整型常量*/
number [0-9][0-9]*
delim		[ \t \n]
ws			{delim}+

%s COMMENT1 COMMENT2
%%
<INITIAL>"/*"						{BEGIN COMMENT1;}
<COMMENT1>"*/"						{BEGIN INITIAL;}
<COMMENT1>.|\n                    {;}
<INITIAL>"//"           {BEGIN COMMENT2;}
<COMMENT2>\n             {BEGIN INITIAL;}
<COMMENT2>.|\n                    {;}
 /* ECHO是一个宏，相当于 fprintf(yyout, "%s", yytext)*/
<INITIAL>{ws}	                     {return WS;}

<INITIAL>"if"	                  {return (IF);}
<INITIAL>"else"		          {return (ELSE);}
<INITIAL>"while"				{return (WHILE);}
<INITIAL>"struct"	          {return (STRUCT);}
<INITIAL>"int"	              {return (INT);}
<INITIAL>"bool"	              {return (BOOL);}
<INITIAL>"true"         {return (TRUE);}
<INITIAL>"false"         {return (FALSE);}

<INITIAL>{ident}	              {return (IDENT);}
<INITIAL>{number}	          {return (INT);}

<INITIAL>"<"	          {return (LT);}
<INITIAL>">"              {return (GT);}
<INITIAL>"<="	          {return (LE);}
<INITIAL>">="	          {return (GE);}
<INITIAL>"=="	          {return (EQ);}
<INITIAL>"!="	          {return (NE);}


<INITIAL>"="	          {return (ASSIGN);}
<INITIAL>"+"	          {return (PLUS);}
<INITIAL>"-"	          {return (MINUS);}
<INITIAL>"*"	          {return (MULTI);}
<INITIAL>"/"	          {return (DIVIDE);}
<INITIAL>"%"              {return (MOD);}
<INITIAL>"&&"	          {return (AND);}
<INITIAL>"||"	          {return (OR);}
<INITIAL>"!"              {return (NOT);}


<INITIAL>";"	          {return (SEMICOLON);}
<INITIAL>","	          {return (COMMA);}

<INITIAL>"("	          {return (LPARENTHESIS);}
<INITIAL>")"	          {return (RPARENTHESIS);}
<INITIAL>"["	          {return (LBRACKET);}
<INITIAL>"]"	          {return (RBRACKET);}
<INITIAL>"{"	          {return (LBRACE);}
<INITIAL>"}"	          {return (RBRACE);}


<INITIAL>.				  {return ERRORCHAR;}
%%

int yywrap (){
  return 1;
}

void writeout(int c){
  switch(c){
  	case ERRORCHAR: fprintf(yyout, "(ERRORCHAR, \"%s\") ", yytext);break;
  
    case IF: fprintf(yyout, "(IF, \"%s\") ", yytext);break;
	case ELSE: fprintf(yyout, "(ELSE, \"%s\") ", yytext);break;	
	case WHILE: fprintf(yyout, "(WHILE, \"%s\") ", yytext);break;
	case STRUCT: fprintf(yyout, "(STRUCT, \"%s\") ", yytext);break;
	case INT: fprintf(yyout, "(INT, \"%s\") ", yytext);break;
	case BOOL: fprintf(yyout, "(BOOL, \"%s\") ", yytext);break;
	case RETURN: fprintf(yyout, "(RETURN, \"%s\") ", yytext);break;
	case TRUE: fprintf(yyout, "(TRUE, \"%s\") ", yytext);break;
	case FALSE: fprintf(yyout, "(FALSE, \"%s\") ", yytext);break;  
	
	case LT: fprintf(yyout, "(LT, \"%s\") ", yytext);break;  
    case GT: fprintf(yyout, "(GT, \"%s\") ", yytext);break;  
    case LE: fprintf(yyout, "(LE, \"%s\") ", yytext);break; 
    case GE: fprintf(yyout, "(GE, \"%s\") ", yytext);break; 
    case EQ: fprintf(yyout, "(EQ, \"%s\") ", yytext);break;   	
	case NE: fprintf(yyout, "(NE, \"%s\") ", yytext);break;  
	
	case LPARENTHESIS: fprintf(yyout, "(LPARENTHESIS, \"%s\") ", yytext);break;  
	case RPARENTHESIS: fprintf(yyout, "(RPARENTHESIS, \"%s\") ", yytext);break;  
	case LBRACKET: fprintf(yyout, "(LBRACKET, \"%s\") ", yytext);break;  
	case RBRACKET: fprintf(yyout, "(RBRACKET, \"%s\") ", yytext);break;  
	case LBRACE: fprintf(yyout, "(LBRACE, \"%s\") ", yytext);break;  
	case RBRACE: fprintf(yyout, "(RBRACE, \"%s\") ", yytext);break;  
	
	case COMMA: fprintf(yyout, "(COMMA, \"%s\") ", yytext);break;  
	case SEMICOLON: fprintf(yyout, "(SEMICOLON, \"%s\") ", yytext);break;  
	case PLUS: fprintf(yyout, "(PLUS, \"%s\") ", yytext);break;  
	case MINUS: fprintf(yyout, "(MINUS, \"%s\") ", yytext);break;  
	case MULTI: fprintf(yyout, "(MULTI, \"%s\") ", yytext);break;
	case DIVIDE: fprintf(yyout, "(DIVIDE, \"%s\") ", yytext);break;  
	case MOD: fprintf(yyout, "(MOD, \"%s\") ", yytext);break;
	case ASSIGN: fprintf(yyout, "(ASSIGN, \"%s\") ", yytext);break;
	case AND: fprintf(yyout, "(AND, \"%s\") ", yytext);break;
	case OR: fprintf(yyout, "(OR, \"%s\") ", yytext);break;
	case NOT: fprintf(yyout, "(NOT, \"%s\") ", yytext);break;
    
	case IDENT: fprintf(yyout, "(IDENT, \"%s\") ", yytext);break;
	case NUMBER: fprintf(yyout, "(NUMBER, \"%s\") ", yytext);break;
	
	case WS     : fprintf(yyout," ",yytext);break;
    case NEWLINE: fprintf(yyout, "");break;
    
    default:break;
  }
  return;
}


int main (int argc, char ** argv){
	int c,j=0;
	if (argc>=2){
	  if ((yyin = fopen(argv[1], "r")) == NULL){
	    printf("Can't open file %s\n", argv[1]);
	    return 1;
	  }
	  if (argc>=3){
	    yyout=fopen(argv[2], "w");
	  }
	}

	while (c = yylex()){
		writeout(c);
		j++;
		if (j%5 == 0) writeout(NEWLINE);
	}
	if(argc>=2){
	  fclose(yyin);
	  if (argc>=3) fclose(yyout);
	}
	return 0;
}
