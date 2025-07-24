//Si el valor almacenado en la posición 100 de la RAM es menor a 100 salta a la posición 20 de la ROM.
@100
//comprobe que funciona asi que agregare el valor 100 para que NO realice el salto
M=A
D=A
D=D-M
@20
D;JGT

//8. Considera el siguiente programa:
    
    @var1
    D=M
    @var2
    D=D+M
    @var3
    M=D
    
    //- ¿Qué hace este programa?
    //R/Suma los valores de la variable 1 y 2 y los almacena en la variable 3
    //- En qué posición de la memoria está `var1`, `var2` y `var3`? ¿Por qué en esas posiciones?
    //R/16, 17 y 18 porque las direcciones 0–15 están reservadas para registros predefinidos

