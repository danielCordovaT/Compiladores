%{
	#include<stdio.h>
	#include<string.h>
	#define YYSTYPE double 
	char lexema[255];
	void yyerror(char *);
	int yylex();
%}

//token
%token  NUM  MATRIZ
//producciones 

%%
instr: instr NUM | ;
instr: instr MATRIZ ;
 
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
		if(c=='('){
			int i=0;
			int d1=0;
			int a1=0;
			int d2=0;
			int f1=0;
			int f2=0;
			lexema[i++]=c;
			//se agrega  '('
			do{
				
				c=getchar();
				a1++;
				if(c==';'&& f1==0){
					f1++;
					lexema[i++]=c;
					d1=a1;
					a1=0;
				
				}
				if(c==','){
					lexema[i++]=c;
				}
				if(c==')'){
					lexema[i++]=c;
					d2= a1;
					if(d2!=d1){
						f2=1;
					}
				}
				if(isdigit(c)){
					lexema[i++]=c;
				}
			}while(isdigit(c)|| c==',' || c==';' ||c==')' && f1 <= 1 && f2==0);
		
			ungetc(c,stdin);
			lexema[i]=0;
			return MATRIZ;
		}
		
		
		
		
		
		return c;
	}
	
}


int main(void){
//lamar al scaner o analizador lexico esto lo inicia el parser o analizador sintactico (yyparse)	
	return yyparse();
}

