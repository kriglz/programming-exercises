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
    color *= line(0.9, 0.02, st.y);

    
    gl_FragColor = vec4(color,1.0);
}
