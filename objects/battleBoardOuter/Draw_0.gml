/// @desc Render Circle
// Scale valid check
if (image_xscale < 0) {
	image_xscale = 0;
}

if (image_yscale < 0) {
	image_yscale = 0;
}

if (image_xscale == 0 || image_yscale == 0) {
	return false;
}

// Surface initialized
if (not surface_exists(_surfBoard)) {
	_surfBoard = surface_create(image_xscale, image_yscale);
}

if (image_xscale_previous != image_xscale || image_yscale_previous != image_yscale) {
	surface_resize(_surfBoard, image_xscale, image_yscale);
	ScalePreviousUpdate();
}

// Evaluate render position
var RENDER_X, RENDER_Y;
RENDER_X = x - image_xscale / 2;
RENDER_Y = y - image_yscale / 2;

if (_wavingCoordEnable) {
	RENDER_Y += sin(_counter / 120) * 20;
}

// Render
draw_set_alpha(1);
draw_set_color(-1);
shader_set(shdrCircle);
shader_set_uniform_f(_shdrParam, image_xscale, image_yscale);

if (surface_exists(_surfBoard)) {
	draw_surface(_surfBoard, RENDER_X, RENDER_Y);
}

shader_reset();