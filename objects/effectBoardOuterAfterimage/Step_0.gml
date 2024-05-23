/// @desc
if (not instance_exists(_parent)) {
	instance_destroy();
	exit;
}

if (_parent._afterimageEnable) {
	new CircleImage(_parent, self);
}


