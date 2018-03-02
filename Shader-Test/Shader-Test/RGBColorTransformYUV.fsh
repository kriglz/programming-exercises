//
//  RGBColorTransformYUV.fsh
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 3/2/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

// YUV to RGB matrix
#define yuv2rgb mat3(1.0, 0.0, 1.13983, 1.0, -0.39465, -0.58060, 1.0, 2.03211, 0.0)

// RGB to YUV matrix
#define rgb2yuv mat3(0.2126, 0.7152, 0.0722, -0.09991, -0.33609, 0.43600, 0.615, -0.5586, -0.05639)

void main(){
    vec2 iResolution = a_sprite_size.y / 1.15;
    vec2 st = gl_FragCoord.xy / iResolution.xy;
    vec3 color = vec3(0.0);
    
    // UV values goes from -1 to 1
    // So we need to remap st (0.0 to 1.0)
    st -= 0.2;  // becomes -0.5 to 0.5
    st *= 2.0;  // becomes -1.0 to 1.0
    
    // we pass st as the y & z values of
    // a three dimentional vector to be
    // properly multiply by a 3x3 matrix
    color = yuv2rgb * vec3(st.x, st.x, st.y);
    
    gl_FragColor = vec4(color,1.0);
}
