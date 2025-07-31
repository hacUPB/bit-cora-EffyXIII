//5. Traduce este programa a lenguaje ensamblador:
//int a = 10;
//int *p;
//p = &a;
//*p = 20;

//Creamos variable "var"
@10
D=A 
@var
M=D

//creamos el puntero y lo vinculamos a la posicion de "var"
@var
D=A
@punt
M=D

//utilizamos el puntero para acceder a la posicion de "var" y modificar su valor
@20
D=A
@punt
A=M
M=D


//6. Ahora vas a usar un puntero para leer la posición de memoria a la que este apunta
//es decir, vas a leer por medio del puntero la variable cuya dirección está almacenada en él.
@punt 
D=M
