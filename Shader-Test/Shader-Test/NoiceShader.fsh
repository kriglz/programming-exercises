//
//  NoiceShader.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 3/26/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

#define lineNumber 2
#define columnNumber 2

float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

float rand(float x) {
    return fract(sin(x) * 100000.0);
}

float noise(float x) {
    float i = floor(x);  // integer
    float f = fract(x);  // fraction
    float u = f * f * (3.0 - 2.0 * f ); // custom cubic curve
    return mix(rand(i), rand(i + 1.0), u);
}

float circle(float firstRadius, float secondRadius, float d) {
    float circle = step(firstRadius, d);
    circle *= step(1-secondRadius, 1 - d);
    return circle;
}

void main() {
    vec2 iResolution = a_sprite_size.xy;// / 1.15;
    iResolution.x *= 1.5;
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    vec3 color = vec3(1.0);
    float alpha = 1.0;

    float pct = distance(st, vec2(0.5 * (abs(sin(u_time / 5)) + 0.1), 0.4 + noise(abs(cos(u_time / 5)))));
    float secondRadius = 2 * noise(random(st) * abs(sin(u_time / 10)));
    color = circle(0, secondRadius, pct);
    
    if (secondRadius > 0.05 && color.x == 1) {
        color = (step(0.5, abs(sin(u_time * 10))) == 0 ? 1 : vec3(1., 0., 0.));
    }
        
    gl_FragColor = vec4(color, alpha);
}

