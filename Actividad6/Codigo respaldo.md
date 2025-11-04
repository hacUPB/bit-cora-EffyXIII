# .cpp
#include "ofApp.h"

// Implementación de métodos EstadoVisual (normal, apagado, distancia) aquí...

// --- HexagonoGenerativo ---
HexagonoGenerativo::HexagonoGenerativo(float x_, float y_, int c, int r, float rad, EstadoVisual* estado)
    : x(x_), y(y_), col(c), row(r), radius(rad), estadoActual(estado) {
}

void HexagonoGenerativo::setEstado(EstadoVisual* nuevoEstado) {
    estadoActual = nuevoEstado;
}

void HexagonoGenerativo::dibujar() {
    if (estadoActual)
        estadoActual->dibujarHexagono(x, y, col, row, radius);
}

// --- HexagonoFactory ---
HexagonoFactory::HexagonoFactory(std::vector<EstadoVisual*> estados) : estadosDisponibles(estados) {
    rng.seed(std::random_device{}());
}

HexagonoGenerativo HexagonoFactory::crearHexagono(float x, float y, int col, int row, float radius) {
    std::uniform_int_distribution<> distrib(0, estadosDisponibles.size() - 1);
    EstadoVisual* estado = estadosDisponibles[distrib(rng)];
    return HexagonoGenerativo(x, y, col, row, radius, estado);
}

// --- GestorEstados ---
void GestorEstados::registrar(HexagonoGenerativo* hex) {
    observadores.push_back(hex);
}

void GestorEstados::cambiarEstadoGlobal(EstadoVisual* nuevoEstado) {
    estadoGlobal = nuevoEstado;
    for (auto& hex : observadores) {
        hex->setEstado(nuevoEstado);
    }
}

EstadoVisual* GestorEstados::obtenerEstadoGlobal() {
    return estadoGlobal;
}

// --- ofApp ---

void ofApp::setup() {
    ofSetWindowTitle("Hexágonos con Factory, State y Observer");
    ofSetFrameRate(60);
    ofBackground(10);

    // Inicializar factory con los estados organizados
    std::vector<EstadoVisual*> estadosDisponibles = { &estadoNormal, &estadoApagado, &estadoDistancia };
    factory = new HexagonoFactory(estadosDisponibles);

    // Crear hexágonos en posición (cálculo de col, row) y asignar estado aleatorio (modo caótico)
    float r = hexRadius;
    float w = r * 2;
    float h = sqrt(3) * r;
    float horizSpacing = w * 0.75;
    float vertSpacing = h;

    int cols = ofGetWidth() / horizSpacing + 2;
    int rows = ofGetHeight() / vertSpacing + 2;

    for (int row = 0; row < rows; ++row) {
        for (int col = 0; col < cols; ++col) {
            float x = col * horizSpacing;
            float y = row * vertSpacing;
            if (col % 2 == 1) y += vertSpacing / 2;

            // Crear hexágono con estado aleatorio
            HexagonoGenerativo hex = factory->crearHexagono(x, y, col, row, r);
            hexagonos.push_back(hex);
        }
    }

    // Registrar hexágonos en gestor de estados (observer)
    for (auto& hex : hexagonos) {
        gestorEstados.registrar(&hex);
    }

    // Modo por defecto: caótico (cada uno con su estado asignado, no cambiará)
    modoCaotico = true;
}

void ofApp::update() {
    // Podrías animar algo si quieres
}

void ofApp::draw() {
    // Ajustar distancia extra para estado distancia organizado
    if (!modoCaotico && gestorEstados.obtenerEstadoGlobal() == &estadoDistancia) {
        distanciaExtra = 20;
    }
    else {
        distanciaExtra = 0;
    }

    float r = hexRadius;
    float w = r * 2;
    float h = sqrt(3) * r;
    float horizSpacing = w * 0.75 + distanciaExtra;
    float vertSpacing = h + distanciaExtra;

    int cols = ofGetWidth() / horizSpacing + 2;
    int rows = ofGetHeight() / vertSpacing + 2;

    int idx = 0;
    for (int row = 0; row < rows; ++row) {
        for (int col = 0; col < cols; ++col) {
            if (idx >= (int)hexagonos.size()) break;

            float x = col * horizSpacing;
            float y = row * vertSpacing;
            if (col % 2 == 1) y += vertSpacing / 2;

            // Actualizar posición con distancia extra en estado distancia
            hexagonos[idx].x = x;
            hexagonos[idx].y = y;

            // Dibujar hexágono
            hexagonos[idx].dibujar();
            ++idx;
        }
    }
}

