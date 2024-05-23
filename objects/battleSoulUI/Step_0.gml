/// @desc Update
if (SoulUIMode == SOUL_UI_MODE.FLEE) {
	instance_create(x, y, battleSoulFlee);
	instance_destroy();
	exit;
}

// Effect - Inv Blinking
if (battle.Soul.Inv > 0) {
	if (image_speed == 0) {
		image_speed = 1 / 2;
		image_index = 1;
	}
}
else {
	if (image_speed != 0) {
		image_speed = 0;
		image_index = 0;
	}
}

