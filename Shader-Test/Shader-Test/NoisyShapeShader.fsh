//
//  NoisyShapeShader.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 4/2/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

vec2 random2(vec2 st) {
    st = vec2( dot(st, vec2(127.1, 311.7)),
              dot(st, vec2(269.5, 183.3)));
    return -1.0 + 2.0 * fract(sin(st) * 43758.5453123);
}

// Value Noise by Inigo Quilez - iq/2013
float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);
    
    //Improved smooth step function.
    vec2 u = f * f * f * (f * (f * 6. - 15.) + 10.);
//    vec2 u = f * f * (3.0 - 2.0 * f);
    
    return mix(mix( dot(random2(i + vec2(0.0,0.0)), f - vec2(0.0,0.0)),
                    dot(random2(i + vec2(1.0,0.0)), f - vec2(1.0,0.0)), u.x),
               mix( dot(random2(i + vec2(0.0,1.0)), f - vec2(0.0,1.0)),
                   dot(random2(i + vec2(1.0,1.0)), f - vec2(1.0,1.0)), u.x), u.y);
}

mat2 rotate2d(float _angle){
    return mat2(cos(_angle), -sin(_angle),
                sin(_angle), cos(_angle));
}

float shape(vec2 st, float radius, float time) {
    st = vec2(0.5) - st;
    float r = length(st) * 2.0;
    float a = atan(st.y, st.x);
    float m = abs(mod(a + time * 2., 3.14 * 2.) - 3.14) / 3.6;
    float f = radius;
    m += noise(st + time * 0.1) * .5;
//    a *= 1. + abs(atan(time * 0.2)) * .1;
//    a *= 1. + noise(st + time * 0.1) * 0.1;
    f += sin(a * 50.) * noise(st + time * .2) * .1;
    f += (sin(a * 20.) * .1 * pow(m, 2.));
    return 1. - smoothstep(f, f + 0.007, r);
}

float shapeBorder(vec2 st, float radius, float width, float time) {
    return shape(st, radius, time) - shape(st, radius - width, time);
}

void main() {
    vec2 iResolution = a_sprite_size.xy;// / 1.15;
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    
    vec3 color = vec3(1.0) * shapeBorder(st, 0.5, 0.02 * (1 + abs(sin(u_time))), u_time);
    
    gl_FragColor = vec4(1-color, 1.0);
}
