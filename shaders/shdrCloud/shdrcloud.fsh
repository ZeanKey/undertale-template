varying vec2 v_vTexcoord;
varying vec4 v_vColour;

const int OCTAVES = 4;
uniform float time;

float rand(vec2 uv)
{
	uv = mod(uv, 10000.0);
	return fract(sin(dot(uv, vec2(12.9898,78.233))) * 43758.5453);
}

float perlin_noise(vec2 uv)
{
	vec2 i = floor(uv);
	vec2 f = fract(uv);
	
	float tl = rand(i) * 6.283;
	float tr = rand(i + vec2(1.0, 0.0)) * 6.283;
	float bl = rand(i + vec2(0.0, 1.0)) * 6.283;
	float br = rand(i + vec2(1.0, 1.0)) * 6.283;
	
	vec2 tlvec = vec2(-sin(tl + time), cos(tl + time));
	vec2 trvec = vec2(-sin(tr + time), cos(tr + time));
	vec2 blvec = vec2(-sin(bl + time), cos(bl + time));
	vec2 brvec = vec2(-sin(br + time), cos(br + time));
	
	float tldot = dot(tlvec, f);
	float trdot = dot(trvec, f - vec2(1.0, 0.0));
	float bldot = dot(blvec, f - vec2(0.0, 1.0));
	float brdot = dot(brvec, f - vec2(1.0, 1.0));
	
	vec2 cubic = f * f * (3.0 - 2.0 * f);
	
	float topmix = mix(tldot, trdot, cubic.x);
	float botmix = mix(bldot, brdot, cubic.x);
	float wholemix = mix(topmix, botmix, cubic.y);
	
	return 0.5 + wholemix;
}

float fbm(vec2 uv) {
	
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 0.5;

	for(int i = 0; i < OCTAVES; i++) {
		value += perlin_noise(uv) * scale;
		normalize_factor += scale;
		uv *= 2.0;
		scale *= 0.5;
	}
	return value / normalize_factor;
}

void main()
{
	vec2 uv = v_vTexcoord * 6.0;
	float motion = fbm(uv + vec2(-time * 0.2, time * 0.25));
	
	for (int i=0; i<3; i++)
	{
		motion = fbm(uv + motion + time * 0.2);
	}
	
	motion = pow(motion, 1.6) * 2.2;
    gl_FragColor = motion * v_vColour;
}