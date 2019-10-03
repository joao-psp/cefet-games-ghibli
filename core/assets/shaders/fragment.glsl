uniform sampler2D u_diffuseTexture;
uniform float u_time;
uniform vec4 u_dirLights0color;
uniform vec3 u_dirLights0direction;
uniform vec4 u_dirLights1color;
uniform vec3 u_dirLights1direction;

varying vec4 v_color;
varying vec2 v_texCoords;
varying vec3 v_fragPosition;
varying vec3 v_fragNormal;

void main() 
{
    // para calcular a componente difusa, precisamos:
     vec3 normal = normalize(v_fragNormal);
     vec3 incidenciaLuz = normalize(-u_dirLights0direction);

    // para calcular a componente especular, precisamos:
    vec3 visualizacao = normalize(-v_fragPosition);
    vec3 reflexao = normalize(reflect(u_dirLights0direction, v_fragNormal));

    // calcula as 3 componentes de Phong: ambiente, difusa, especular

    vec4 ambiente = (vec4(0.15, 0.15, 0.15, 1));
    vec4 difusa = (vec4(max(dot(normal, incidenciaLuz), 0.0) * u_dirLights0color * texture2D(u_diffuseTexture, v_texCoords)));
    vec4 especular = (vec4(pow(max(dot(reflexao, visualizacao), 0.0), 5.0)) * u_dirLights0color);

    // Dá o resultado
    gl_FragColor = normalize(ambiente + difusa + especular);
}
