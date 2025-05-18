#pragma header

uniform sampler2D iChannel0;
uniform vec3 iResolution;
uniform float iTime;
uniform bool red;

#define X_AND_Y

float Less(float x, float value)
{
    return 1.0 - step(value, x);
}

float Between(float x, float lower, float upper)
{
    return step(lower, x) * (1.0 - step(upper, x));
}

float GEqual(float x, float value)
{
    return step(value, x);
}

void main()
{
    float brightness = 1;
    vec2 uv = gl_FragCoord.xy / iResolution.xy;
    uv.y = -uv.y;
    
    vec2 uvStep;
    uvStep.x = uv.x / (1.0 / iResolution.x);
    uvStep.x = mod(uvStep.x, 3.0);
    uvStep.y = uv.y / (1.0 / iResolution.y);
    uvStep.y = mod(uvStep.y, 3.0);
    
    vec4 newColour = flixel_texture2D(bitmap, openfl_TextureCoordv);
        
    if(red){
        newColour.r = newColour.r * step(1.0, (Less(uvStep.x, 1.0) + Less(uvStep.y, 1.0)));
    }else{
        newColour.r = newColour.r * step(1.0, (Less(uvStep.x, 1.0) + Less(uvStep.y, 1.0))) * 0.25;
    }
    newColour.g = newColour.g * step(1.0, (Between(uvStep.x, 1.0, 2.0) + Between(uvStep.y, 1.0, 2.0)));
    newColour.b = newColour.b * step(1.0, (GEqual(uvStep.x, 2.0) + GEqual(uvStep.y, 2.0)));
    
    gl_FragColor = mix(flixel_texture2D(bitmap, openfl_TextureCoordv), (newColour * brightness), 0.5);
}