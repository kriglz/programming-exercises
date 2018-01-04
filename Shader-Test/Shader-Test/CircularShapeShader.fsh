//
//  CircularShapeShader.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 1/3/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

float plot (vec2 st, float pct){
    return smoothstep( pct-0.01, pct, st.y*st.x) - smoothstep( pct, pct+0.01, st.x);
}

void main(){
    
    vec2 iResolution = (1080, 1920);
    vec2 fragCoord = gl_FragCoord.xy / iResolution.xy;

    
    float i2 = fragCoord.y;
    float j2 = fragCoord.x;
    float d = sqrt(i2*i2+j2*j2);
    float o = (d - sin(u_time*3.14))*cos(d*3.14);
    
    // Plot a line
    float pct = plot(fragCoord.x, o);
    
    vec3 color = vec3(o);
    color = (1.0-pct)*color + pct*vec3(1.0,1.0,o);
    
    gl_FragColor = vec4(color, o);
}
