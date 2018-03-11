//
//  TilePatternShader.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 3/11/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

#define PI 3.14159265358979323846
#define lineNumber 24
#define columnNumber 4

float indexFor(float _st, float _number) {
    float totalIndex = 0;
    float number = _number;
    
    while (number > 1) {
        totalIndex += step(1., mod(_st, number));// * (number - 1.);

//        totalIndex += step(1., (mod(number / _st) < 2 ? mod(_st, number) : 0));// * (number - 1.);
        number -= 1;
    }
    
    return totalIndex;
}

float time(float _time) {
    if ((_time / lineNumber) > 1) {
        _time -= lineNumber * ceil(_time / lineNumber);
    }
    
    return indexFor(_time, lineNumber);
}

float tileComponent (float _st, float _zoom) {
    _st *= _zoom;
    return _st;
}

vec2 rotate2D (vec2 _st, float _angle) {
    _st -= 0.5;
    _st = mat2(cos(_angle), -sin(_angle),
               sin(_angle), cos(_angle)) * _st;
    _st += 0.5;
    return _st;
}

vec2 rotateTilePattern(vec2 _st){
    
    //  Scale the coordinate system by 2x2
    _st.y *= 4.0;
    
    //  Give each cell an index number
    //  according to its position
    float index = 0.0;
    index += step(1., mod(_st.y, 2.0));
//    index += step(1., mod(_st.y, 2.0)) * 2.0;
    
    //      |
    //  2   |   3
    //      |
    //--------------
    //      |
    //  0   |   1
    //      |
    
    // Make each cell between 0.0 - 1.0
    _st = fract(_st);
    
    // Rotate each cell according to the index
    if(index == 1.0){
        //  Rotate cell 1 by 90 degrees
        _st = rotate2D(_st, PI * -0.5);
    } else if(index == 2.0){
        //  Rotate cell 2 by -90 degrees
        _st = rotate2D(_st, PI * -0.5);
    } else if(index == 3.0){
        //  Rotate cell 3 by 180 degrees
        _st = rotate2D(_st, PI);
    }
    
    return _st;
}

vec3 changeColor(float _index) {
    vec3 color = vec3(.9, .8, 0.9);
    
    if (_index == 1.0){
        color = vec3(.3, 0.5, 1.);
        
    } else if (_index == 2.0) {
        color = vec3(1., .0, 0);
        
    } else if (_index == 3.0) {
        color = vec3(.5, 0.7, 0.7);
        
    } else if (_index == 4.0) {
        color = vec3(.1, 0.9, 0.9);
    }
    
    return color;
}

float box(vec2 _st, vec2 _size) {
    _size = vec2(0.5) - _size * 0.5;
    vec2 uv = smoothstep(_size, _size + vec2(1e-4), _st);
    uv *= smoothstep(_size, _size + vec2(1e-4), vec2(1.0) - _st);
    return uv.x * uv.y;
}

void main (void) {
    vec2 iResolution = a_sprite_size.x / 1.15;
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    vec3 color = vec3(0.);

    // Pattern - x.
    st.x = tileComponent(st.x, columnNumber);
    float microIndexX = indexFor(st.x, columnNumber);
    
    // Pattern - y.
    st.y = tileComponent(st.y, lineNumber);
    float microIndexY = indexFor(st.y, lineNumber);
    
    st = fract(st);
    
    // Draw box.
    float boxDesign = box(st, vec2(0.8, 0.8));

    if (boxDesign == 1) {
        float timeIndex = time(u_time);
        
        if (microIndexY != timeIndex) {
            color = changeColor(microIndexX);
        } else {
            color = vec3(1.);
        }
    }
    
//    vec3 color = triangleDesign == 1 ? changeColor(index + (sin(u_time) > 0 ? 1 : 0)) : vec3(0);

    gl_FragColor = vec4(color, 1.0);
}
