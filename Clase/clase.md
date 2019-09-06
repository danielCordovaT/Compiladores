## Gramatica 

Poder diferenciar la estructura del lenguaje 

~~~
%%

    GRAMATICA

%%
~~~


Esta compuesta por :

* Raiz(inicio del arbol)

* No terminales(nodo interno)

* terminales(hojas)

* Producciones


        P->Q


| Patron  | Lexema |Token |
| ------- | ------ | ---- |
| Strings | 4abc,la | codigo |
| Palabra Reservada|begin if end | Pres      |
|  :=   |  :=   | Igual     |
| letra|   x,y,z | ID |
| ; | ; | ; |


Analizador lexico o escaner   idetifica los  tokens  y lo comunica la analizador sintactico

por ejemplo si deseamos que la cadena :

-------------
    x:=59; 
-------------

sea valida,la produccion sera 

instruccion -> instruccion ID IGUAL NUM PUNTCOM

