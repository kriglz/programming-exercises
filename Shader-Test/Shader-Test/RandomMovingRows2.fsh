//
//  RandomMovingRows2.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 3/18/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

float random(float time) {
    return fract(sin(time - sqrt(time)) * cos(time));
}

void main() {
    vec2 iResolution = a_sprite_size.xy / 1.15;
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    
    // Scale the coordinate system by 10
    st.y *= 100;
    st.x *= 60;
    
    st.x -= u_time * (floor(st.y) / 10 + 10 * abs(random(floor(st.y))));
    
    // get the integer coords
    vec2 ipos = floor(st);
    
    // get the fractional coords
    vec2 fpos = fract(st);
    
    
    // Assign a random value based on the integer coord
    vec3 color = vec3(step(random(u_time)/5 + 0.3, random(ipos)) == 1 ? random(ipos) : 0);
    
    gl_FragColor = vec4(color,1.0);
}
