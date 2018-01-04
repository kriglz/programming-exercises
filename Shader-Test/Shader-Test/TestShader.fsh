//
//  TestShader.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 1/3/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

void main()
{
    vec3 color = vec3(0.0);
    
    float pct = abs(sin(u_time));
    
    // Mix uses pct (a value from 0-1) to
    // mix the two colors
    vec3 colorA = vec3(0.149,0.141,0.912);
    vec3 colorB = vec3(1.000,0.833,0.224);
    color = mix(colorA, colorB, pct);
    
    gl_FragColor = vec4(color,1.0);
    
    
    //    gl_FragColor = vec4(abs(sin(u_time)), abs(tan(u_time)), abs(sin(u_time)), 1.0);
    
    
    
    
    //        gl_FragColor = SKDefaultShading();
    //
    //        vec4 color = texture2D(u_texture, v_tex_coord);
    //        float alpha = color.a;
    //        float phase = mod(u_time, 3);
    //        vec3 outputColor = color.rgb;
    //        if (phase < 1.0) {
    //            outputColor = color.bgr;
    //        } else if (phase < 2.0) {
    //            outputColor = color.brg;
    //        }
    //        gl_FragColor = vec4(outputColor, 1.0) * alpha;
    
    
    
    //        vec4 color = texture2D(u_texture, v_tex_coord);
    //        float alpha = color.a;
    //        float r = (sin(u_time+ 3.14 * 0.00)+1.0)*0.5;
    //        float g = (sin(u_time+ 3.14 * 0.33)+1.0)*0.5;
    //        float b = (sin(u_time+ 3.14 * 0.66)+1.0)*0.5;
    //        gl_FragColor = vec4(r,g,b, 1.0) * alpha;
    
    //    vec2 coord = v_tex_coord;
    //    float deltaX = sin(coord.y * 3.14 * 11 + u_time * 2) * 0.005;
    //    coord.x = coord.x + deltaX;
    //    vec4 color = texture2D(u_texture, coord);
    //    gl_FragColor = color;
}


