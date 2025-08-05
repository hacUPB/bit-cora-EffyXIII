//7.Traduce este programa a lenguaje ensamblador:
//int var = 10;
//int bis = 5;
//int *p_var;
//p_var = &var;
//bis = *p_var;

//Creamos variable "var"
@10
D=A 
@var
M=D

//Creamos variable "bis"
@5
D=A 
@bis
M=D

//creamos el puntero y lo vinculamos a la posicion de "var"
@var
D=A
@p_var
M=D

//guardamos el contenido de var en bis
@p_var
A=M
D=M
@bis
M=D

//8. Vas a parar un momento y tratarás de recodar de memoria lo siguiente. Luego verifica con un compañero o con el profesor.
//    1. ¿Qué hace esto `int *pvar;`?
//    2. ¿Qué hace esto `pvar = var;`?
//    3. ¿Qué hace esto `var2 = *pvar`?
//    4. ¿Qué hace esto `pvar = &var3`?

//R)