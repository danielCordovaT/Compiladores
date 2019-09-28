%{
	#include<stdio.h>
	#include<string.h>
	#define YYSTYPE double 
	char lexema[255];
	void yyerror(char *);
	int yylex();
%}

//token
%token  NUMBER  
//producciones 

%%
prog: expr '\n' prog { printf("VALOR %g\n",$1); };
prog:   ;

expr: expr '+' term   { $$ = $1 + $3; }
    | expr '-' term   { $$ = $1 - $3; }
    | term 
    ;
  

term:   term '*' factor  {$$ =$1 * $3;} 
      | term '/' factor  {$$ =$1 / $3;}
      | factor 
      ;
        
factor: '(' expr ')'   { $$= $2 ;}
      | '-' factor     {$$= (-1)*$2;}
      | NUMBER
      ;

%%


void yyerror(char *mgs){
	printf("error:%s",mgs);
}

//analizador lexico
int yylex(){
	double t;
	int c;
	while((c=getchar())==' ');
	if(isdigit(c)){
	    ungetc(c,stdin);
	    scanf("%lf",&t); yylval=t;//pasando valor a la pila
	    return NUMBER; 
    }
	
		
	return c;
	
}


int main(void){
//lamar al scaner o analizador lexico esto lo inicia el parser o analizador sintactico (yyparse)	
	return yyparse();
}
