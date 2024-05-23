/// @desc Enter Detect
_timer ++;

if (not _isPressed) {
	if (_timer >= _time) {
		_isPressed = true;
		
		image_speed = 0.5;
		alarm[0]	= 30;
		
		Apply(Index, -1, battleAttackEffectSlash);
	}
	else if (input_check_pressed(INPUT.CONFIRM)) {
		// Turn off input detector
		_isPressed = true;
		
		// Animate finish animation
		Anim_Stop(id,"x");
		image_speed = 0.5;
		alarm[0]	= 30;
		
		// Apply
		Apply(Index, Eval(), battleAttackEffectSlash);
	}
}