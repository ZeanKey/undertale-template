/// @desc
_motionSpeed += _motionAccel;
_motionSpeed *= _motionFrcit;

var MOTION_VEC = [	lengthdir_x(_motionSpeed, image_angle + 180),
					lengthdir_y(_motionSpeed, image_angle + 180)];

if _isTrack
{
	var T_DEL_X = _targetX - x;
	var T_DEL_Y = _targetY - y;
	
	if sqrt(sqr(T_DEL_X) + sqr(T_DEL_Y)) < 1
	{
		_isTrack = false;
	}
	else
	{
		MOTION_VEC[0] += (T_DEL_X) / _trackRate;
		MOTION_VEC[1] += (T_DEL_Y) / _trackRate;
	}
}

x += MOTION_VEC[0];
y += MOTION_VEC[1];

if _isFire
{
	_counter += _counterSpd;
	if _counter >= 2 * pi
	{
		_isFire = false;
	}
	_motionAccel = 0;
}

if keyboard_check_pressed(ord("F"))
{
	event_user(0);
}

if keyboard_check_pressed(ord("T"))
{
	event_user(1);
}