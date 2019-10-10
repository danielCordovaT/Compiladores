%{
	#include<stdio.h>
	#include<string.h>
	#define YYSTYPE double 
	char lexema[255];
	void yyerror(char *);
	int yylex();
%}

//token
%token  NUM  ID POR MAS MENOS
//producciones 

%%
instr: instr NUM | ;
%%


void yyerror(char *mgs){
	printf("error:%s",mgs);
}

//analizador lexico
int yylex(){
	char c;
	while(1){
		c=getchar();
		if(c=='\n') continue;
		if(isspace(c)) continue;
		if(c==' ') continue;
		if(isdigit(c)){
			int i=0;
			if(c < 8 ){
				do{
					lexema[i++]=c;
					c=getchar();
				}while(isdigit(c)&&c<8);
				ungetc(c,stdin);
			lexema[i]=0;
			return NUM;
			}
			
			
		
		}
	
		
		
		
		return c;
	}
	
}


int main(void){
//lamar al scaner o analizador lexico esto lo inicia el parser o analizador sintactico (yyparse)	
	return yyparse();
}

