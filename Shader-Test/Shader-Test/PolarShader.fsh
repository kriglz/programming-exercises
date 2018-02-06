//
//  PolarShader.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 2/6/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

void main() {
    vec2 iResolution = a_sprite_size / 1.15;
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    vec3 color = vec3(0.0);
    
    st.x += cos(u_time);
    vec2 pos = vec2(0.5) - st;

    float r = length(pos) * 2.0;
    float a = atan(pos.y, pos.x);
    
    float f = cos(a * 10.0);
    f = abs(cos(a * 3.0));
    f = abs(cos(a * 2.5)) * 0.5 + 0.3;
    float f1 = abs(cos(a * 12.0) * sin(a * 3.0)) * 0.8 + 0.1;
    float f2 = smoothstep(-0.5, 1.0, cos(a * 10.0)) * 0.2 + 0.5;
    f -= f2 - f1;
    
    color = vec3(1.0 - smoothstep(f, f + 0.02, r));
    
    gl_FragColor = vec4(color, 1.0);
}
