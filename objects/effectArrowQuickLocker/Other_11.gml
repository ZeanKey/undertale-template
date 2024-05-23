var ARROW = instance_create(_posStart[0], _posStart[1], bulletArrow);
var AIM = self;

with ARROW
{
	speed = 30;
	image_angle = point_direction(x, y, AIM.x, AIM.y);
	direction = point_direction(x, y, AIM.x, AIM.y);
}