void ofApp::keyPressed(int key) {
    if (key == '1') {
        modoCaotico = false;
        gestorEstados.cambiarEstadoGlobal(&estadoNormal);
    }
    else if (key == '2') {
        modoCaotico = false;
        gestorEstados.cambiarEstadoGlobal(&estadoApagado);
    }
    else if (key == '3') {
        modoCaotico = false;
        gestorEstados.cambiarEstadoGlobal(&estadoDistancia);
    }
    else if (key == '4') {
        // Volver a caótico: cada hexágono conserva su estado original (aleatorio)
        modoCaotico = true;
        // Aquí no cambiamos el estado global, para que no modifique estados individuales
    }
}

# H
#pragma once
#include "ofMain.h"

class EstadoVisual {
public:
    //  Método virtual puro que cada estado debe implementar
    virtual void dibujarHexagono(float x, float y, int col, int row, float radius) = 0;

    // Opcional: útil para depurar o mostrar nombre del estado
    virtual std::string nombre() const = 0;

    virtual ~EstadoVisual() = default;
};

class EstadoNormal : public EstadoVisual {
public:
    void dibujarHexagono(float x, float y, int col, int row, float radius) override {
        float noise = ofNoise(col * 0.1, row * 0.1, ofGetElapsedTimef() * 0.3);
        ofColor color;
        color.setHsb(noise * 255, 180, 255);
        ofSetColor(color);

        ofPushMatrix();
        ofTranslate(x, y);
        ofBeginShape();
        for (int i = 0; i < 6; ++i) {
            float angle = ofDegToRad(i * 60);
            ofVertex(cos(angle) * radius, sin(angle) * radius);
        }
        ofEndShape(true);
        ofPopMatrix();
    }

    std::string nombre() const override { return "Normal"; }
};

class EstadoApagado : public EstadoVisual {
public:
    void dibujarHexagono(float x, float y, int col, int row, float radius) override {
        float noise = ofNoise(col * 0.1, row * 0.1, ofGetElapsedTimef() * 0.3);
        ofSetColor(ofColor::fromHsb(0, 0, noise * 255)); // escala de grises

        ofPushMatrix();
        ofTranslate(x, y);
        ofBeginShape();
        for (int i = 0; i < 6; ++i) {
            float angle = ofDegToRad(i * 60);
            ofVertex(cos(angle) * radius, sin(angle) * radius);
        }
        ofEndShape(true);
        ofPopMatrix();
    }

    std::string nombre() const override { return "Apagado"; }
};

class EstadoDistancia : public EstadoVisual {
public:
    void dibujarHexagono(float x, float y, int col, int row, float radius) override {
        float noise = ofNoise(col * 0.1, row * 0.1, ofGetElapsedTimef() * 0.3);
        ofColor color;
        color.setHsb(noise * 255, 180, 255);
        ofSetColor(color);

        ofPushMatrix();
        ofTranslate(x, y);
        ofBeginShape();
        for (int i = 0; i < 6; ++i) {
            float angle = ofDegToRad(i * 60);
            ofVertex(cos(angle) * radius, sin(angle) * radius);
        }
        ofEndShape(true);
        ofPopMatrix();
    }

    std::string nombre() const override { return "Distancia"; }
};


// Hexágono generativo
class HexagonoGenerativo {
public:
    HexagonoGenerativo(float x, float y, int col, int row, float radius, EstadoVisual* estado);
    void setEstado(EstadoVisual* nuevoEstado);
    void dibujar();
    float x, y;
    int col, row;
    float radius;
private:
    EstadoVisual* estadoActual;
};

// Factory para hexágonos
class HexagonoFactory {
public:
    HexagonoFactory(std::vector<EstadoVisual*> estados);
    HexagonoGenerativo crearHexagono(float x, float y, int col, int row, float radius);
private:
    std::vector<EstadoVisual*> estadosDisponibles;
    std::mt19937 rng;
};

// Gestor de estados (Subject)
class GestorEstados {
public:
    void registrar(HexagonoGenerativo* hex);
    void cambiarEstadoGlobal(EstadoVisual* nuevoEstado);
    EstadoVisual* obtenerEstadoGlobal();
private:
    std::vector<HexagonoGenerativo*> observadores;
    EstadoVisual* estadoGlobal = nullptr;
};

class ofApp : public ofBaseApp {
public:
    void setup();
    void update();
    void draw();
    void keyPressed(int key);

    float hexRadius = 30;
    float distanciaExtra = 0;

    std::vector<HexagonoGenerativo> hexagonos;

    // Estados y patrón State
    EstadoNormal estadoNormal;
    EstadoApagado estadoApagado;
    EstadoDistancia estadoDistancia;

    // Factory y gestor observer
    HexagonoFactory* factory;
    GestorEstados gestorEstados;

    // Control del modo caótico o organizado
    bool modoCaotico = true;

    void drawHexagon(float x, float y, float radius);
};
