Sesion 1

La clase particula representa un objeto en un plano 2d con informacion de su posicion "x, y" y el cambio en esta "dx, dy"

Un objeto es una instancia real de una clase. Si la clase es el plano o la receta, el objeto es el resultado concreto.

el metodo cambia o modifica los atributos del objeto que lo llama 

Preguntas

¿Cómo se almacenan los objetos?	Depende de dónde se crean: stack, heap o segmento de datos. Sus atributos se almacenan directamente en la memoria del objeto.


¿Dos instancias tienen relación en memoria?	Si están en el mismo bloque (como el stack), pueden estar una junto a la otra, pero son completamente independientes.

¿Los atributos de un objeto están contiguos? Sí, por lo general están contiguos y en orden, salvo que haya padding por alineación (más común con char, double, etc.).

¿Los métodos ocupan espacio en el objeto? No. Están definidos aparte. Todos los objetos comparten la misma implementación del método.

Variables static no incrementan el tamaño de cada objeto, ya que no forman parte del objeto. Son globales para la clase.

Variables dinámicas (punteros) sí afectan el tamaño del objeto, pero solo por el puntero. La memoria real que usan se encuentra fuera del objeto, en el heap.

Sesion 2

Cuando defines una clase en C++, los atributos (variables miembro no estáticas) de cada objeto se almacenan en la memoria del propio objeto.

Si el objeto es creado en el stack (ejemplo: MiClase obj;), los atributos viven en el stack.

Si el objeto es creado en el heap (ejemplo: new MiClase();), los atributos viven en el heap.

¿Qué es la vtable?

Es una tabla de punteros a funciones generada por el compilador.

Cada clase con métodos virtuales tiene su propia vtable.

Contiene las direcciones de las funciones virtuales que corresponden a esa clase.
Cuando llamas a un método virtual mediante un puntero o referencia a la clase base, el programa:

Sigue el vptr del objeto.

Consulta en la vtable la dirección real del método.

Ejecuta el método correcto (el de la clase base o el sobreescrito en la derivada).

Los métodos virtuales se implementan con una tabla de punteros a funciones (vtable).

Cada objeto de una clase con virtuales tiene un puntero oculto (vptr) a la vtable de su clase real.

En tiempo de ejecución, el programa sigue el vptr, consulta la vtable y ejecuta el método adecuado.

Esto permite el polimorfismo dinámico.

-el puntero a funcion se diferencia del puntero a metodo en que no requiere de un objeto y es de rendimiento rapido

Sesion 3

El compilador implementa el encapsulamiento impidiendo accesos ilegales en tiempo de compilación, no alterando la disposición en memoria. Los miembros privados siguen estando allí, pero el compilador actúa como guardián.

Entonces, ¿qué es el encapsulamiento en C++?

Es un contrato entre programador y compilador:

Privado (private): solo accesible dentro de la propia clase y amigos.

Protegido (protected): accesible en clases derivadas.

Público (public): accesible desde cualquier lugar.

Se implementa rechazando código ilegal en tiempo de compilación, no cambiando la disposición en memoria.