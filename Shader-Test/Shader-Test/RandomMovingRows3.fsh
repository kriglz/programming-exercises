//
//  RandomMovingRows3.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 3/18/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

#define lineNumber 100
#define columnNumber 100

float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

float indexFor(float _st, float _number) {
    float totalIndex = 0;
    float number = _number;
    
    while (number > 0) {
        if (floor(_st / number) == 1) {
            return number;
        }
        number -= 1;
    }
    return totalIndex;
}

float time(float _time) {
    if ((_time / lineNumber) > 1) {
        _time -= lineNumber * floor(_time / lineNumber);
    }
    
    return indexFor(_time, lineNumber);
}

void main() {
    
    vec2 iResolution = a_sprite_size.xy / 1.15;
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    
    // Scale the coordinate system by 10
    st.y *= lineNumber;
    st.x *= columnNumber;
    
    // get the integer coords
    vec2 ipos = floor(st);
    
    vec3 color = vec3(1.0);
    
    if (ipos.y == (time(u_time) - 1)) {
        
        if (ipos.x < time(u_time * columnNumber)) {
            
            st.x -= u_time * (0.5 + floor(st.y) / 10 + 10 * abs(random(floor(st.y))));
            ipos = floor(st);
            color *= step(0.5, random(ipos));
        }
        
    } else if (ipos.y < (time(u_time) - 1)) {
        
        st.x -= u_time * (0.5 + floor(st.y) / 10 + 10 * abs(random(floor(st.y))));
        ipos = floor(st);
        color *= step(0.5, random(ipos));
    }
    
    float alpha = 1.0;
    
    if (ipos.y == floor(time(u_time) / 5) && ipos.x < floor(time(u_time * 5) / 2)) {
        color += abs(sin(u_time * 8)) * vec3(0.8, 1, 0.6);
        
    } else if (ipos.y == floor(time(u_time) / 4) && ipos.x < floor(time(u_time * 4) / 2)) {
        color += abs(sin(u_time * 4)) * vec3(1.0, 0.2, 0.2);
        
    }
    
    
    gl_FragColor = vec4(color, alpha);
}
