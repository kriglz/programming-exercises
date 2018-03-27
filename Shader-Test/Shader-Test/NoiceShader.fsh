//
//  NoiceShader.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 3/26/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

#define lineNumber 50
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

void main() {
    vec2 iResolution = a_sprite_size.xy / 1.15;
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    vec3 color = vec3(1.0);
    float alpha = 1.0;
    
    // Scale the coordinate system by 10
    st.y *= lineNumber;
    st.x *= columnNumber;
    
    // get the integer coords
    vec2 ipos = floor(st);
 
//    st.x -= u_time * (0.5 + floor(st.y) / 10 + 10 * abs(random(floor(st.y))));
//    ipos = floor(st);
//    color *= step(0.5, random(ipos));

    
    
    color =  dot(vec2(rand(st.x), st.y), vec2(cos(u_time), 0.5));
    
    // tilted lines
//    color =  rand((st.y + st.x) * sin(u_time));


    // Blinking screen.
//    color = step(0.5, rand(u_time));

    
    gl_FragColor = vec4(color, alpha);
}

