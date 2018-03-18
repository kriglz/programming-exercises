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
    
    st.x -= u_time * (floor(st.y) / 10 + 10 * abs(random(floor(st.y))));
    
    // get the integer coords
    vec2 ipos = floor(st);
    
    float colorComponent = 1.0;
    
    if (ipos.y < time(u_time * 2)) {
        
        if (ipos.y == (time(u_time * 2) - 1) && ipos.x < time(u_time * 2 * 60)) {
            colorComponent *= step(0.6, random(ipos));
        } else if (ipos.y < (time(u_time * 2) - 1)) {
            colorComponent *= step(0.6, random(ipos));
        }
    }
  
    // Assign a random value based on the integer coord
    vec3 color = vec3(colorComponent);
    
    gl_FragColor = vec4(color, 1.0);
}

