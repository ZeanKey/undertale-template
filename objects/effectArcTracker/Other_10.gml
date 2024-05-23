///@desc Start Calling
var ANGLE_CON = point_direction(_startX, _startY, _endX, _endY);
var ANGLE_BET = abs(angle_difference(_startAngle, ANGLE_CON));

var DIST_CON	= point_distance(_startX, _startY, _endX, _endY);
var DIST_HALF	= DIST_CON / 2;

var DIST_MID	= DIST_HALF / tan(degtorad(ANGLE_BET));

_radius = DIST_HALF / sin(degtorad(ANGLE_BET));
_angTotal = ANGLE_BET * 2;

if _angTotal > 180
{
	_angTotal -= 360;
}

var SIGN = sign(ANGLE_CON);//sign(angle_difference(_startAngle, ANGLE_CON));

//if ANGLE_BET > 90
//{
//	SIGN *= -1;
//	_angTotal *= -1;
//}

_cirPosX = _startX + lengthdir_x(DIST_HALF, ANGLE_CON) + lengthdir_x(DIST_MID, ANGLE_CON + SIGN * 90);
_cirPosY = _startY + lengthdir_y(DIST_HALF, ANGLE_CON) + lengthdir_y(DIST_MID, ANGLE_CON + SIGN * 90);

_motionStart = true;