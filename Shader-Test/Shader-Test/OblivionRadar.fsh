//
//  OblivionRadar.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 2/20/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

#define PI 3.14159265359

//float box(vec2 _st, vec2 _size){
//    _size = vec2(0.5) - _size*0.5;
//    vec2 uv = smoothstep(_size,
//                         _size+vec2(0.001),
//                         _st);
//    uv *= smoothstep(_size,
//                     _size+vec2(0.001),
//                     vec2(1.0)-_st);
//    return uv.x*uv.y;
//}

float circle(float firstRadius, float secondRadius, float d) {
    float circle = step(firstRadius, d);
    circle *= step(1-secondRadius, 1 - d);
    return circle;
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

float line (vec2 st, float pct){
    return step(pct, st.y) - step(pct+0.001, st.y);
//    return smoothstep(pct-0.01, pct, st.y) - smoothstep(pct, pct+0.01, st.y);
}

void main(){
    vec2 iResolution = a_sprite_size.x / 1.15;
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    vec3 color = vec3(1.0);
    
//    st -= vec2(0.5);
    
//    st = rotate2d( sin(u_time) * PI ) * scale( vec2( sin(u_time) + 1.0) ) * st;
    //    st = scale( vec2( sin(u_time) + 1.0) ) * st;
    
    // To move the cross we move the space
//    vec2 translate = vec2(cos(u_time), sin(u_time));
    // st += translate * 0.35;// * (1 - 0.5 * sin(u_time));
//    st += translate / sin(u_time)/100; // Vertical movement.
    
//    st += vec2(0.5);
    
    // Show the coordinates of the space on the background
//    color = vec3(st.x*2, st.y*2, 0);
    
    // Calculate the center
    float pct = distance(st, vec2(0.5));
    // Add the cicle shape on the foreground
    color = vec3(circle(0.5, 0.52, pct));
    color += vec3(circle(0.35, 0.36, pct));
    color += vec3(circle(0.2, 0.205, pct));
    color += vec3(circle(0.05, 0.057, pct));

    color += vec3(line(st, st.x));
    color += vec3(line(st, 1-st.x));

    gl_FragColor = vec4(color, 1.0);
}
