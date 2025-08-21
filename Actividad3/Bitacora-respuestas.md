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

Actividad #2
-Modificamos el archivo ofApp.h con el siguiente codigo
![alt text](<Captura de pantalla 2025-08-21 090526.png>)
y el ofApp.cpp con este
![alt text](<Captura de pantalla 2025-08-21 090826.png>)
Al ejecutar el programa, podemos observar a primera vista como se forma una linea en base a circulos por donde pasa el mouse, pero al analizar el codigo en el .h note que habia deteccion de el click del mouse, al usarlo se ve como se dejan de generar circulos (mientras mantenemos apretado) y como los circulos ya presesntes hasta ese momento + los nuevos que se generen una vez soltado el click, cambian su color como se muestra a continuacion
<video controls src="prueba de programa.mp4" title="Title"></video>