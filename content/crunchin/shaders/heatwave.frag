#pragma header

// HELP TAKEN FROM:
// https://www.shadertoy.com/view/XsVSRd -- the heatwave shader
// ^ specifically FabriceNeyret2, very awesome person from 2016

uniform float threshold;
uniform float uTime;

float rand(vec2 n) { return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);}
float noise(vec2 n) {
const vec2 d = vec2(0.0, 1.0);
vec2 b = floor(n), f = smoothstep(vec2(0.0), vec2(1.0), fract(n));
return mix(mix(rand(b), rand(b + d.yx), f.x), mix(rand(b + d.xy), rand(b + d.yy), f.x), f.y);
}
void main()
{
    vec2 p_m = openfl_TextureCoordv;
    vec2 p_d = p_m;
    p_d.y += uTime * 0.1;
    vec4 dst_map_val = vec4(noise(p_d * vec2(50)));
    vec2 dst_offset = dst_map_val.xy;
    dst_offset -= vec2(0., 0.);
    dst_offset *= 2.;
    dst_offset *= 0.01;
    dst_offset *= p_m.t;
    vec2 dist_tex_coord = p_m.st + (dst_offset * threshold);
    gl_FragColor = flixel_texture2D(bitmap, dist_tex_coord);
}

/*void main()
{
    vec2 U = openfl_TextureCoordv;
    
    vec2 d = flixel_texture2D(bitmap, U - vec2(0,.1)*uTime).xy;
    
    d = (2.*d - 1.) * (1. - U.y);
    
    gl_FragColor = flixel_texture2D(bitmap, U + (.01*d) * threshold); 
}*/