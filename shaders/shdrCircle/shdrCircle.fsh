//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec2 iResolution;

void main()
{
	vec2 fragCoord = v_vTexcoord * iResolution;
	vec2 radPosUV = vec2(.5);
	vec2 radPosCoord = .5 * iResolution.xy;
	float radCurCoord = length(fragCoord.xy - radPosCoord);
	float radCurUV = length(v_vTexcoord - radPosUV);
	float radMaxCoord = .5 / radCurUV * radCurCoord - 5.;
	
	float inner = step(radMaxCoord, radCurCoord);
	
	vec3 oOCol = vec3(1. - step(.5, radCurUV));
	vec3 oICol = vec3(inner);
	vec3 oCol = oOCol * oICol;
	
    gl_FragColor = vec4(vec3(oCol), (1. - inner + oCol) * v_vColour.a);
}
