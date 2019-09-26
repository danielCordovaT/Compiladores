%{
	#include<stdio.h>
	#include<string.h>
	char lexema[255];
	void yyerror(char *);
	int yylex();
%}

//token
%token ID NUM  PUNTCOM INICIO FIN MENOS MAS IGUAL 
//producciones 

%%
listainstr: listainstr instr| ;
instr: ID ':' IGUAL expr PUNTCOM;
expr: expr MAS term | term | expr MENOS term ;
term: term '*' fact;
term: term '/' fact;
term: fact;
fact:NUM|ID;

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
		if(c==';') return PUNTCOM;
		if(c=='=') return IGUAL;
		if(c=='-') return MENOS;
		if(c=='+') return MAS;
		if(c==' ') continue;
		//if(isalnum(c)) continue;
		if(isalpha(c)){
				int i=0;
			do{
				lexema[i++]=c;
				c=getchar();
				}while(isalnum(c));
			
			ungetc(c,stdin);
		lexema[i]==0;
		if(strcasecmp(lexema,"INICIO")==0) return INICIO;
		if(strcasecmp(lexema,"FIN")==0) return FIN;
		//patron de id letra seguido de letra  o numero
		return ID;
		}
			
	
		if(c=='-'){
			int i=0;
			do{
				lexema[i++]=c;
				c=getchar();
			}while(isdigit(c)|| c=='.');
			
			ungetc(c,stdin);
			lexema[i]=0;
			return NUM;

		}
		if(isdigit(c)){
			int i=0;
			do{
				lexema[i++]=c;
				c=getchar();
			}while(isdigit(c));
			
			ungetc(c,stdin);
			lexema[i]=0;
			return NUM;
		
		}
		
		
		
		return c;
	}
}


int main(){
//lamar al scaner o analizador lexico esto lo inicia el parser o analizador sintactico (yyparse)	
	if(!yyparse()) printf("cadena valida \n");
	else printf("cadena  invalida \n");
	return 0;
}
