//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float iTime;
uniform float iPeriodPx;
uniform vec2 iResolution;

void main()
{
    vec2 radioPixelToUV = vec2(1.0, 1.0) / iResolution.xy;
	vec2 fragCoord = v_vTexcoord / radioPixelToUV;
    
    float alphaRate = step(0, sin(fragCoord.y / iPeriodPx + iTime));

    gl_FragColor = texture2D(gm_BaseTexture, v_vTexcoord) * vec4(vec3(1.0), alphaRate);
}

