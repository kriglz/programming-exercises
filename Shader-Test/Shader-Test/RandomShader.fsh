//
//  RandomShader.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 3/18/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

float random (vec2 st, float time) {
//    return fract(sin(dot(st.xy, vec2(12.9898 * st.x, 78.233 * st.y))) * 43758.5453123 / time);
    return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123 * (sin(time / 10) + 0.2));
}

void main() {
    vec2 iResolution = a_sprite_size.xy / 1.15;
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    
    // Scale the coordinate system by 10
    st *= 10.0;
    // get the integer coords
    vec2 ipos = floor(st);
    // get the fractional coords
    vec2 fpos = fract(st);
    
    // Assign a random value based on the integer coord
    vec3 color = vec3(random(ipos, u_time));// * (abs(tan(u_time)) + 0.4);
    
    // Uncomment to see the subdivided grid
//     color = vec3(fpos,0.0);
    
    gl_FragColor = vec4(color,1.0);
}

