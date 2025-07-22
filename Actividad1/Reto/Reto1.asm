//Carga en D el valor 1978.
@1978
D=A

//Guarda en la posición 100 de la RAM el número 69.
@69
D=A
@100
M=D

//Guarda en la posición 200 de la RAM el contenido de la posición 24 de la RAM
@24
//Agregare un valor a la casilla 24 ya que por defecto tiene 0 
M=123
D=M
@200
M=D