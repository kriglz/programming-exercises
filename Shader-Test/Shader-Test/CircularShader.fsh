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
    vec2 st = gl_FragCoord.xy / iResolution;
    float pct = 0.0;
    
    // a. The DISTANCE from the pixel to the center
    pct = distance(st, vec2(0.5)) * 2 * abs(sin(u_time));
    
    float circle = plotCircle(0, 0.05, pct);
    circle += plotCircle(0.15, 0.2, pct);
    circle += plotCircle(0.4, 0.5, pct);
    circle += plotCircle(0.7, 0.9, pct);
    circle += plotCircle(1.15, 1.35, pct);
    
//    circle += plotCircle(0.7, 0.72, pct);

//    float circle = plotSmoothCircle(0.4, 0.5, 0.05, pct);
    
    // b. The LENGTH of the vector
    //    from the pixel to the center
//     vec2 toCenter = vec2(0.5)-st;
//     pct = length(toCenter);
    
    // c. The SQUARE ROOT of the vector
    //    from the pixel to the center
    // vec2 tC = vec2(0.5)-st;
    // pct = sqrt(tC.x*tC.x+tC.y*tC.y);
    
    vec3 red = vec3(1,0,0);
    vec3 green = vec3(0,1,0);

    vec3 color = vec3(mix(circle, red, green));
    
    gl_FragColor = vec4( color, 1.0 );
}
