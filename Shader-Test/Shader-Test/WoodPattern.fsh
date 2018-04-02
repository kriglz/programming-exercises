//
//  WoodPattern.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 4/2/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

float random(vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))
                 * 43758.5453123);
}

// Value noise
float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);
    vec2 u = f*f*(3.0-2.0*f);
    return mix( mix( random( i + vec2(0.0,0.0) ),
                    random( i + vec2(1.0,0.0) ), u.x),
               mix( random( i + vec2(0.0,1.0) ),
                   random( i + vec2(1.0,1.0) ), u.x), u.y);
}

mat2 rotate2d(float angle){
    return mat2(cos(angle),-sin(angle),
                sin(angle),cos(angle));
}

float lines(vec2 pos, float b){
    float scale = 10.0;
    pos *= scale;
    return smoothstep(0.0,
                      .5 + b * .5,
                      abs((sin(pos.x * 3.1415) + b * 2.0)) * .5);
}

void main() {
    vec2 iResolution = a_sprite_size.xy;// / 1.15;
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    
    float t = 1.0;
    t = abs(1.0 - abs(sin(u_time * .1))) * 5.;
    st.x += noise(st * 2.) * t; // Animate the coordinate space
    
    vec2 pos = st.yx * vec2(10., 3.);
    
    float pattern = pos.x;
    
    // Add noise
    pos = rotate2d( noise(pos) ) * pos;
    
    // Draw lines
    pattern = lines(pos, .5);
    
    gl_FragColor = vec4(vec3(pattern), 1.0);
}
