//
//  InterferanceShader.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 1/3/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//


float heart(vec2 p,float radius,float thickness){
    
    p *= 0.8;
    p.y = -0.1 - p.y*1.2 + abs(p.x)*(1.0-abs(p.x));
    float r = length(p);
//    float d = 0.5;
    
    return r;
}

// rings
float circ(vec2 p,float radius,float thickness){
    return mod(length(p ),radius )>thickness*.5?1.:0. ;
}

// rings squared
float circ2(vec2 p,float radius,float thickness){
    return mod(length(p*p),radius )>thickness*.5?1.:0. ;
}

// rings cubed
float circ3(vec2 p,float radius,float thickness){
    return mod(length(sin(p)),radius )>thickness*.5?1.:0. ;
}

float circ4(vec2 p,float radius,float thickness){
    
    float angle=atan(p.x,p.y);
    if(mod(angle,2.11)<1.605){
        return  mod(length(p),radius )>thickness*.5?1.:0.;
    }else{
        return 0.;
    }
}


// pattern that repeats after just few rounds
//  vec3 speeds=vec3(2.,3.,5.);

// longer prime number pattern, repeats after some more frames ....  31*53*67=110081 frames
// vec3 speeds=vec3(1.31,1.53,1.67);




void main()
{
    // very long prime number pattern, repeats after some more frames ....  33637*68023*94321=some more frames
    vec3 speeds=vec3(1.33637, 1.68023,1.94321);
    float speed=1.0;
    float moveradius=0.05;
    float radius=0.07;
    float thickness=.07;
    
    
    vec3 color1=vec3(1.,0.,0.);
    vec3 color2=vec3(0.,1.,1.);
    vec3 color3=vec3(.5,1.,0.);
    
    vec2 iResolution = a_sprite_size; 

    vec2 uv = gl_FragCoord.xy / iResolution.xy;
    //uv-=0.5;
    uv-=v_tex_coord.xy/iResolution.xy;
    uv.x*=iResolution.x/iResolution.y;
    
    vec2 p1=vec2(sin(u_time*speeds.x*speed),cos(u_time*speeds.x*speed))*moveradius;
    vec2 p2=vec2(sin(u_time*speeds.y*speed),cos(u_time*speeds.y*speed))*moveradius+vec2(.0,0.);
    vec2 p3=vec2(sin(u_time*speeds.z*speed),cos(u_time*speeds.z*speed))*moveradius-vec2(.0,0.);
    
    vec3 col = vec3( circ(uv+p1,radius,thickness))*color1;
    col +=circ(uv+p2,radius,thickness)*color2;
    col += circ(uv+p3,radius,thickness)*color3;
    
    gl_FragColor = vec4(col,1.);
}
