//
//  ConnectingLines.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 4/2/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

#define PI 3.14159265359
#define TWO_PI 6.28318530718

#define F3 0.3333333
#define G3 0.1666667

float shape(vec2 st, int N){
    st = st * 2.-1.;
    float a = atan(st.x, st.y) + PI;
    float r = TWO_PI / float(N);
    return cos(floor(.5 + a / r) * r - a) * length(st);
}

float box(vec2 st, vec2 size){
//    return shape(st * size, 4);
//}

//    float circle(vec2 _st, float _radius){
        vec2 dist = st - vec2(0.5);
        return 1 - smoothstep(size.x - (size.x * 0.03) * shape(st * size, 9),
                              size.x * shape(st * size, 4) + (size.x * 0.04) * shape(st * size, 8),
                              dot(dist, dist * 2) * 4.0);
}

float hex(vec2 st, bool a, bool b, bool c, bool d, bool e, bool f){
    st = st * vec2(2., 6.);
    
    vec2 fpos = fract(st);
    vec2 ipos = floor(st);
    
    if (ipos.x == 1.0) fpos.x = 1.-fpos.x;
    
    if (ipos.y < 1.0){
        return a? box(fpos-vec2(0.03,0.), vec2(1.)) : box(fpos, vec2(0.84,1.));
    } else if (ipos.y < 2.0){
        return b? box(fpos-vec2(0.03,0.), vec2(1.)) : box(fpos, vec2(0.84,1.));
    } else if (ipos.y < 3.0){
        return c? box(fpos-vec2(0.03,0.), vec2(1.)) : box(fpos, vec2(0.84,1.));
    } else if (ipos.y < 4.0){
        return d? box(fpos-vec2(0.03,0.), vec2(1.)) : box(fpos, vec2(0.84,1.));
    } else if (ipos.y < 5.0){
        return e? box(fpos-vec2(0.03,0.), vec2(1.)) : box(fpos, vec2(0.84,1.));
    } else if (ipos.y < 6.0){
        return f? box(fpos-vec2(0.03,0.), vec2(1.)) : box(fpos, vec2(0.84,1.));
    }
    return 0.0;
}

float hex(vec2 st, float N){
    bool b[6];
    float remain = floor(mod(N, 64.));
    for(int i = 0; i < 6; i++){
        b[i] = mod(remain, 2.) == 1. ? true : false;
        remain = ceil(remain / 2.);
    }
    return hex(st, b[0], b[1], b[2], b[3], b[4], b[5]);
}

vec3 random3(vec3 c) {
    float j = 4096.0*sin(dot(c,vec3(17.0, 59.4, 15.0)));
    vec3 r;
    r.z = fract(512.0*j);
    j *= .125;
    r.x = fract(512.0*j);
    j *= .125;
    r.y = fract(512.0*j);
    return r-0.5;
}

float snoise(vec3 p) {
    
    vec3 s = floor(p + dot(p, vec3(F3)));
    vec3 x = p - s + dot(s, vec3(G3));
    
    vec3 e = step(vec3(0.0), x - x.yzx);
    vec3 i1 = e*(1.0 - e.zxy);
    vec3 i2 = 1.0 - e.zxy*(1.0 - e);
    
    vec3 x1 = x - i1 + G3;
    vec3 x2 = x - i2 + 2.0*G3;
    vec3 x3 = x - 1.0 + 3.0*G3;
    
    vec4 w, d;
    
    w.x = dot(x, x);
    w.y = dot(x1, x1);
    w.z = dot(x2, x2);
    w.w = dot(x3, x3);
    
    w = max(0.6 - w, 0.0);
    
    d.x = dot(random3(s), x);
    d.y = dot(random3(s + i1), x1);
    d.z = dot(random3(s + i2), x2);
    d.w = dot(random3(s + 1.0), x3);
    
    w *= w;
    w *= w;
    d *= w;
    
    return dot(d, vec4(52.0));
}

void main(){
    vec2 iResolution = a_sprite_size.xy / 1.15;
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    
    float t = u_time * 0.7;
    
    float df = 1.0;
    df = mix(hex(st, t), hex(st, t + 1), fract(t));
    df += snoise(vec3(st * 75., t * 0.1)) * 0.03;
    gl_FragColor = vec4(mix(vec3(0.), vec3(1.), step(0.7, df)), 1.0);
}
