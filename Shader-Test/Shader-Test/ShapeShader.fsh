//
//  ShapeShader.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 1/30/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//


void main(){
    vec2 iResolution = a_sprite_size;
    vec2 st = gl_FragCoord.xy/iResolution;
    
    vec3 color = vec3(0.0);
    
    // Each result will return 1.0 (white) or 0.0 (black).
//    float left = step(0.1,st.x);   // Similar to ( X greater than 0.1 )
//    float bottom = step(0.1,st.y); // Similar to ( Y greater than 0.1 )
    
    // bottom-left
    vec2 bl = step(vec2(0.1),st);
    
    // top-right
     vec2 tr = step(vec2(0.1),1.0-st);
    
    // The multiplication of left*bottom will be similar to the logical AND.
    color = bl.x * bl.y * tr.x * tr.y;

    
    gl_FragColor = vec4(color,1.0);
}
