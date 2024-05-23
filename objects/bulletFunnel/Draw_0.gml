/// @desc
if _isFire
{
	var LASER_NUM = 100;
	var LASER_D_X = 0;
	var LASER_D_Y = 0;
	var LASER_ALPHA = 0;

	LASER_D_X = lengthdir_x(sprite_get_height(sprBulletFunnelLaser), image_angle);
	LASER_D_Y = lengthdir_y(sprite_get_height(sprBulletFunnelLaser), image_angle);
	LASER_ALPHA = sin(_counter / 2) * 0.5 + 0.5;
	
	_motionAccel = 0.5 * LASER_ALPHA;

	_laserWidth = _laserWidthOri * (abs(sin(_counter / 2))) * _laserRate;

	for (var COUNT = 0; COUNT < LASER_NUM; COUNT ++)
	{
		draw_sprite_ext(sprBulletFunnelLaser, 0, x + COUNT * LASER_D_X, y + COUNT * LASER_D_Y, 1, _laserWidth, image_angle, -1, LASER_ALPHA);
	}

	
}

draw_self();


