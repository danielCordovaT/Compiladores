%{
#include<stdio.h>
#include<string.h>

char lexema[255];
void yyerror(char *);

%}

%token ID NUM ENTER COM IF IFELSE WHILE FOR DEF SUM RES MUL DIV AND OR POW PROG VARS ELSE OTHERCASE DESDE HASTA INCREMENTANDO

%%
raiz_prog: PROG ID '{' raiz '}' ;

raiz: raiz lista | ;

listas: lista listas | lista;

lista: expresion | exp ';' | ENTER ;

exp: VARS mult_asignar | asignar | call ;

mult_asignar: asignar COM mult_asignar | asignar ;

asignar: ID '=' exp1 ;

call: ID '(' llamados ')' ;

llamados: elemento COM llamados | elemento | call COM llamados | call | ;

elemento: ID | NUM | RES NUM ;

expresion: cond_if_else | while_bucle | for_bucle | funcion ;

argumento: comparaciones | '!' comparaciones ;

cond_if_else: IF '(' argumento ')' '{' listas '}' | IF '(' argumento ')' '{' listas '}' add_else ;

add_else: ELSE '{' listas '}' | ELSE '(' argumento ')' '{' listas '}' caso_defecto ;

caso_defecto: OTHERCASE '{' listas '}' ;

while_bucle: WHILE '(' argumento ')' '{' listas '}' ;

for_bucle: FOR '(' DESDE asignar ';' HASTA argumento ';' INCREMENTANDO asignar ')' '{' listas '}';

funcion: DEF ID '(' llamados ')' '{' listas '}' ;

exp1: exp1 operador1 exp2 | exp2 ;

exp2: exp2 operador2 elemento | exp2 operador2 call | elemento | call ;

comparar: exp1 operador3 comparar | exp1 ;

comparaciones: '(' comparar ')' operador3 '(' comparaciones ')' | comparar ;

operador1: SUM | RES ;

operador2: MUL | DIV | POW ;

operador3: '=''=' | '!''=' | '<' | '>' | '<''=' | '>''=' | AND | OR ;

%%

void yyerror(char *msg){
	printf("error: %s", msg);
}

int palabra_reservada(char lexema[])
{

	if(strcasecmp(lexema,"si")==0) return IF;
	if(strcasecmp(lexema,"sino")==0) return ELSE;
	if(strcasecmp(lexema,"otrocaso")==0) return OTHERCASE;
	if(strcasecmp(lexema,"ifelse")==0) return IFELSE;
	if(strcasecmp(lexema,"while")==0) return WHILE;
	if(strcasecmp(lexema,"for")==0) return FOR;
	if(strcasecmp(lexema,"def")==0) return DEF;
	if(strcasecmp(lexema,"Programa")==0) return PROG;
	if(strcasecmp(lexema,"Vars")==0) return VARS;
	if(strcasecmp(lexema,"from")==0) return DESDE;
	if(strcasecmp(lexema,"until")==0) return HASTA;
	if(strcasecmp(lexema,"increase")==0) return INCREMENTANDO;
	return ID;
}

int yylex(){
	char c;
	while(1){
		c = getchar();
		if (isspace(c)) continue;
		if (c == '\t') continue;
		if (c == ',') return COM;
		if (c == '&') return AND;
		if (c == '|') return OR;
		if (c == '\n') return ENTER;
		if (c == '+') return SUM;
		if (c == '-') return RES;
		if (c == '*') return MUL;
		if (c == '/') return DIV;
		if (c == '^') return POW;


		if(isalpha(c)){
			int i = 0;
			do{
				lexema[i++]=c;
				c=getchar();
			}while(isalnum(c));

			ungetc(c, stdin);
			lexema[i] = 0;
			return palabra_reservada(lexema);
		}


		
		if (isdigit(c)){
			int flag = 0;
			int decimal = 0;
			int i = 0;
			do{
				if (flag){decimal = 1;}
				lexema[i++]=c;
				c=getchar();
				if( c == '.' || c == 'e' || c == 'E' ){decimal = 1;}
			}while((isdigit(c)) || (( c == '.' || c == 'e' || c == 'E' )&&(!decimal)));

			ungetc(c, stdin);
			lexema[i] = 0;
			return NUM;
		}
		return c;
	}
}

int main(){
	if (!yyparse()) printf("cadena vàlida \n");
	else printf(" cadena invàlida");
	return 0;
}


/*
Ejemplos
programa prueba
{
    vars x1 = 4, x2 = 13;
    si( x1 > x2 )
    {
        tmp = x2;
    }
    sino
    {
        tmp = x1;
    }
}

==========================================================================================================================0

programa function
{
    vars x1 = -3, x2 = -12;
    def funcionsuma ( x1 , x2 )
    {
        x1 = x1 + x2 ;
    }
}


==========================================================================================================================0

programa inicio
{
	x = 12;

	y = 14;
	z = 20;
	while ( z < 23 )
	{
		si ( z < y )
		{
			for ( from i = 2 ; until i < 10 ; increase i = 2 )
			{
			    x = x + 1;
            }
        }
        sino
        {
            x = y + z;
        }
    }
    def suma( x , y )
    {
        aux = x + y;
    }
    sum = suma( x , y );
}
    


        
        
			
			
*/
