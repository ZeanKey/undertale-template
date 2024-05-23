//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float iTime;
uniform float iMagnitudePx;
uniform float iPeriodPx;
uniform vec2 iResolution;

void main()
{
    vec2 radioPixelToUV = vec2(1.0, 1.0) / iResolution.xy;
	vec2 fragCoord = v_vTexcoord / radioPixelToUV;
    
    vec2 uv = vec2(fragCoord.x + sin(fragCoord.y / iPeriodPx + iTime) * iMagnitudePx, fragCoord.y) * radioPixelToUV;

    gl_FragColor = texture2D(gm_BaseTexture, uv);
}
