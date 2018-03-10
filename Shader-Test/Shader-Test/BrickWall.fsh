//
//  BrickWall.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 3/7/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

#define center vec2(0.5, 0.5)

/// Time step control
float time(float _time) {
    float timeStep = step(1.0, mod(_time, 2));
    float modifiedTimeStep = timeStep == 1 ? timeStep * (_time): (-_time);
    return modifiedTimeStep;
}

/// Direction control
vec2 direction(vec2 _st, float _time) {
    float timeStep = step(1.0, mod(_time, 2));
    vec2 _direction = _st;
    
    if (_st.x == 0) {
        if (_st.y == 0) {
            _direction = timeStep == 1 ? vec2(1, 0) : vec2(0, -1);
        } else {
            _direction = timeStep == 1 ? vec2(-1, 0) : vec2(0, -1);
        }
    } else {
        if (_st.y == 0) {
            _direction = timeStep == 1 ? vec2(1, 0) : vec2(0, 1);
        } else {
            _direction = timeStep == 1 ? vec2(-1, 0) : vec2(0, 1);
        }
    }
    return _direction;
}

// Pattern control
vec2 movingGrid(vec2 _st, float _zoom, float _time) {
    _st *= _zoom;
    vec2 stepForLines = step(1.0, mod(_st, 2.0));
    vec2 lineDirections = direction(stepForLines, _time);
    vec2 lineDirectionsOnTime = lineDirections * time(_time);
    vec2 directionsForLines = _st + lineDirectionsOnTime;
    return fract(directionsForLines);
}

float box(vec2 _st, vec2 _size) {
    _size = vec2(0.5) - _size * 0.5;
    vec2 uv = smoothstep(_size, _size + vec2(1e-4), _st);
    uv *= smoothstep(_size, _size + vec2(1e-4), vec2(1.0) - _st);
    return uv.x * uv.y;
}

float circle(float firstRadius, float secondRadius, vec2 st) {
    float pct = distance(st, center);
    float circle = step(firstRadius, pct);
    circle *= step(1-secondRadius, 1 - pct);
    return circle;
}

void main(void) {
    vec2 iResolution = a_sprite_size.x / 1.15;
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    vec3 color = vec3(0.0);
    
    // Inits grid and moves it's lines.
    st = movingGrid(st, 7.0, u_time);
    
    // Draws circle.
    color = vec3(circle(0.1, 0.4, st));
    
    // Makes color changes.
    color = color.x == 1 ? vec3(1.0, sin(u_time), 0.0) : 0;
    
    gl_FragColor = vec4(color, 1.0);
}
