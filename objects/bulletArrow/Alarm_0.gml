/// @desc
var INST = instance_create_depth(x, y, depth, effectShootWave);

INST.image_angle = image_angle;

with INST
{
	_alphaMax = 1;
	_time = 30;
	_ringIdeal	= 80;
	event_user(0);
}

alarm[1] = 5;