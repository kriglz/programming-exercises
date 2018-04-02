//
//  2DNoiseShader.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 4/2/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

// 2D Random
float random (vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

// 2D Noise
float noise (vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);
    
    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));
    
    // Smooth Interpolation
    
    // Cubic Hermine Curve. Same as SmoothStep()
    vec2 u = f * f * (3.0 - 2.0 * f);
//    u = smoothstep(0., 1., f);
    
//    u = step(0.5, dot(u, vec2(0.5))) == 0 ? u : 1;
    
    // Mix 4 coorners porcentages
    return mix(a, b, u.x) +
    (c - a) * u.y * (1.0 - u.x) +
    (d - b) * u.x * u.y;
}

void main() {
    vec2 iResolution = a_sprite_size.xy;// / 1.15;
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    
    // Scale the coordinate system to see some noise in action
    vec2 pos = vec2(st * 5);//+ 10.0 * u_time));
    
    // Use the noise function
    float n = noise(pos);
    
    gl_FragColor = vec4(vec3(n), 1.0);
}

