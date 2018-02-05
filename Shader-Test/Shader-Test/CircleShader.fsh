//
//  CircleShader.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 2/5/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

float circle(vec2 _st, float _radius){
    vec2 dist = _st - vec2(0.5);
    return 1 - smoothstep(_radius - (_radius * 0.01),
                         _radius + (_radius * 0.01),
                         dot(dist, dist) * 4.0);
}

void main(){
    vec2 iResolution = a_sprite_size / 1.15;
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    
    vec3 color = vec3(circle(st, 0.7));
    
    gl_FragColor = vec4(color, 1.0);
}
