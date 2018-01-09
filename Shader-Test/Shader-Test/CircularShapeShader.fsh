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
    
    vec2 iResolution = a_sprite_size; 
    vec2 fragCoord = gl_FragCoord.xy / iResolution.xy;

    
    float i2 = fragCoord.y;
    float j2 = fragCoord.x;
    float d = sqrt(i2*i2+j2*j2);
    
    float o = (d - sin(u_time*3.14/1.5))*tan(d*3.14*(15+10*sin(u_time/4)));
    
//    if (u_time < 10) {
//        o = (d - sin(u_time*3.14/2))*tan(d*3.14*u_time);
//    } else {
//        o = (d - sin(u_time*3.14/2))*tan(d*3.14*(10+ 1/60))+0.5;
//    }
    
    
    // Plot a line
    float pct = plot(fragCoord, o);
    
    vec3 color = vec3(o);
    color = (1.0-pct)*color + pct*vec3(o,o,1.0);
    
    gl_FragColor = vec4(color, o);
}
