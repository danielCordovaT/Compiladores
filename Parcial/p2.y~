%{
	#include<stdio.h>
	#include<string.h>
	#define YYSTYPE double 
	char lexema[255];
	void yyerror(char *);
	int yylex();
%}

//token
%token  A B
//producciones 

%%
seq: seq val | val;
val: A | B;
%%


void yyerror(char *mgs){
	printf("error:%s",mgs);
}

//analizador lexico
int yylex(){
	char c;
	int flg=0;
	while(1){
		c=getchar();
		if(c=='\n') continue;
		if(isspace(c)) continue;
	
		if(c==' ') continue;
		//if(isalnum(c)) continue;
		if(c=='a') return A;
		if(c=='b') return B;
		
		
		return c;
	}
	
}


int main(void){
//lamar al scaner o analizador lexico esto lo inicia el parser o analizador sintactico (yyparse)	
	return yyparse();
}

	
		
