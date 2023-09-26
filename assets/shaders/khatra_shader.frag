#version 460 core
#include <flutter/runtime_effect.glsl>

uniform vec2 iResolution;
uniform float iTime;

out vec4 fragColor;

vec3 palette( in float t )
{
    vec3 a = vec3(0., 0.5, 0.5);
    vec3 b = vec3(0.5, 0.5, 0.5);
    vec3 c = vec3(1.0);
    vec3 d = vec3(0.263, 0.416, 0.557);

    return a + b*cos( 6.28318*(c*t+d) );
}

void main()
{
    vec2 fragCoord = FlutterFragCoord();

    // normalize the uv coordinates
    vec2 uv = fragCoord / iResolution.xy;
    uv = uv - 0.5;
    uv = 2. * uv;

    // for canvas width != height causing distortion
    uv.x *= iResolution.x / iResolution.y;

    float d = length(uv);

    // color
    vec3 color = palette(d);

    d = 0.02 / abs(sin(d * 8. + iTime) / 8.);

    fragColor = vec4(color * d ,1.0);
}
