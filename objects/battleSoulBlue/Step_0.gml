/// @desc Input & Motion
event_inherited()

_velocity.Add(global.Vector.Polar(image_angle - 90, _accelGravity));

var spdIdeal = 2;
var spd = input_check(INPUT.CANCEL) ? spdIdeal / 2 : spdIdeal;

if (battle.Soul.Movenable) {
	var inputVec = GetInputVector();
	var inputVecRelative = inputVec.Rotated(-image_angle);
	
	var inputJumping = -inputVecRelative.Y > 0.5;
	
	if (inputVecRelative.X != 0) {
		var hStepVec = global.Vector.Polar(image_angle, inputVecRelative.X / MOTION_PRECISE);
		var hStepTPos;
		repeat (abs(inputVecRelative.X) * spd * MOTION_PRECISE) {
			hStepTPos = new Vector2D(x + hStepVec.X, y + hStepVec.Y);
			if (not EdgeCollidesFrame(hStepTPos.X, hStepTPos.Y)) {
				x = hStepTPos.X;
				y = hStepTPos.Y;
			}
			else break;
		}
	}
	
	if (_bottomCollided or SideCollidedFrame(DIR.DOWN, 1) or SideCollidedPlate(DIR.DOWN, 1)) {
		if (inputJumping and not _isJumping) {
			_velocity.Zero();
			_velocity.Add(global.Vector.Polar(image_angle - 90, _accelGravity));
			_velocity.Add(global.Vector.Polar(image_angle + 90, _speedJump));
			_accelTime = 0;
			_isInputJumping = true;
			_isJumping = true;
			_bottomCollided = false;
		}
	}
	
	if (_isInputJumping) {
		if (_accelTime >= _accelMaxTime) {
			_isInputJumping = false;
		}
		else if (inputJumping) {
			_accelTime ++;
		}
		else {
			_velocity.Mul(_speedBrakeRate);
			_isInputJumping = false;
		}
	}
	
	PositionFix();
	
	var veloVec = _velocity;
	var veloPolarVec = veloVec.Polarized();

	if (veloPolarVec.Length != 0) {
		var veloStepVec = veloVec.Value().Div(MOTION_PRECISE);
		var veloStepTPos;
		repeat (MOTION_PRECISE) {
			veloStepTPos = new Vector2D(x + veloStepVec.X, y + veloStepVec.Y);
			if (not (EdgeCollidesFrame(veloStepTPos.X, veloStepTPos.Y) or BottomCollidesPlate(veloStepTPos.X, veloStepTPos.Y, veloPolarVec.Angle))) {
				x = veloStepTPos.X;
				y = veloStepTPos.Y;
			}
			else {
				_isInputJumping = false;
				_isJumping = false;
				_velocity.Zero();
				if (SideCollidesFrame(veloStepTPos.X, veloStepTPos.Y, DIR.DOWN) or SideCollidesPlate(veloStepTPos.X, veloStepTPos.Y, DIR.DOWN)) {
					if (veloPolarVec.Length > 20) {
						screen.Shake(veloPolarVec.Length / 4, 5);
					}
					_bottomCollided = true;
				}
				break;
			}
		}
	}
}

PositionFix();