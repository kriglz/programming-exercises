//
//  ShapeShader.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 1/30/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

float line(float first, float delta, float d) {
    // right line
    float f = step(first, d);
    // left line
    float s = step(1-first+delta, 1-d);
    
    return f + s;

}

//vec3 fillColor(vec3 color, vec2 topLeft, vec2 bottomRight) {
//    vec3 fc;
//
//    if (color.x == 1.0 && st.y < 0.1 && st.x < 0.2) {
//        color = mix(colorA, colorA, color);
//    }
//
//    return fc;
//}

void main(){
    vec2 iResolution = a_sprite_size/1.15;
    vec2 st = gl_FragCoord.xy/iResolution;
    
    vec3 color = vec3(0.0);
    
    // bottom-left
//    vec2 bl = step(vec2(0.1), st);
    // top-right
//     vec2 tr = step(vec2(0.1), 1.0-st);
    
    // bottom-left
//    vec2 bl = smoothstep(vec2(0.1), vec2(0.5), st);
    // top-right
//    vec2 tr = smoothstep(vec2(0.1), vec2(0.5), 1.0-st);
    
    // The multiplication of left*bottom will be similar to the logical AND.
//    color = bl.x * bl.y * tr.x * tr.y;

    color = line(0.2, 0.04, st.x);
    color *= line(0.9, 0.02, st.x);
    color *= line(0.1, 0.01, st.y);
    color *= line(0.7, 0.02, st.y);
    color *= line(0.9, 0.01, st.y);

    vec3 yellow = vec3(1,0.9,0.6);
    vec3 aqua = vec3(0,0.8,0.9);
    vec3 red = vec3(1,0.2,0.2);

    if (color.x == 1.0) {
        
        if ( st.y > 0 && st.y < 0.1 && st.x > 0 && st.x < 0.2) {
            color = mix(yellow, yellow, color);
        }
        if ( st.y > 0.1 && st.y < 0.7 && st.x > 0.2 && st.x < 0.9) {
            color = mix(aqua, aqua, color);
        }
        if ( st.y > 0.7 && st.y < 0.9 && st.x > 0 && st.x < 0.9) {
            color = mix(red, red, color);
        }
    }
    
    gl_FragColor = vec4(color,1.0);
}
