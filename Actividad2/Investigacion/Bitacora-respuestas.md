¿Qué es la entrada-salida mapeada a memoria?
R//el metodo con el cual los dispositivos de entrada como teclado son accesibles a través del mismo espacio de direcciones de memoria que la RAM permitiendo usar instrucciones para comunicarse con ellos

¿Cómo se implementa en la plataforma Hack?
R//Las direcciones 16384 (0x4000) a 24575 (0x5FFF) representan la memoria de video, donde cada palabra de 16 bits corresponde a 16 píxeles en la pantalla virtual (256×512) del simulador 
La dirección 24576 (0x6000) es una lectora del teclado. Es decir, leer desde esa dirección te devuelve el código ASCII de la tecla presionada (o 0 si no hay ninguna)