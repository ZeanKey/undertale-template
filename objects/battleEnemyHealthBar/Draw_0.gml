/// @desc Render
if (not _isLaunched) then exit;

var TARGET_X = x - (_barWidth / 2);
var TARGET_Y = y + 18;

draw_sprite_ext(sprPixel, 0, TARGET_X, TARGET_Y, _barWidth, _barHeight, 0, c_dkgray, 1);
draw_sprite_ext(sprPixel, 0, TARGET_X, TARGET_Y, _barWidth / _barMax * _barCurrent, _barHeight, 0, c_lime, 1);