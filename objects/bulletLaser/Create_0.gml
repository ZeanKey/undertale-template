/// @desc Init
// Inherit the parent event
event_inherited();

depth = DEPTH.BULLET_OUTSIDE_LOW;

Scale		= 1;

_sideSprite	= sprDefault;
_scaleRate	= 0;
_offset		= 0;

SetSideSprite = function (paraSpr) {
	_sideSprite = paraSpr;
	_scaleRate	= sprite_get_height(paraSpr);
	_offset		= sprite_get_width(paraSpr);
}

GetLength = function () {
	return point_distance(x, y, room_width / 2, room_height / 2) + point_distance(0, 0, room_width, room_height);
}

__render__ = function () {
	draw_sprite_ext(_sideSprite, 0, x, y, 1, Scale, image_angle, image_blend, image_alpha);
	draw_sprite_ext(sprPixel2, 0,
		x + lengthdir_x(_offset, image_angle),
		y + lengthdir_y(_offset, image_angle),
		GetLength(), Scale * _scaleRate / 2, image_angle, image_blend, image_alpha);
};