/// @desc Init
event_inherited();

_isInitialized = false;
_edge = 6;

Init = function (paraX, paraY, paraWidth, paraHeight) {
	x = paraX;
	y = paraY;
	image_xscale = paraWidth;
	image_yscale = paraHeight;
	_isInitialized = true;
};

Remove = function () {
	instance_destroy();
};