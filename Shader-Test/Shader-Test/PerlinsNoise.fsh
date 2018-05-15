//
//  PerlinsNoise.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 5/13/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

#ifdef GL_ES
precision mediump float;
#endif

//uniform vec2 a_mouse;

void main() {
    vec2 iResolution = a_sprite_size.xy;
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    st.x *= iResolution.x/iResolution.y;
    
    vec3 color = vec3(.0);
    
    // Cell positions
    vec2 point[5];
    point[0] = vec2(0.83, 0.75) + vec2(sin(u_time) / 10);
    point[1] = vec2(0.60, 0.07) - vec2(sin(u_time) / 5, 0);
    point[2] = vec2(0.28, 0.64) + vec2(cos(u_time) / 5, 0);
    point[3] =  vec2(0.31, 0.26) - vec2(sin(u_time) / 10);
    point[4] = a_mouse/iResolution;
    
    float m_dist = 0.4;  // minimun distance
    
    // Iterate through the points positions
    for (int i = 0; i < 5; i++) {
        float dist = distance(st, point[i]);
        
        // Keep the closer distance
        m_dist = min(m_dist, dist);
    }
    
    // Draw the min distance (distance field)
    color += m_dist;
    
    // Show isolines
    color -= step(.7, abs(sin(50.0*m_dist)))*.3;
    
    gl_FragColor = vec4(color,1.0);
}
