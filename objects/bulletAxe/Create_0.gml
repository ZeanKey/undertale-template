///@desc Init
depth = DEPTH.BOARD - 1;
image_xscale = 2;
image_yscale = 2;

_phase = 0;
_alphaAdder = 0.1;
_sign = 1;

_emerge = function ()
{
	image_alpha = 0;
	_phase = 0;
}

_slash = function (paraStart, paraEnd, paraTime)
{
	_sign = sign(paraStart - paraEnd);
	_alphaAdder = 1 / paraTime;
	y -= 100;
	image_angle = paraStart;
	alarm[0] = paraTime + 1;
	Anim_Target(id, "image_angle", paraEnd, paraTime, ANIM_TWEEN.EXPO, ANIM_EASE.IN);
	Anim_Target(id, "y", y + 100, paraTime, ANIM_TWEEN.EXPO, ANIM_EASE.IN);
}

_destroy = function ()
{
	_phase = 1;
}