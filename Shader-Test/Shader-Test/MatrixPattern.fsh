//
//  MatrixPattern.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 3/5/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

#define PI 3.14159265358979323846

vec2 rotate2D(vec2 _st, float _angle){
    _st -= 0.5;
    _st =  mat2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle)) * _st;
    _st += 0.5;
    return _st;
}

vec2 tile(vec2 _st, float _zoom){
    _st *= _zoom;
    return fract(_st);
}

float box(vec2 _st, vec2 _size, float _smoothEdges){
    _size = vec2(0.5)-_size*0.5;
    vec2 aa = vec2(_smoothEdges*0.5);
    vec2 uv = smoothstep(_size,_size+aa,_st);
    uv *= smoothstep(_size,_size+aa,vec2(1.0)-_st);
    return uv.x*uv.y;
}

void main(void){
    vec2 iResolution = a_sprite_size.x / 1.15;
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    vec3 color = vec3(0.0);
    
    // Divide the space in 4
    st = tile(st, 6);
    
    // Use a matrix to rotate the space 45 degrees
    st = rotate2D(st, PI * (u_time)); //0.35);
    
    // Draw a square
//    color = vec3(box(st, vec2(0.7), 0.01));
    // Fill with gradient color.
    color = vec3(st.x, st.y / 3, 0.5);
    
    gl_FragColor = vec4(color,1.0);
}
