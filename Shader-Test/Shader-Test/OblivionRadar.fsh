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

float circleSmooth(float firstRadius, float secondRadius, float d) {
    float circle = smoothstep(firstRadius, firstRadius + 0.05, d);
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

float line(vec2 st, float pct){
    return step(pct, st.y) - step(pct+0.001, st.y);
}

vec3 makeColor(float red, float green, float blue, float coord) {
    return vec3(coord * red / 255,
                coord * green / 255,
                coord * blue / 255);
}

float blinking(float time) {
    return step(0.5, abs(sin(time * 15)));
}

void main(){
    vec2 center = vec2(0.3, 0.5);
    vec2 iResolution = a_sprite_size.y / 1.15;
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    vec3 color = vec3(1.0);
    
//    st -= vec2(0.3, 0);
    
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
    float pct = distance(st, center);
    
    // Add the cicle shape .
    color = vec3(circle(0.5, 0.51, pct));
    color += vec3(circle(0.35, 0.355, pct));
    color += makeColor(24, 201, 239, circle(0.2, 0.205, pct));
    color += makeColor(24, 201, 239, circle(0.03, 0.035, pct));

    // Moving center position of the cross to match the circle center.
    vec2 stMoved = st + vec2(0.2, 0);
    
    // Adds crossing lines.
    color += vec3(line(stMoved, stMoved.x));
    color += vec3(line(stMoved, 1-stMoved.x));

    // Adding moving small red circle.
    
    // Creates circular movement.
    vec2 translate = vec2(cos(u_time), sin(u_time));
    // Decentralize.
    vec2 stMoving = st - center;
    // Adds time dependent movement.
    stMoving += translate * 0.28 * sin(u_time / 100);
    // Centralize.
    stMoving += center;

    // Gets distance from the center.
    pct = distance(stMoving, center);
    // Adds red filled blinking cirle.
    color += makeColor(255, 0, 0, circle(0.0, 0.015, pct)) * blinking(u_time);
    // Adds red empty circle.
    color += makeColor(255, 0, 0, circle(0.02, 0.022, pct));
    
    // Init scaled circle radius.
    vec2 scaledCircle = vec2(0.022);
    // Scales the circle radius.
    scaledCircle *= scale(vec2(max(step(0, tan(u_time * 2 + PI)) * (tan(u_time + PI / 2) * 5 + 1.0),
                                   step(0, tan(u_time*2)) * (tan(u_time) * 5 + 1.0))));
    // Adds red empty scaling circle with smooth line.
    color += makeColor(255, 0, 0, circleSmooth(scaledCircle.x - 0.05, scaledCircle.x, pct));

    gl_FragColor = vec4(color, 1.0);
}
