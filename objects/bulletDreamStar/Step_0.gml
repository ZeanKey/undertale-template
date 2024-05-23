///@desc Update
_speedY += _accY;
_speedX += _accX;

if _isGravitized
{
	speed		= point_distance(0, 0, _speedX, _speedY);
	direction	= point_direction(0, 0, _speedX, _speedY);
}

if (collision_circle(x, y, 10, battleBoardAdd, false, true))
{
	event_user(0);
}

var SCALE = (_divGrade + 1) / 15;

sprite_index	= sprBulletStar;
image_angle		++;
image_xscale	= SCALE;
image_yscale	= SCALE;
//image_index	= _divGrade;

if x < -_edge or x > room_width + _edge or y < -_edge or y > room_height + _edge
{
	instance_destroy();
}