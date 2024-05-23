/// @desc Update
if (not IsControlled) then exit;

if (IsActivated) {
	if (AutoAnim) {
		var SPD = 2;
		var INPUT_VEC = new Vector2D(0, 0);
	
		if (Movenable.Value()) {
			if (input_check(INPUT.LEFT)) then INPUT_VEC.X -= 1;
			if (input_check(INPUT.RIGHT)) then INPUT_VEC.X += 1;
			if (input_check(INPUT.UP)) then INPUT_VEC.Y -= 1;
			if (input_check(INPUT.DOWN)) then INPUT_VEC.Y += 1;
		}
	
		if (INPUT_VEC.Y == 1) {
			TryMoveY(SPD);
			Animations.Play("WalkDown");
			Direciton = DIR.DOWN;
		}
		if (INPUT_VEC.Y == -1) {
			TryMoveY(-SPD);
			Animations.Play("WalkUp");
			Direciton = DIR.UP;
		}
		if (INPUT_VEC.X == 1) {
			TryMoveX(SPD);
			if (INPUT_VEC.Y == 0) {
				Animations.Play("WalkRight");
				Direciton = DIR.RIGHT;
			}
		}
		if (INPUT_VEC.X == -1) {
			TryMoveX(-SPD);
			if (INPUT_VEC.Y == 0) {
				Animations.Play("WalkLeft");
				Direciton = DIR.LEFT;
			}
		}
	
		if (INPUT_VEC.X == 0 and INPUT_VEC.Y == 0) {
			switch (Direciton) {
				case DIR.UP:
				Animations.Play("IdleUp");
				break
				case DIR.DOWN:
				Animations.Play("IdleDown");
				break
				case DIR.LEFT:
				Animations.Play("IdleLeft");
				break
				case DIR.RIGHT:
				Animations.Play("IdleRight");
				break
			}
		}
	}
	
	if (not IsUICaptured) {
		if (input_check_pressed(INPUT.CONFIRM)) {
			var INST = GetFacingEntity(Direciton);

			if (instance_exists(INST)) {
				with (INST) TryInteract(other, direction_flip(other.Direciton));
			}
		}
		if (input_check_pressed(INPUT.MENU)) then instance_create_depth(0, 0, 0, uiMenu);
	}
}

Animations.Update();