//
//  MovingPlus.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 2/18/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

#define PI 3.14159265359

float box(vec2 _st, vec2 _size){
    _size = vec2(0.5) - _size*0.5;
    vec2 uv = smoothstep(_size,
                         _size+vec2(0.001),
                         _st);
    uv *= smoothstep(_size,
                     _size+vec2(0.001),
                     vec2(1.0)-_st);
    return uv.x*uv.y;
}

float cross(vec2 _st, float _size){
    return  box(_st, vec2(_size,_size/4.)) + box(_st, vec2(_size/4.,_size));
}

/// Rotation around the axis function.
mat2 rotate2d(float _angle){
    return mat2(cos(_angle), -sin(_angle),
                sin(_angle), cos(_angle));
}

/// Scale the object.
mat2 scale(vec2 _scale){
    return mat2(_scale.x, 0.0,
                0.0, _scale.y);
}

void main(){
    vec2 iResolution = a_sprite_size / 1.15;
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    vec3 color = vec3(1.0);
    
    st -= vec2(0.5);
    
    st = rotate2d( sin(u_time) * PI ) * scale( vec2( sin(u_time) + 1.0) ) * st;
//    st = scale( vec2( sin(u_time) + 1.0) ) * st;
    
    // To move the cross we move the space
    vec2 translate = vec2(cos(u_time), sin(u_time));
   // st += translate * 0.35;// * (1 - 0.5 * sin(u_time));
    st += translate / sin(u_time)/100; // Vertical movement.
    
    st += vec2(0.5);
    
    // Show the coordinates of the space on the background
    color = vec3(st.x*2, st.y*2, 0);
    
    // Add the shape on the foreground
    color += vec3(cross(st, 0.2));
    
    gl_FragColor = vec4(color, 1.0);
}
