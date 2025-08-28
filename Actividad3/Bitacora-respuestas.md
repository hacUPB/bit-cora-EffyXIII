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

RETO

Codigo del reto

*.cpp*

#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup() {
    ofBackground(0);
    ofEnableDepthTest();

    generateSpheres();
}

//--------------------------------------------------------------
void ofApp::update() {
    // Si se quisiera animar algo en tiempo real, aquí va
}

//--------------------------------------------------------------
//--------------------------------------------------------------
void ofApp::draw() {
    cam.begin();

    for (int i = 0; i < spherePositions.size(); i++) {
        if (i == selectedIndex) {
            ofSetColor(255, 0, 0); // Seleccionada en rojo
        }
        else {
            ofSetColor(sphereColors[i]); // Color de fila
        }
        ofDrawSphere(spherePositions[i], sphereRadius);
    }

    cam.end();

    ofSetColor(255);
    if (sphereSelected && selectedIndex >= 0) {
        glm::vec3 pos = spherePositions[selectedIndex];
        ofDrawBitmapStringHighlight("Esfera seleccionada:\nX: " + ofToString(pos.x) +
            " Y: " + ofToString(pos.y) +
            " Z: " + ofToString(pos.z),
            20, 20);
    }
    else {
        ofDrawBitmapStringHighlight("Haz clic en una esfera", 20, 20);
    }
}

//--------------------------------------------------------------

void ofApp::keyPressed(int key) {
    if (key == 'a') {
        amplitud = min(amplitud + 5, 100.0f); // no mayor a 100
    }
    if (key == 'z') {
        amplitud = max(0.0f, amplitud - 5);   // no negativa
    }

    if (key == 'd') distDiv += 5;
    if (key == 'c') distDiv = max(10.0f, distDiv - 5);

    if (key == 'x') xStep += 5;
    if (key == 's') xStep = max(10, xStep - 5);

    if (key == 'y') yStep += 5;
    if (key == 't') yStep = max(10, yStep - 5);

    generateSpheres();
}


//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button) {
    glm::vec3 rayStart, rayEnd;
    convertMouseToRay(x, y, rayStart, rayEnd);

    sphereSelected = false;
    selectedIndex = -1;

    for (int i = 0; i < spherePositions.size(); i++) {
        glm::vec3 intersectionPoint;
        if (rayIntersectsSphere(rayStart, glm::normalize(rayEnd - rayStart),
            spherePositions[i], sphereRadius, intersectionPoint)) {
            sphereSelected = true;
            selectedIndex = i;
            break;
        }
    }
}

//--------------------------------------------------------------
//--------------------------------------------------------------
void ofApp::generateSpheres() {
    spherePositions.clear();
    sphereColors.clear();

    int filas = 0;
    for (int y = -ofGetHeight() / 2; y < ofGetHeight() / 2; y += yStep) {
        // Asignar un color único para cada fila usando HSB
        ofColor filaColor = ofColor::fromHsb(ofMap(filas, 0, ofGetHeight() / yStep, 0, 255), 200, 255);

        for (int x = -ofGetWidth() / 2; x < ofGetWidth() / 2; x += xStep) {
            float z = cos(ofDist(x, y, 0, 0) / distDiv) * amplitud;
            spherePositions.push_back(glm::vec3(x, y, z));
            sphereColors.push_back(filaColor);
        }
        filas++;
    }
}



//--------------------------------------------------------------
void ofApp::convertMouseToRay(int x, int y, glm::vec3& rayStart, glm::vec3& rayEnd) {
    // Transformar coordenadas de pantalla a mundo
    glm::vec3 mouse(x, y, 0.0f);
    glm::vec3 mouseNorm = glm::vec3(
        (mouse.x / ofGetWidth()) * 2.0f - 1.0f,
        -((mouse.y / ofGetHeight()) * 2.0f - 1.0f),
        1.0f
    );

    glm::mat4 invProjView = glm::inverse(cam.getProjectionMatrix() * cam.getModelViewMatrix());
    glm::vec4 nearPoint = invProjView * glm::vec4(mouseNorm.x, mouseNorm.y, -1.0f, 1.0f);
    glm::vec4 farPoint = invProjView * glm::vec4(mouseNorm.x, mouseNorm.y, 1.0f, 1.0f);

    rayStart = glm::vec3(nearPoint) / nearPoint.w;
    rayEnd = glm::vec3(farPoint) / farPoint.w;
}

//--------------------------------------------------------------
bool ofApp::rayIntersectsSphere(const glm::vec3& rayOrigin, const glm::vec3& rayDir,
    const glm::vec3& sphereCenter, float radius, glm::vec3& hitPoint) {
    glm::vec3 oc = rayOrigin - sphereCenter;
    float b = glm::dot(oc, rayDir);
    float c = glm::dot(oc, oc) - radius * radius;
    float discriminant = b * b - c;

    if (discriminant < 0) return false;

    float t = -b - sqrt(discriminant);
    if (t < 0) t = -b + sqrt(discriminant);
    if (t < 0) return false;

    hitPoint = rayOrigin + t * rayDir;
    return true;
}


y *.h*

#pragma once
#include "ofMain.h"

class ofApp : public ofBaseApp {
public:
    void setup();
    void update();
    void draw();

    void keyPressed(int key);
    void mousePressed(int x, int y, int button);
    vector<ofColor> sphereColors;



    // Funciones auxiliares
    void generateSpheres();
    void convertMouseToRay(int x, int y, glm::vec3& rayStart, glm::vec3& rayEnd);
    bool rayIntersectsSphere(const glm::vec3& rayOrigin, const glm::vec3& rayDir,
        const glm::vec3& sphereCenter, float radius, glm::vec3& hitPoint);

    // Variables principales
    ofEasyCam cam;
    vector<glm::vec3> spherePositions;

    // Parámetros de la cuadrícula
    int xStep = 50;
    int yStep = 50;
    float distDiv = 100.0f;
    float amplitud = 50.0f;

    // Selección
    bool sphereSelected = false;
    int selectedIndex = -1;
    float sphereRadius = 20.0f;


};
