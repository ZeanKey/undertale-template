/// @descr Render
draw_self();

var MULTI = 20;

for (var i = 0; i < array_length(_vecPrint); i ++)
{
	draw_set_color(_vecPrint[i][2]);
	draw_arrow(	x, y,
				x + lengthdir_x(_vecPrint[i][0] * MULTI, _vecPrint[i][1]),
				y + lengthdir_y(_vecPrint[i][0] * MULTI, _vecPrint[i][1]), 10);
}

draw_sprite(sprSoulRingBlue, 0, x, y);
_vecPrint = [];

