///@desc Update
_speedY += _accY;
_speedX += _accX;

if _isGravitized
{
	speed		= point_distance(0, 0, _speedX, _speedY);
	direction	= point_direction(0, 0, _speedX, _speedY);
}

var SCALE = _divGrade / 15;

sprite_index	= sprBulletStar;
image_angle		++;
image_xscale	= SCALE;
image_yscale	= SCALE;
//image_index	= _divGrade;