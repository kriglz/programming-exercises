//
//  CircularShader.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 2/5/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

float plotSmoothCircle(float firstRadius, float secondRadius, float delta, float d) {
    float circle = smoothstep(firstRadius, firstRadius + delta, d);
    circle *= smoothstep(1-secondRadius, 1-secondRadius + delta, 1 - d);
    return circle;
}

float plotCircle(float firstRadius, float secondRadius, float d) {
    float circle = step(firstRadius, d);
    circle *= step(1-secondRadius, 1 - d);
    return circle;
}

void main() {
    vec2 iResolution = a_sprite_size / 1.15;
    iResolution.x *= 2;
    vec2 st = gl_FragCoord.xy / iResolution;
    vec3 red = vec3(1, 0, 0);
    vec3 green = vec3(0, 1, 0);
    vec3 blue = vec3(0, 0, 1);

    float pct = 0.0;
    pct = distance(st, vec2(0.25,0.5)) * 4 * abs(sin(u_time / 3.14));
    float circle = plotCircle(0, 0.025, pct);
    circle += plotCircle(0.8, 0.9, pct);
    circle += plotCircle(1.15, 1.35, pct);
    vec3 thirstColor = mix(circle, green, blue);

    float pct2 = 0;
    vec2 center2 = vec2(st.x + cos(u_time)/15, st.y + sin(u_time)/15);
    pct2 = distance(center2, vec2(0.25,0.5)) * 2;
    float secondCircle = plotSmoothCircle(0.2, 0.3 + abs(sin(u_time/4))/5, 0.01, pct2);
    vec3 secondColor = mix(secondCircle, red, red);
    
    float pct3 = 0;
    vec2 center3 = vec2(st.x + sin(u_time)/19, st.y + cos(u_time)/19);
    pct3 = distance(center3, vec2(0.25,0.5)) * 2;
    float thirdCircle = plotSmoothCircle(0.15, 0.25 + abs(sin(u_time/3))/5, 0.01, pct3);
    vec3 thirdColor = mix(thirdCircle, red, green);

    vec3 color = mix(thirstColor, secondColor, thirdColor);
    gl_FragColor = vec4(color, 1.0);
}

// b. The LENGTH of the vector
//    from the pixel to the center
//     vec2 toCenter = vec2(0.5)-st;
//     pct = length(toCenter);

// c. The SQUARE ROOT of the vector
//    from the pixel to the center
// vec2 tC = vec2(0.5)-st;
// pct = sqrt(tC.x*tC.x+tC.y*tC.y);
