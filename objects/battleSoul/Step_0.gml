/// @desc Check Colliders
PositionFix();

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