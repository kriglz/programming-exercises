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
    // Wrap arround 1.0
    st = fract(st);
    return st;
}

/// Makes color.
vec3 makeColor(float red, float green, float blue, float coord) {
    return vec3(coord * red / 255,
                coord * green / 255,
                coord * blue / 255);
}

void main() {
    vec2 iResolution = a_sprite_size.xy / 1.15;
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    vec3 color = vec3(0.0);
    
    vec2 multiplier = vec2(3, 3);
    st = grid(multiplier, st);
    
    color = makeColor(100, 79, 200, circle(st, 0.2));

    gl_FragColor = vec4(color, 1.0);
}
