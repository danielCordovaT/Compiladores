%{
	#include<stdio.h>
	#include<string.h>
	char lexema[255];
	void yyerror(char *);
	int yylex();
%}

%token ID NUM HEXA PUNTCOM
//producciones 

%%
instruccion: instruccion ID ;
instruccion: instruccion NUM ;
instruccion: instruccion ID '=' term PUNTCOM | ;
term: factor '+' factor | factor ;
factor : ID|NUM;
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
		if(c==' ') continue;
	    if(isalpha(c)){
				int i=0;
			do{
				lexema[i++]=c;
				c=getchar();
				}while(isalnum(c));
			
			ungetc(c,stdin);
		lexema[i]==0;
		//if(strcasecmp(lexema,"INICIO")==0) return INICIO;
		//if(strcasecmp(lexema,"FIN")==0) return FIN;
		//patron de id letra seguido de letra  o numero
		return ID;
		}
			
	
		if(c=='-') continue;
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
        //  numeros  HEXADECIMALES
        if(c=='-') continue;
        if(isalpha(c)|isdigit(c)){
            char hex[]={'A','B','C','D','E','F'};
            int i=0;
            int j=0;
            do{
                c=getchar();
            for(i=0;i<6;i++){
                if(c==hex[i]){
                    lexema[j++]=c;
                }else if(c!=hex[i]){
                    flg=1;
                }}
            if(isdigit(c)){
                lexema[j++]=c;
                flg=0;
                }
            
            
            }while(flg!=1);


            ungetc(c,stdin);
            lexema[i]=0;
            return HEXA;
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
