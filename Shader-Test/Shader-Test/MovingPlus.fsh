//
//  MovingPlus.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 2/18/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

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

void main(){
    vec2 iResolution = a_sprite_size / 1.15;
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    vec3 color = vec3(0.0);
    
    // To move the cross we move the space
    vec2 translate = vec2(cos(u_time), sin(u_time));
    st += translate * 0.35 * (1 - 0.5 * sin(u_time));
//    st += translate / sin(u_time)/10; // Vertical movement.
    
    // Show the coordinates of the space on the background
    color = vec3(st.x,st.y,0);
    
    // Add the shape on the foreground
    color += vec3(cross(st,0.25));
    
    gl_FragColor = vec4(color,1.0);
}
