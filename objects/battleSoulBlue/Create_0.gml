/// @desc Init
// Inherit the parent event
event_inherited();

SoulMode = SOUL_MODE.BLUE;

BottomCollidesPlate = function (posX, posY, motionDir) {
	var pos = GetPosSidePos(posX, posY, DIR.DOWN, 0);
	var plateCollided = collision_point(pos.X, pos.Y, battlePlate, 1, 1);
	if (plateCollided != noone) {
		if (cos(degtorad(motionDir - image_angle + 90)) > 0) {
			return true;
		}
	}
	return false;
};

Throw = function (angleDir) {
	image_angle = angleDir + 90;
	_velocity.Add(global.Vector.Polar(angleDir, 20));
};

_velocity			= global.Vector.Zero.Value();

_isInputJumping		= false;
_isJumping			= false;

_accelTime			= 0;
_accelMaxTime		= 8;
_accelGravity		= 0.15;
_speedGravityMax	= 15;
_speedJump			= 5;
_speedBrakeRate		= 0.5;

_bottomCollided = false;

image_angle = 0;