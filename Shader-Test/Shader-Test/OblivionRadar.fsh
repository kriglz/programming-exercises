//
//  OblivionRadar.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 2/20/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

#define PI 3.14159265359
#define center vec2(0.3, 0.5)
#define radarRadius 0.35

float circle(float firstRadius, float secondRadius, float d) {
    float circle = step(firstRadius, d);
    circle *= step(1-secondRadius, 1 - d);
    return circle;
}

float circleSmooth(float firstRadius, float secondRadius, float d) {
    float circle = smoothstep(firstRadius, firstRadius + 0.05, d);
    circle *= step(1-secondRadius, 1 - d);
    return circle;
}

/// Rotation around the axis function.
mat2 rotate2d(float _angle){
    return mat2(cos(_angle), -sin(_angle),
                sin(_angle), cos(_angle));
}

/// Scale the object.
mat2 scale(vec2 _scale){
    return mat2(_scale.x, 0.0,
                0.0, _scale.y);
}

/// Adds thin lines.
float line(float x, float y){
    return step(x, y) - step(x + 0.001, y);
}

/// Adds thin some distance lines with vanishing tail lines.
float lineVanishing(float distanceToCenter, vec2 size, vec2 st){
    // Moves the center to make line start from the center.
    st.x += size.x / 2;
    // Reduces size twice and adjust to the screen size.
    size = vec2(0.5) - size * 0.5;
    // Makes a abrupt line.
    vec2 line = step(size, st);
    
    if (distanceToCenter > radarRadius) {
        // No line if outside the radius.
        line *= 0;
    } else {
        // Makes a vanishing line if it less thad radar radius.
        line *= smoothstep(size, size - vec2(0, 2 * distanceToCenter), vec2(1.0) - st);
    }
    
    return line.x * line.y;
}

/// Makes color.
vec3 makeColor(float red, float green, float blue, float coord) {
    return vec3(coord * red / 255,
                coord * green / 255,
                coord * blue / 255);
}

float blinking(float time) {
    return step(0.5, abs(sin(time * 15)));
}

void main(){
    vec2 iResolution = a_sprite_size.y / 1.15;
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    vec3 color = vec3(1.0);

    // Calculate the center
    float pct = distance(st, center);
    
    // Add the cicle shapes.
    color = vec3(circle(0.5, 0.51, pct));
    color += vec3(circle(radarRadius, radarRadius + 0.005, pct));
    color += makeColor(24, 201, 239, circle(0.2, 0.205, pct));
    color += makeColor(24, 201, 239, circle(0.03, 0.035, pct));

    // Moving center position of the cross to match the circle center.
    vec2 stMoved = st + vec2(0.2, 0);
    // Adds crossing lines.
    color += vec3(line(stMoved.x, stMoved.y));
    color += vec3(line(1-stMoved.x, stMoved.y));
  
    
    // Adding moving small red circle.
    
    // Creates circular movement.
    vec2 translate = vec2(cos(u_time), sin(u_time));
    // Decentralize.
    vec2 stMoving = st - center;
    // Adds time dependent movement.
    stMoving += translate * 0.28 * sin(translate / 10 - u_time / 5);
    // Centralize.
    stMoving += center;
    // Gets distance from the center.
    pct = distance(stMoving, center);
    // Adds red filled blinking cirle.
    color += makeColor(255, 0, 0, circle(0.0, 0.015, pct)) * blinking(u_time);
    // Adds red empty circle.
    color += makeColor(255, 0, 0, circle(0.02, 0.022, pct));
    // Init scaled circle radius.
    vec2 scaledCircle = vec2(0.022);
    // Scales the circle radius.
    scaledCircle *= scale(vec2(max(step(0, tan(u_time * 2 + PI)) * (tan(u_time + PI / 2) * 5 + 1.0),
                                   step(0, tan(u_time*2)) * (tan(u_time) * 5 + 1.0))));
    // Adds red empty scaling circle with smooth line.
    color += makeColor(255, 0, 0, circleSmooth(scaledCircle.x - 0.05, scaledCircle.x, pct));
    
    
    // Adding rotating line.
    
    // Virtual center position.
    vec2 centerMoving = vec2(0.5);
    // Decentrialize center.
    stMoving = st + vec2(0.2, 0);
    stMoving -= centerMoving;
    // Add rotation to the line.
    stMoving = rotate2d(u_time / 2) * stMoving;
    // Centrialize the line rotation.
    stMoving += centerMoving;
    // Point distance to the center.
    float distanceToCenter = distance(st, center);
    // Add the line.
    color += makeColor(24, 201, 239, lineVanishing(distanceToCenter, vec2(radarRadius, 0.002), stMoving));
    
    gl_FragColor = vec4(color, 1.0);
}
