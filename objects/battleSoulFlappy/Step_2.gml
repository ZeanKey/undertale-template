/// @desc Check Green Board
event_inherited();

var INST=instance_position(x+lengthdir_x(sprite_height/2+1,image_angle-90),y+lengthdir_y(sprite_height/2+1,image_angle-90),battlePlateGreen);

if (INST!=noone)
{
	_move = 0;
	if (input_check(INPUT_BLUE.UP))
	{
		_move=(- _speed_jump)
	}

	x-=INST.xprevious-INST.x;
}