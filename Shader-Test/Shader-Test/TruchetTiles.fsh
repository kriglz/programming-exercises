//
//  TruchetTiles.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 3/10/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

#define PI 3.14159265358979323846
#define center vec2(0.5, 1)

vec2 rotate2D (vec2 _st, float _angle) {
    _st -= 0.5;
    _st = mat2(cos(_angle), -sin(_angle),
                sin(_angle), cos(_angle)) * _st;
    _st += 0.5;
    return _st;
}

vec2 tile (vec2 _st, float _zoom) {
    _st *= _zoom;
    return (_st);
}

vec2 rotateTilePattern(vec2 _st){
    
    //  Scale the coordinate system by 2x2
    _st *= 2.0;
    
    //  Give each cell an index number
    //  according to its position
    float index = 0.0;
    index += step(1., mod(_st.x, 2.0));
    index += step(1., mod(_st.y, 2.0)) * 2.0;
    
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
        _st = rotate2D(_st, PI * 0.5);
    } else if(index == 2.0){
        //  Rotate cell 2 by -90 degrees
        _st = rotate2D(_st, PI * -0.5);
    } else if(index == 3.0){
        //  Rotate cell 3 by 180 degrees
        _st = rotate2D(_st, PI);
    }
    
    return _st;
}

float getIndex(vec2 _st) {
    float index = 0.0;
    index += step(1., mod(_st.x, 2.0));
    index += step(1., mod(_st.y, 2.0)) * 2.0;
    return index;
}

vec3 changeColor(float _index) {
    vec3 color = vec3(1);
    
    // Rotate each cell according to the index
    if (_index == 1.0){
        //  Rotate cell 1 by 90 degrees
        color = vec3(1., 0, 0);
    } else if (_index == 2.0){
        //  Rotate cell 2 by -90 degrees
        color = vec3(1., 1., 0);
    } else if (_index == 3.0){
        //  Rotate cell 3 by 180 degrees
        color = vec3(1., 0, 1.);
    }
    
    return color;
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

void main (void) {
    vec2 iResolution = a_sprite_size.x / 1.15;
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    
    st = tile(st, 3.0);
    float index = getIndex(st);
    st = fract(st);
    
    st = rotateTilePattern(st);
    
    // Make more interesting combinations
    // st = rotateTilePattern(st * 2.);
    st = rotate2D(st, PI * u_time * 0.25);
    
    // step(st.x,st.y) just makes a b&w triangles
    // but you can use whatever design you want.
    float triangleDesign = step(st.x, st.y);
    float boxDesign = box(st, vec2(1, 0.5));
    float circleDesign = circle(0.4, 0.9, st);
    
    vec3 color = circleDesign == 1 ? changeColor(index) : vec3(0);
    
    gl_FragColor = vec4(color, 1.0);
}
