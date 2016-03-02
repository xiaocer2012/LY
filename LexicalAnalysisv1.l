%{
#include <stdio.h> 
#define IF 1
#define WHILE 2
#define RETURN 3 
#define IDENT 4 
#define TRUE 5 
#define FALSE 6 
#define UNOP 7
#define BIOP 8
/*小括号*/
#define SKUOHAO 9
/*中括号*/
#define MKUOHAO 10
/*大括号*/
#define LKUOHAO 11
/*结构体 STRUCT*/
#define STRUCT 12
#define DOUHAO 13
#define DIANHAO 14
#define FENHAO 15
#define INT  16
#define INTCONST 17
#define RELOP 18
#define BOOL 19
#define DO 20
#define ELSE 21
#define WS 22
#define NEWLINE            23
#define ERRORCHAR         24
%}
/*变量*/
ident [A-Za-z][0-9A-Za-z]
/*整型常量*/
int [0-9][0-9]*
unop [-|!]
biop [+ | - | * | / | % | < | <= | >= | > | == | != | && | \|\|]


delim		[ \t \n]
ws			{delim}+
letter	    [A-Za-z]
digit		     [0-9]
id			[A-Za-z][0-9A-Za-z]*
number	{digit}+(\.{digit}+)?(E[+-]?{digit}+)?

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


<INITIAL>"while"				{return (WHILE);}
<INITIAL>"do"		                {return (DO);}
<INITIAL>"if"	                  {return (IF);}
<INITIAL>"else"		          {return (ELSE);}
<INITIAL>"struct"	          {return (STRUCT);}
<INITIAL>"int"	              {return (INT);}
<INITIAL>"bool"	              {return (BOOL);}

<INITIAL>{id}	              {return (IDENT);}
<INITIAL>{number}	          {return (INTCONST);}

<INITIAL>"<"	          {return (RELOP);}
<INITIAL>"<="	          {return (RELOP);}
<INITIAL>">"	          {return (RELOP);}
<INITIAL>">="	          {return (RELOP);}
<INITIAL>"=="	          {return (RELOP);}
<INITIAL>"!="	          {return (RELOP);}
<INITIAL>"&&"	          {return (RELOP);}
<INITIAL>"||"	          {return (RELOP);}

<INITIAL>"="	          {return (RELOP);}

<INITIAL>"+"	          {return (RELOP);}
<INITIAL>"-"	          {return (RELOP);}
<INITIAL>"*"	          {return (RELOP);}
<INITIAL>"/"	          {return (RELOP);}
<INITIAL>"%"


<INITIAL>";"	          {return (RELOP);}
<INITIAL>"."	          {return (RELOP);}
<INITIAL>","	          {return (RELOP);}

<INITIAL>"("	          {return (RELOP);}
<INITIAL>")"	          {return (RELOP);}
<INITIAL>"["	          {return (RELOP);}
<INITIAL>"]"	          {return (RELOP);}
<INITIAL>"{"	          {return (RELOP);}
<INITIAL>"}"	          {return (RELOP);}


<INITIAL>.				  {return ERRORCHAR;}
%%

int yywrap (){
  return 1;
}

void writeout(int c){
  switch(c){
  	case ERRORCHAR: fprintf(yyout, "(ERRORCHAR, \"%s\") ", yytext);break;
  	case RELOP: fprintf(yyout, "(RELOP, \"%s\") ", yytext);break;  
	
    case WHILE: fprintf(yyout, "(WHILE, \"%s\") ", yytext);break;
    case DO: fprintf(yyout, "(DO, \"%s\") ", yytext);break;
	case IF: fprintf(yyout, "(IF, \"%s\") ", yytext);break;
	case ELSE: fprintf(yyout, "(ELSE, \"%s\") ", yytext);break;	
	case STRUCT: fprintf(yyout, "(STRUCT, \"%s\") ", yytext);break;
	case INT: fprintf(yyout, "(INT, \"%s\") ", yytext);break;
	case BOOL: fprintf(yyout, "(BOOL, \"%s\") ", yytext);break;
	
	case IDENT: fprintf(yyout, "(IDENT, \"%s\") ", yytext);break;
	case INTCONST: fprintf(yyout, "(INTCONST, \"%s\") ", yytext);break;
	
	
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
