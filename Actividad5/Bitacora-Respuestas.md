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