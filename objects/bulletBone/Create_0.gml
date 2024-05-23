/// @desc Init
// Inherit the parent event
event_inherited();

depth = DEPTH.BOARD - 1;

_offset = global.Vector.Zero.Value();
_origin = 0;
_sprEnd = 0;
_indEnd = 0;
_sprLen = 0;

evaluate_size = function () {
	if (_origin == BONE_ORIGIN.CENTER) {
		_offset = Offset;
		return true;
	}
	if (_origin == BONE_ORIGIN.SIDE) {
		_offset = global.Vector.Result.Add(global.Vector.Polar(image_angle, Size / 2 + _sprLen), Offset);
		return true;
	}
	if (_origin == BONE_ORIGIN.FLIP_SIDE) {
		_offset = global.Vector.Result.Add(global.Vector.Polar(180 + image_angle, Size / 2 + _sprLen), Offset);
		return true;
	}
	return false;
};

Size		= 0;
Offset		= global.Vector.Zero.Value();

SetSideSprite = function (paraSpr, paraInd = 0) {
	_sprEnd = paraSpr;
	_indEnd = paraInd;
	_sprLen = sprite_get_width(_sprEnd);
};

SetOrigin = function (paraOri) {
	_origin = paraOri;
};

__render__ = function () {
	evaluate_size();
	
	var tmpVec = global.Vector.Polar(image_angle, Size / 2);
	draw_sprite_ext(sprPixel4, 0,
		x + _offset.X, y + _offset.Y, Size / 2, 3, image_angle, image_blend, image_alpha);
	draw_sprite_ext(_sprEnd, _indEnd,
		x + tmpVec.X + _offset.X,
		y + tmpVec.Y + _offset.Y, 1, 1, image_angle, image_blend, image_alpha);
	draw_sprite_ext(_sprEnd, _indEnd,
		x - tmpVec.X + _offset.X,
		y - tmpVec.Y + _offset.Y, 1, 1, 180 + image_angle, image_blend, image_alpha);
};

SetSideSprite(sprBattleBonepart);