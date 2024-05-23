/// @desc
_counter ++;

if (_debug) {
	if keyboard_check(vk_up) {
		//image_xscale ++;
		//image_yscale ++;
	}
	
	if keyboard_check(vk_down) {
		//image_xscale --;
		//image_yscale --;
	}
	
	x = mouse_x;
	y = mouse_y;
}

if (instance_exists(battleSoulOuter)) {
	with (battleSoulOuter) {
		ApplyGravity(other);
	}
}