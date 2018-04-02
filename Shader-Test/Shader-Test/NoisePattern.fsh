//
//  NoisePattern.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 4/2/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

vec2 random2(vec2 st){
    st = vec2( dot(st, vec2(127.1, 311.7)),
              dot(st, vec2(269.5, 183.3)));
    return -1.0 + 2.0 * fract(sin(st)*43758.5453123);
}

// Value Noise
float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);
    
    vec2 u = f * f * (3.0 - 2.0 * f);
    
    return mix( mix( dot( random2(i + vec2(0.0,0.0) ), f - vec2(0.0,0.0) ),
                    dot( random2(i + vec2(1.0,0.0) ), f - vec2(1.0,0.0) ), u.x),
               mix( dot( random2(i + vec2(0.0,1.0) ), f - vec2(0.0,1.0) ),
                   dot( random2(i + vec2(1.0,1.0) ), f - vec2(1.0,1.0) ), u.x), u.y);
}

void main() {
    vec2 iResolution = a_sprite_size.xy;// / 1.15;
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    vec3 color = vec3(0.0);
    
    float t = 1.0;
    t = abs(1.0 - sin(u_time*.1)) * 5.;
    
    // Comment and uncomment the following lines:
    st += noise(st * 2.) * t; // Animate the coordinate space
    color = vec3(1.) * smoothstep(.18, .2, noise(st)); // Big black drops
    color += smoothstep(.15, .2, noise(st * 10.)); // Black splatter
    color -= smoothstep(.35, .4, noise(st * 10.)); // Holes on splatter
    
    gl_FragColor = vec4(1.-color,1.0);
}
