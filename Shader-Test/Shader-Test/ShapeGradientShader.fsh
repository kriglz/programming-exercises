//
//  ShapeGradientShader.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 1/3/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

// Plot a line on Y using a value between 0.0-1.0
float plot(vec2 st, float pct){
    return  smoothstep(pct-0.02, pct, st.y) - smoothstep(pct, pct+0.02, st.y);
}

void main()
{
    vec2 iResolution = a_sprite_size;
    vec2 st = gl_FragCoord.xy/iResolution;
    
    //    float y = pow(st.x, 1);
    //    float y = step(0.5,st.x);
    //    float y = smoothstep(0.1,0.9,st.x);
    float y = smoothstep(0.2,0.5,st.x) - smoothstep(0.5,0.8,st.x);
    
    vec3 color = vec3(y);
    
    // Plot a line
    float pct = plot(st,y);
    color = (1.0-pct)*color + pct*vec3(0.0,1.0,0.0);
    gl_FragColor = vec4(color,1.0);
}


