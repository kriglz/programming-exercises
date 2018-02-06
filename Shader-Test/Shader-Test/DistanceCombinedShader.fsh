//
//  DistanceCombinedShader.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 2/6/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

#define PI 3.14159265359
#define TWO_PI 6.28318530718

void main(){
    vec2 iResolution = a_sprite_size / 1.15;
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    st.x *= iResolution.x / iResolution.y;
    vec3 color = vec3(0.0);
    float d = 0.0;
    
    // Remap the space to -1. to 1.
    st = st * 4.0 -1;
    
    // Number of sides of your shape
    int N = 2;
    
    // Angle and radius from the current pixel
    float a = atan(st.x, st.y) + u_time;//+ PI;
    float r = 2* TWO_PI / float(N);
    
    // Shaping function that modulate the distance
    d = tan(floor(0.5 + a/r) * r - a) * length(st) * abs(sin(u_time*st.x*st.y));
    
    color = vec3(1.0 - smoothstep(0.4, 0.41, d));
//    color = vec3(d);
    
    gl_FragColor = vec4(color, 1.0);
}
