/// @desc
_surfBoard = -1;
_debug = false;
_counter = 0;

CONST_G = 200;

_afterimageEnable = false;
_afterimageDyingSpd = -0.1;

_wavingCoordEnable = false;

_effect = instance_create(x, y, effectBoardOuterAfterimage);
_effect._parent = self;

_shdrParam = shader_get_uniform(shdrCircle, "iResolution");

depth = DEPTH.BOARD;
image_xscale = 200;
image_yscale = 200;
image_xscale_previous = image_xscale;
image_yscale_previous = image_yscale;

ScalePreviousUpdate = function () {
	image_xscale_previous = image_xscale;
	image_yscale_previous = image_yscale;
}
