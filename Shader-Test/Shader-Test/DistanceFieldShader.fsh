//
//  DistanceFieldShader.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 2/5/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

void main(){
    vec2 iResolution = a_sprite_size / 2;//1.15;

    vec2 st = gl_FragCoord.xy / iResolution.xy;
    st.x *= iResolution.x / iResolution.y;
    vec3 color = vec3(0.0);
    float d = 0.0;
    
    // Remap the space to -1. to 1.
    st = st * 2. -1.;
    
    // Make the distance field
    d = length(abs(st) - 0.9);
//     d = length(min(abs(st) - .3,0.));
//     d = length(max(abs(st) - .3,0.));
    
    // Visualize the distance field
    gl_FragColor = vec4(vec3(fract(d * 10.0)), 1.0);
    
    // Drawing with the distance field
//     gl_FragColor = vec4(vec3(step(.3, d)), 1.0);
//     gl_FragColor = vec4(vec3(step(.3, d) * step(d, .4)), 1.0);
//     gl_FragColor = vec4(vec3(smoothstep(.3, .4, d) * smoothstep(.6, .5, d)), 1.0);
}
