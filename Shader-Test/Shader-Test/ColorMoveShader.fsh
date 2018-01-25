//
//  ColorMoveShader.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 1/25/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//


float bounceOut(float t) {
    const float a = 4.0 / 11.0;
    const float b = 8.0 / 11.0;
    const float c = 9.0 / 10.0;
    
    const float ca = 4356.0 / 361.0;
    const float cb = 35442.0 / 1805.0;
    const float cc = 16061.0 / 1805.0;
    
    float t2 = t * t;
    
    return t < a
    ? 7.5625 * t2
    : t < b
    ? 9.075 * t2 - 9.9 * t + 3.4
    : t < c
    ? ca * t2 - cb * t + cc
    : 10.8 * t * t - 20.52 * t + 10.72;
}

float bounceInOut(float t) {
    return t < 0.5
    ? 0.5 * (1.0 - bounceOut(1.0 - t * 2.0))
    : 0.5 * bounceOut(t * 2.0 - 1.0) + 0.5;
}

float quadraticInOut(float t) {
    float p = 2.0 * t * t;
    return t < 0.2 ? p : -p + (4.0 * t) - 1.0;
}

float quadraticStep(float t, float y) {
//    float p = 2.0 * t * t;
    return step(abs(sin(t)), 1.5 * y); //t < 0.2 ? p : -p + (4.0 * t) - 1.0;
}

vec3 getColor(vec3 color, float t) {
    vec3 colorPreA = vec3(0.8,1.0,0.7);
    vec3 colorPostB = vec3(0.7,0.9,1.0);
    
    return t < 0.01
    ? colorPreA
    : t < 0.99
    ? color
    : colorPostB;
}

float plot (vec2 st, float pct){
    return smoothstep( pct-0.01, pct, st.y) -
    smoothstep( pct, pct+0.01, st.y);
}


void main() {
    vec2 iResolution = a_sprite_size;
    vec2 st = gl_FragCoord.xy/iResolution;
    
    vec3 colorA = vec3(1,0.9,0.7);
    vec3 colorB = vec3(0,7.8,0.9);
    vec3 color = vec3(0.0);
    
    vec3 pct = vec3(st.y);//quadraticInOut(sin(u_time));
    
    pct.x = quadraticStep(u_time, st.y); //step((1-st.x)*sin(u_time * 1.1), st.y*cos(u_time * 1.1)); //bounceInOut(st.x*sin(u_time));
//    pct.y = step(st.x*sin(u_time * 1.2), (1-st.y)*cos(u_time * 1.2)); //bounceInOut(st.y*cos(u_time));
//    pct.z = step(st.x*cos(u_time * 1.3), st.y*sin(u_time * 1.3)); //bounceInOut(sqrt(st.y*st.y*2 + st.x*st.x)) + step(pct.x, pct.y);
    
    color = mix(colorA, colorB, pct);
    
    // Plot transition lines for each channel
    //    color = mix(color,vec3(1.0,0.0,0.0),plot(st,pct.r));
    //    color = mix(color,vec3(0.0,1.0,0.0),plot(st,pct.g));
    //    color = mix(color,vec3(0.0,0.0,1.0),plot(st,pct.b));
    //
    gl_FragColor = vec4(color, 1.0);
}

