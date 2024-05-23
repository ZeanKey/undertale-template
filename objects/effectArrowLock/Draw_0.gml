/// @desc

draw_reset();
draw_set_alpha(_lockerAimAlpha);

var AIM_ANG_DEL = 360 / _lockerNum;

for (var AIM_COUNT = 0; AIM_COUNT < _lockerNum; AIM_COUNT ++)
{
	self._drawAimTriangle([x, y], [_lockerAimOffset * _rate, 90 * _rate], _counterRotation + AIM_COUNT * AIM_ANG_DEL, _lockerAimWidth);
}

draw_reset();

if _counter <= 360
{
	var ARRAY_BLANKS = [[_angleStart + _counterRotation, _angleStart + _counterRotation + 360 - _counter]]
	
	var ANGLE_OFFSET	= _lockerWidth / 2;
	var ANGLE_START		= _counterRotation;
	var ANGLE_DELTA		= 360 / _lockerNum;
	var CUR_ANGLE, CUR_ANGLE_START, CUR_ANGLE_END;
	
	for (var COUNTER = 0; COUNTER < _lockerNum; COUNTER ++)
	{
		CUR_ANGLE = ANGLE_START + ANGLE_DELTA * COUNTER;
		CUR_ANGLE_START = CUR_ANGLE - ANGLE_OFFSET;
		CUR_ANGLE_END	= CUR_ANGLE + ANGLE_OFFSET;
		array_push(ARRAY_BLANKS, [CUR_ANGLE_START, CUR_ANGLE_END]);
	}
	
	self._drawRing([x, y], 70 * _rate, 80 * _rate, ARRAY_BLANKS, _lockerAimAlpha);
}
else
{
	if _trigger == false
	{
		event_user(0);
		_trigger = true;
		
		Anim_Target(id, "_alphaRelease", 0, 30, ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT);
		Anim_Target(id, "_lockerAimAlpha", 0, 30, ANIM_TWEEN.CUBIC, ANIM_EASE.IN_OUT);
		Anim_Target(id, "_rate", 1, 30);
	}
	
	var ARRAY_BLANKS = [];
	
	var ANGLE_OFFSET	= _lockerWidth / 2;
	var ANGLE_START		= _counterRotation;
	var ANGLE_DELTA		= 360 / _lockerNum;
	var CUR_ANGLE, CUR_ANGLE_START, CUR_ANGLE_END;
	
	for (var COUNTER = 0; COUNTER < _lockerNum; COUNTER ++)
	{
		CUR_ANGLE = ANGLE_START + ANGLE_DELTA * COUNTER;
		CUR_ANGLE_START = CUR_ANGLE - ANGLE_OFFSET;
		CUR_ANGLE_END	= CUR_ANGLE + ANGLE_OFFSET;
		array_push(ARRAY_BLANKS, [CUR_ANGLE_START, CUR_ANGLE_END]);
	}
	
	self._drawRing([x, y], 70 * _rate, 80 * _rate, ARRAY_BLANKS, _alphaRelease);

}

if _trigger
{
	if _alphaRelease <= 0
	{
		instance_destroy();
	}
}