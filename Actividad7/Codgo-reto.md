## .vert
#version 150

uniform mat4 modelViewProjectionMatrix;
uniform vec2 mousePos;
uniform float mouseRange;
uniform float time;

in vec4 position;
in vec3 normal;
in vec2 texcoord;

out vec3 vPosition;
out float vDist;

void main()
{
    // Distancia del vértice al mouse (centro de la onda)
    float dist = length(position.xy - mousePos);
    vDist = dist;

    // Onda radial (basada en distancia y tiempo)
    float waveFreq = 0.15;
    float waveAmp = 100.0;
    float wave = sin(dist * waveFreq - time * 5.0) * waveAmp;

    
    float influence = smoothstep(mouseRange, 0.0, dist);

    vec4 newPos = position;
    newPos.z += wave * influence;

    vPosition = newPos.xyz;

    gl_Position = modelViewProjectionMatrix * newPos;


}


## .frag

#version 150

uniform vec4 mouseColor;
uniform float time;

in vec3 vPosition;
in float vDist;

out vec4 outputColor;

void main()
{
    // Brillo localizado
    float nearRange = 150.0;  // área visible del efecto
    float glow = smoothstep(nearRange, 0.0, vDist);

    // Pulso dinámico
    float pulse = abs(sin(time * 3.0 + vDist * 0.1));

    // Colores más intensos cerca del mouse
    vec3 baseColor = mix(vec3(0.1, 0.1, 0.2), mouseColor.rgb, glow);
    vec3 finalColor = baseColor + vec3(0.3, 0.7, 1.0) * pulse * glow;

    outputColor = vec4(finalColor, 1.0);


}
