¿como se gestionan las variables de una aplicacion en c++ en cuanto a la memoria ram?
R/depende de como y donde se declaran, y son 
1. stack o pila
-Locales
2. heap o monticulo
-Asignadas dinamicamente
3. Data segment (Static)
-Globales 

Actividad #1
-no pude hacerla ya que generaba multiples errores que no encontre manera de solucionar, en su mayoria externos (por algun motivo) como falta de librerias y cosas raras, asi que proseguire con la actividad 2, la cual si funciona

Actividad #2 y #3
-Modificamos el archivo ofApp.h con el siguiente codigo

![alt text](<Captura de pantalla 2025-08-21 090526.png>)

y el ofApp.cpp con este

![alt text](<Captura de pantalla 2025-08-21 090826.png>)

Al ejecutar el programa, podemos observar a primera vista como se forma una linea en base a circulos por donde pasa el mouse, pero al analizar el codigo en el .h note que habia deteccion de el click del mouse, al usarlo se ve como se dejan de generar circulos (mientras mantenemos apretado) y como los circulos ya presesntes hasta ese momento + los nuevos que se generen una vez soltado el click, cambian su color como se muestra a continuacion

<video controls src="prueba de programa.mp4" title="Title"></video>

en la funcion set up podemos ver una linea que corresponde al fondo y una que asigna color blanco a una variable llamada particlecolor, podemos asumir que se trata del color de los circulos (en la funcion mousePressed se ve como se modifica este color, igual que al ejecutar el programa)
la funcion update no posee ninguna linea de codigo, asi que presumiblemente no hace nada y la funcion draw se encarga de hacer aparecer un circulo tras verificar el color de particleColor
luego tenemos la funcion mouseMoved, la cual asiga un valor a las variables [x] y [y] basadas en la posicion del mouse, luego revisa el numero de esferas totales en patalla, si este es mayor que 100, borra el primer circulo manteniendo limitado el numero de circulos en pantalla

Actividad #4

era ver videos :P

Actividad #5

R/es una variable que almacena la dirección de memoria de otra variable. Es decir, en lugar de guardar directamente un valor (como un número o una letra), un puntero guarda la ubicación donde ese valor se encuentra en la memoria. esta ubicado dentro de ofApp 

![alt text](<Captura de pantalla 2025-08-26 084236.png>)

y mantiene guardada las caracteristicas de cada circulo creada para modificarlas activamente sin tener que duplicarlas

Actividad #6

al clickear y mover un circulo este se queda aderido al mouse y no hay forma de soltarlo, habria que crear una funcion extra que se enfoque en detectar cuando el click del mouse se deja de oprimir y que deje el circulo en esas cordenadas x,y

Actividad #7

al iniciar el programa solo podemos ver una pantalla en negro, si apretamos la letra c aparecera el siguiente mensaje

![alt text](<Captura de pantalla 2025-08-26 090656.png>)

en el cual vemos que se guarda la posicion en la cual el mouse estaba al momento de apretar el boton.

al modificar nuevamente el codigo, agregando arreglos en la funcion createObjectInStack, descubrimos que no guarda las cordenadas del mouse si no que realmente, selecciona unas coordenadas aleatorias para, ahora modificado, crear un circulo en esa posicion. y nos ayuda a entender porque anteriormente no aparecia el circulo, eso se debia que estaba declarado como una variable local, al hacer esto, cuando pasabamos a la funcion draw, la variable se destruia, por tanrto no habia informacion para construir el circulo