//
//  Voronoi.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 5/16/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

void main() {
    vec2 iResolution = a_sprite_size.xy;
    vec2 st = gl_FragCoord.xy / iResolution.x;
    
    vec3 color = vec3(.0);
    
    // Cell positions
    vec2 point[5];
    point[0] = vec2(0.83,0.75);
    point[1] = vec2(0.60,0.07);
    point[2] = vec2(0.28,0.64);
    point[3] =  vec2(0.31,0.26);
    point[4] = a_mouse/iResolution;
    
    float m_dist = 1.;  // minimun distance
    vec2 m_point;        // minimum position
    
    // Iterate through the points positions
    for (int i = 0; i < 5; i++) {
        float dist = distance(st, point[i]);
        if ( dist < m_dist ) {
            // Keep the closer distance
            m_dist = dist;
            
            // Kepp the position of the closer point
            m_point = point[i];
        }
    }
    
    // Add distance field to closest point center
    color += m_dist*2.;
    
    // tint acording the closest point position
    color.rg = m_point;
    
    // Show isolines
    color -= abs(sin(80.0*m_dist))*0.07;
    
    // Draw point center
    color += 1.-step(.02, m_dist);
    
    gl_FragColor = vec4(color,1.0);
}
