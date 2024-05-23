/// @desc Green Plate Track
var pos = GetSidePos(DIR.DOWN, 1);
var plateCollided = instance_position(pos.X, pos.Y ,battlePlateGreen);

if (plateCollided != noone) {
	x += plateCollided.x - plateCollided.xprevious;
	y += plateCollided.y - plateCollided.yprevious;
}