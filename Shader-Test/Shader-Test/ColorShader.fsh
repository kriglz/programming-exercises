//
//  ColorShader.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 1/3/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

#define PI 3.14159265359

float plot (vec2 st, float pct){
    return smoothstep( pct-0.01, pct, st.y) - smoothstep( pct, pct+0.01, st.y);
}

void main()
{    
    vec2 st = gl_FragCoord.xy;
    st.x /= 1080;
    st.y /= 1920;
    
    vec3 color = vec3(0.0);
    
    vec3 pct = vec3(st.x+st.y);
    
    pct.r = smoothstep(0.0,1.0, st.x)+ sin(u_time*PI);
    pct.g = sin(st.x*PI+PI) + sin(st.y*PI) + sin(u_time*PI/2);
    pct.b = exp(st.y/100);
    
    vec3 colorA = vec3(0.149,0.141,0.912);
    vec3 colorB = vec3(1.000,0.833,0.224);
    color = mix(colorA, colorB, pct);
    
    // Plot transition lines for each channel
//    color = mix(color,vec3(1.0,0.0,0.0),plot(st,pct.r));
//    color = mix(color,vec3(0.0,1.0,0.0),plot(st,pct.g));
//    color = mix(color,vec3(0.0,0.0,1.0),plot(st,pct.b));
    
    gl_FragColor = vec4(color,1.0);
}

