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
instr: instr NUM ;
instr: instr ID ;
instr: instr '[''[' expr ']'']' | ;
expr: term 
	| term MAS expr
	| term MENOS expr
	| term POR expr;
term:  '[' expr ']' 
	|  '(' expr ')'
	|  val ;
val: NUM | ID ;
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
		if(c=='+') return MAS;
		if(c=='-') return MENOS;
		if(c=='X'|| c=='x') return POR;
		if(isalpha(c)){
				int i=0;
			do{
				lexema[i++]=c;
				c=getchar();
				}while(isalnum(c)&& c!='x');
			
			ungetc(c,stdin);
		lexema[i]==0;
		return ID;
		}
			
		if(isdigit(c)|| c=='-'){
			int i=0;
			do{
				lexema[i++]=c;
				c=getchar();
			}while(isdigit(c) || c=='.');
			
			ungetc(c,stdin);
			lexema[i]=0;
			return NUM;
		
		}
	
		
		
		
		return c;
	}
	
}


int main(void){
//lamar al scaner o analizador lexico esto lo inicia el parser o analizador sintactico (yyparse)	
	return yyparse();
}

