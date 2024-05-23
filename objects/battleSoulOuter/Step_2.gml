/// @desc Check Green Board
var INST = instance_position(	x + lengthdir_x(sprite_height / 2 + 1, image_angle - 90),
								y + lengthdir_y(sprite_height / 2 + 1, image_angle - 90), battlePlateGreen);

if (INST != noone) {
	x -= INST.xprevious - INST.x;
	y -= INST.yprevious - INST.y;
}