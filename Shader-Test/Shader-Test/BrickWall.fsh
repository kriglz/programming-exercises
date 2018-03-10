//
//  BrickWall.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 3/7/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//


vec2 brickTile(vec2 _st, float _zoom, float time) {
    _st *= _zoom;
    
    // Here is where the offset is happening

    float patternStep = step(1.0, mod(_st.y, 2.0));
    float modifiedPatternStep = patternStep == 1 ? patternStep * (time): (-time);
    
    _st.x += modifiedPatternStep;

    return fract(_st);
}

float box(vec2 _st, vec2 _size) {
    _size = vec2(0.5) - _size * 0.5;
    vec2 uv = smoothstep(_size, _size + vec2(1e-4), _st);
    uv *= smoothstep(_size, _size + vec2(1e-4), vec2(1.0) - _st);
    return uv.x * uv.y;
}

void main(void) {
    vec2 iResolution = a_sprite_size.x / 1.15;
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    vec3 color = vec3(0.0);
    
    // Modern metric brick of 215mm x 102.5mm x 65mm
    // http://www.jaharrison.me.uk/Brickwork/Sizes.html
    st /= vec2(2.15,0.65) / 1.5;
    
    // Apply the brick tiling
    st = brickTile(st, 5.0, u_time);
    
    color = vec3(box(st, vec2(0.98)));
    
    // Uncomment to see the space coordinates
//    color = vec3(st, 0.0);
    
    gl_FragColor = vec4(color, 1.0);
}
