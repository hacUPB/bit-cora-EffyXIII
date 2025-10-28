# Actividad 2

## Ejemplo 1

### ¿Cómo funciona?

inicializa el shader indicando que nuestro codigo corresponde al uso de la gpu e implementa un codigo sencillo para aparecer un cuadrado del tamaño de la pantalla

### ¿Qué resultados obtuviste?

una pantalla de un color en gradiente 

### ¿Estás usando un vertex shader?

Por supuesto, ya que las formas se realizan a base de vertices

### ¿Estás usando un fragment shader?

Si, ya que esto conecta los vertices para dar forma basada en triangulos y asi hacer visibles las formas

## Ejemplo 2

En el ejemplo 2 podemos ver una malla que ondula constantemente y cambia de color bruscamente con el tiempo, que gira en el eje y con el movimiento del mouse 

En este caso, podemos ver como el color se realiza en la cpu para posteriormente mandarse a la gpu, a diferencia del primer ejemplo

## Ejemplo 3

de igual manera que en el aterior ejemplo, tenemos una malla, pero esta vez no ondula, es completamente estatica, pero al pasar el mouse por encima se deforma formando una semiesfera, tambien dependiendo del posicionamiento del mouse, varia el color de la malla (variando de magenta a azul con el movimiento del eje x) en general, no es muy diferente al ejemplo anterior. podemos resaltar que el efecto borbuja se realiza moviendo el posicionamiento de los vertices en un rango al rededor del mouse segun vemos en el codigo

## Ejemplo 4

Ahora agregamos un nuevo factor, texturas, la textura se desplaza con el movimieno del mouse, y la gpu se encarga de ponerla en el fragment y con los vertices se ubica la posicion de a textura, una forma muy sencilla de generar una figura deseada con menos codigo 

## Ejemplo 5

Muy similar al ejemplo anterior, pues utilizamos la misma textura, pero ahora agregamos una mascara encima para tener una transparencia a nuestra eleccion 

## Ejemplo 6

Bueno, aqui ya suceden muchas cosas. 
- primero tenemos una textura y una mascara generada en rgb
- nos encontramos una nueva funcion <<movie.update();>> la cual nos permite ahora usar video en vez de imagen 
- la mascara se mueve con el mouse en el eje x
- se asocian por asi decirlo a un color de la mascara, una textura

### Resultado
obtenemos una pantalla que varia entre el color negro, la textura y el video segun el movimiento de nuestro mouse, pudiendo tener varios a la vez debido a la mascara rgb