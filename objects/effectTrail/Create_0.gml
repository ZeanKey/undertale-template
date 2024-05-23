/// @desc
_lstPoints = [];
_tex = sprite_get_texture(sprPixel, 0);

_color1 = c_yellow;
_color2 = c_white

Init = function (paraWidth, paraTime, paraTex)
{
	_widthMaximum	= paraWidth;
	_tex			= paraTex;
	alarm[0]		= paraTime;
}

AddPoint = function (paraPos) {
	array_push(_lstPoints, paraPos);
}

RenderTrail = function () {
	if array_length(_lstPoints) <= 1
	{
		return false;
	}
	
	draw_primitive_begin_texture(pr_trianglestrip, _tex);
	
	var P_ORI, P_PRE, P_UP, P_DOWN, P_DIR, P_RATE, P_WID
	var LEN = array_length(_lstPoints);
	
	for (var COUNTER = 1; COUNTER < array_length(_lstPoints) - 1; COUNTER ++)
	{
		P_RATE	= COUNTER / (LEN - 1);
		P_WID	= _widthMaximum / 2 * P_RATE;
		P_ORI	= _lstPoints[COUNTER];
		P_PRE	= _lstPoints[COUNTER - 1];
		P_DIR	= point_direction(	P_PRE[0], P_PRE[1],
									P_ORI[0], P_ORI[1]);
									
		P_UP	= [	P_ORI[0] + lengthdir_x(P_WID, P_DIR + 90),
					P_ORI[1] + lengthdir_y(P_WID, P_DIR + 90)];
		P_DOWN	= [	P_ORI[0] + lengthdir_x(P_WID, P_DIR - 90),
					P_ORI[1] + lengthdir_y(P_WID, P_DIR - 90)];
		
		draw_vertex_texture_color(P_UP[0],		P_UP[1],	P_RATE, 0, merge_color(_color1, _color2, P_RATE), P_RATE);
		draw_vertex_texture_color(P_DOWN[0],	P_DOWN[1],	P_RATE, 1, merge_color(_color1, _color2, P_RATE), P_RATE);
	}
	
	draw_vertex_texture_color(	_lstPoints[LEN - 1][0], 
								_lstPoints[LEN - 1][1],	1, 0.5, _color2, 1);
	
	draw_primitive_end();
}