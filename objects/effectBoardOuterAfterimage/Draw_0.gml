/// @desc
if (not instance_exists(_parent)) {
	instance_destroy();
	exit;
}
else if (_parent.object_index != battleBoardOuter) {
	instance_destroy();
	exit;
}

if (not surface_exists(_parent._surfBoard)) {
	_parent._surfBoard = surface_create(_parent.image_xscale, _parent.image_yscale);
}

shader_set(shdrCircle);
shader_set_uniform_f(_parent._shdrParam, _parent.image_xscale, _parent.image_yscale);

CircleImageRenderInitialize();
CircleImageRender();

shader_reset();

