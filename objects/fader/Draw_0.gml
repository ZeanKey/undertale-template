/// @desc
draw_set_alpha(_alpha);
draw_set_color(_color);
draw_rectangle(0, 0, room_width, room_height, false);

if (_alpha == _target) and (not _persist) {
	Remove();
}





