/// @desc Trail
// Inherit the parent event
event_inherited();

if (variable_instance_exists(id, "_trail")) {
	var ANG = point_direction(xprevious, yprevious, x, y) + 180;
	var CUR_PART_VEC = [lengthdir_x(Size / 2, ANG),
						lengthdir_y(Size / 2, ANG)];
						
	var CUR_PART = instance_create_depth(
					x + CUR_PART_VEC[0],
					y + CUR_PART_VEC[1],
					depth,
					effectSpotLeaves)
	CUR_PART.image_angle	= image_angle;
	CUR_PART._counter		= 4;
	CUR_PART._dyingSpd		= 0.2;
}