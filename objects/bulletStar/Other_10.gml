///@desc Self Division
var DIV_DEL_ANG		= 0;
var DIV_GRADE_NEW	= _divGrade - 1;
if _divNum != 0
{
	if _divNum != 1
	{
		DIV_DEL_ANG = _divAngle / (_divNum - 1);
	}
}

if DIV_GRADE_NEW > 0
{
	for (var COUNTER = 0; COUNTER < _divNum; COUNTER ++)
	{
		var CUR_ANGLE = direction + - _divAngle / 2 + COUNTER * DIV_DEL_ANG;
		if _divNum == 1
		{
			CUR_ANGLE = direction;
		}
	
		var CUR_STAR = instance_create_depth(x, y, depth, bulletStar)
		CUR_STAR.speed	   = speed;
		CUR_STAR.direction = CUR_ANGLE
		CUR_STAR._divNum   = _divNum;
		CUR_STAR._divAngle = _divAngle;
		CUR_STAR._divGrade = DIV_GRADE_NEW;
		CUR_STAR._divAlarm = _divAlarm;
		CUR_STAR._trail	   = _trail;
		with CUR_STAR
		{
			event_user(1);
		}
	}
	instance_destroy();
}
else
{
	//repeat 10
	//{
	//	var CURRENT_INST = instance_create(x, y, effectSplashPiece);
	//	CURRENT_INST._spd /= 4;
	//	CURRENT_INST.speed = 1;
	//	CURRENT_INST.depth = depth;
	//	CURRENT_INST.image_xscale = image_yscale;
	//	CURRENT_INST.image_yscale = image_yscale;
	//}
}

