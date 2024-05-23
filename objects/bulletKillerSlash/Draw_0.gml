/// @desc
if (_counter >= _timeFin) return;
draw_sprite_ext(sprPixel4, 0, x, y, 640, 0.5, image_angle, _initLineColors[_counter mod 3], _initLineAlpha);

surface_set_target(battleBoard.SurfaceBoard);
var result = DrawCutline(x, y, image_angle, _counter * 4, _finished ?  -1 : _limit);

if (result.OnUpdated) {
	_limit ++;
}
if (result.Finished) {
	_limit = -1;
	_finished = true;
}
surface_reset_target();
