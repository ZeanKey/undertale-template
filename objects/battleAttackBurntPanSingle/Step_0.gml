/// @desc Enter Detect
if (not _isPressed) {
	if (abs(x - _start) > sprite_get_width(sprBattleAimBar) / 2 + 48) {
		_isPressed = true;
		
		alarm[0] = 10;
		Anim_Target(id, "image_alpha", 0, 10, 0, 0);
	}
	else if (input_check_pressed(INPUT.CONFIRM)) {
		// Turn off input detector
		if (battleAttackBurntPan.TryShoot(_index)) {
			_isPressed = true;
	
			var RESULT = 1;
			if (abs(x - 320) > 12) then RESULT = 0.5;
			if (abs(x - 320) < 2) then RESULT = 2;
			battleAttackBurntPan.Report(RESULT);
			battleAttackBurntPan.Cooldown();
			var EFF = instance_create_depth(x, y, depth, battleAttackEffectReticule);
			if (RESULT != 2) then EFF._colors = [c_aqua];
			instance_destroy()
		}
	}
}