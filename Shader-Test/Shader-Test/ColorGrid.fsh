//
//  ColorGrid.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 3/2/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

float circle(vec2 _st, float _radius) {
    vec2 l = _st - vec2(0.5);
    return 1.0 - smoothstep(_radius - (_radius * 0.01),
                            _radius + (_radius * 0.01),
                            dot(l, l) * 4.0);
}

vec2 grid(vec2 multiplier, vec2 st) {
    // Scale up x the space by multipler
    st.y *= multiplier.y;
    // Scale up x the space by multipler
    st.x *= multiplier.x;
    return st;
}

/// Makes color.
vec3 makeColor(vec3 color, float coord) {
    return vec3(coord * color.x / 255,
                coord * color.y / 255,
                coord * color.z / 255);
}



void main() {
    vec2 iResolution = a_sprite_size.x / 1.15;
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    vec3 color = vec3(0.0);
    vec3 colorConst = vec3(255);
    
    vec2 multiplier = vec2(3, 3);
    st = grid(multiplier, st);
    
    // Calculate a color for a pattern position.
    if (st.x > 1 && st.x < 2 && st.y > 2 && st.y < 3) {
        colorConst = step(0.5, abs(sin(u_time * 2))) * vec3(100, 79, 200) ;
    }
    
    // Calculate a color for a pattern position.
    if (st.x > 2 && st.x < 3 && st.y > 3 && st.y < 4) {
        colorConst = step(0.5, abs(cos(u_time * 2))) * vec3(100, 79, 200) ;
    }
    
    // Calculate a color for a pattern position.
    if (st.x < 1 && st.y < 1) {
        colorConst = step(0, sin(u_time * 6)) * vec3(50, 255, 100);
    }
    
    // Wrap arround 1.0
    st = fract(st);
    
    color = makeColor(colorConst, circle(st, 0.2));

    gl_FragColor = vec4(color, 1.0);
}
