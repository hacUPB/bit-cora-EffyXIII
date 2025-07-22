//1. Carga en D el valor 1978.
@1978
D=A

//2. Guarda en la posición 100 de la RAM el número 69.
@69
D=A
@100
M=D

//3. Guarda en la posición 200 de la RAM el contenido de la posición 24 de la RAM
//Agregare un valor a la casilla 24 ya que por defecto tiene 0 
@123
D=A
@24
M=D
//Reiniciamos el valor de D
D=0
//Copiamos el valor de RAM24 en 200
D=M
@200
M=D

//4. Lee lo que hay en la posición 100 de la RAM, resta 15 y guarda el resultado en la posición 100 de la RAM.

//como ya existe un valor en 100 por el punto 2, no debemos agregarlo
@100
D=M
@15
D=D-A
@100  //Volvemos a 100 para guardar el resulto
M=D

//5. Suma el contenido de la posición 0 de la RAM, el contenido de la posición 1 de la RAM
// y con la constante 69. Guarda el resultado en la posición 2 de la RAM.

//Como no hay valores en 0 ni 1, loa agregamos
@100
D=A
@0
M=D
@10
D=A
@1
M=D
D=0 //Reiniciamos el valor de D para iniciar el punto desde 0
//sumamos los contenidos de 0 y 1
@0
M=D
@1
D=D+M
//sumamos 69
@69
D=D+A
//Almacenamos en 2
@2
M=D

//6. Si el valor almacenado en D es igual a 0 salta a la posición 100 de la ROM.