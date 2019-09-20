## Ambiguedad

la gramatica es ambigua  cuando una entrada genera 2 o mas arboles diferentes.

Debemos generar gramaticas no ambiguas.

### Precedencia de operadores 

la gramatica debe debe ser construida respetando la precedencia de los operadores.

eje:

lista -> lista + NUM 
lista -> NUM

Entrada: 2+3+8+1

Arbol 


                    lista
                   /      \
               lista   +   NUM
              /     \ 
            lista + NUM
           /     \
        lista +  NUM
          |
         NUM


Si extendemos :

lista -> lista + term 
lista -> term 

term -> term x NUM
term -> NUM

entrada:

2+5*8

arbol 

                lista
               /      \  
            lista +   term
             |        /   \
            term    term * NUM
             |        |  
            NUM      NUM

tambien tenemos :

( 4 * 2 / 5  )  tienen la misma procedencia  
 --> 
           <--
( 4 - 2 + 3 ) tienen la misma  procedencia 


-> 

+,- misma procedencia 

/,* misma procedencia 

lista -> lista  +  term 
lista -> lista  -  term 

lista -> term 

term -> term * NUM
term -> term / NUM

term -> NUM



