/// @desc
if (floor(_counter) mod 2 == 0) and (_counter < 6) {
	_renderer.Render();
}
else {
	if (_soulDrawEnable) {
		draw_set_alpha(1);
		draw_set_color(c_white);
		draw_sprite(sprSoulRed, 0, _soulX, _soulY - 16);
	}
}







