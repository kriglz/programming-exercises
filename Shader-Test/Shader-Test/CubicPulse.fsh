//
//  CubicPulse.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 4/2/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

float random (float x) {
    return fract(sin(x)*1e4);
}

float noise (vec3 p) {
    const vec3 step = vec3(110.0, 241.0, 171.0);
    
    vec3 i = floor(p);
    vec3 f = fract(p);
    
    // For performance, compute the base input to a
    // 1D random from the integer part of the
    // argument and the incremental change to the
    // 1D based on the 3D -> 1D wrapping
    float n = dot(i, step);
    
    vec3 u = f * f * (3.0 - 2.0 * f);
    return mix( mix(mix(random(n + dot(step, vec3(0,0,0))),
                        random(n + dot(step, vec3(1,0,0))),
                        u.x),
                    mix(random(n + dot(step, vec3(0,1,0))),
                        random(n + dot(step, vec3(1,1,0))),
                        u.x),
                    u.y),
               mix(mix(random(n + dot(step, vec3(0,0,1))),
                       random(n + dot(step, vec3(1,0,1))),
                       u.x),
                   mix(random(n + dot(step, vec3(0,1,1))),
                       random(n + dot(step, vec3(1,1,1))),
                       u.x),
                   u.y),
               u.z);
}

void main() {
    vec2 iResolution = a_sprite_size.xy / 1.15;
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    vec3 color = vec3(0.0);
    
    vec3 pos = vec3(st*5.0,u_time*0.5);
    
    color = vec3(noise(pos));
    
    gl_FragColor = vec4(color,1.0);
}
