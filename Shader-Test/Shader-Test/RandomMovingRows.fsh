//
//  RandomMovingRows.fsh
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
    st.y *= 2;
    st.x *= 100;
    
    if (mod(st.y, 2.0) < 1) {
        st.x += u_time * 30 + (40 * random(abs(sin(u_time) * sin(u_time)) + random(st) / 5));
    } else {
        st.x -= u_time * 20 - random(u_time + random(st)) * random(u_time + random(u_time)) * 10.0;
    }
    
    // get the integer coords
    vec2 ipos = floor(st);
    
    // get the fractional coords
    vec2 fpos = fract(st);
    
    
    // Assign a random value based on the integer coord
    vec3 color = vec3(step((random(u_time)/3 + 0.3), random(ipos)));
    
    // Uncomment to see the subdivided grid
    //     color = vec3(fpos,0.0);
    
    gl_FragColor = vec4(color,1.0);
}
