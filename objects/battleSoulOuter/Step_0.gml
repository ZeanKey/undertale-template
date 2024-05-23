PlanetLimit();
SumGravity();

var SPD = 2;
SPD = (input_check(INPUT.CANCEL)) ? (SPD / 2) : SPD;

if (battle.Soul.Movenable) {
	var M_INPUT = [0, 0];
	var IS_INPUT_JUMP = false;
	
	if (input_check(INPUT.LEFT)) {
		M_INPUT[0] -= SPD;
	}
	if (input_check(INPUT.RIGHT)) {
		M_INPUT[0] += SPD;
	}
	if (input_check(INPUT.UP)) {
		M_INPUT[1] -= SPD;
	}
	if (input_check(INPUT.DOWN)) {
		M_INPUT[1] += SPD;
	}
	
	var VEC_INPUT = [	point_distance(0, 0, M_INPUT[0], M_INPUT[1]),
						point_direction(0, 0, M_INPUT[0], M_INPUT[1])];
	VEC_INPUT[0] = (VEC_INPUT[0] == 0) ? 0 : SPD;
	VEC_INPUT[1] -= image_angle;
	
	var SCALE_H, SCALE_V;
	SCALE_H = cos(degtorad(VEC_INPUT[1])) * VEC_INPUT[0];
	SCALE_V = sin(degtorad(VEC_INPUT[1])) * VEC_INPUT[0];
	//SCALE_H = 0;
	//SCALE_V = 2;
	
	array_push(self._vecPrint, [	(point_distance(0, 0, M_INPUT[0], M_INPUT[1]) == 0) ? 0 : SPD,
									point_direction(0, 0, M_INPUT[0], M_INPUT[1]), c_white]);
	
	array_push(self._vecPrint, [SCALE_V, image_angle + 90, c_blue]);
	array_push(self._vecPrint, [SCALE_H, image_angle, c_red]);
	
	//show_message(0.5 * SPD)
	if (SCALE_V > 0.5 * SPD) {
		//show_message(1)
		IS_INPUT_JUMP = true;
	}
	
	if (SCALE_H != 0) {
		var M_STEP = abs(SCALE_H) / 10;
		if (SCALE_H < 0) {
			repeat (SPD * 10) {
				if (not IsEdgeMeetingBoard(DIR.LEFT)) {
					x += lengthdir_x(M_STEP, image_angle + 180);
					y += lengthdir_y(M_STEP, image_angle + 180);
				}
				else {
					break;
				}
			}
		}
		if (SCALE_H > 0) {
			repeat (SPD * 10) {
				if (not IsEdgeMeetingBoard(DIR.RIGHT)) {
					x += lengthdir_x(M_STEP, image_angle);
					y += lengthdir_y(M_STEP, image_angle);
				}
				else {
					break;
				}
			}
		}
	}
	
	if (_pressure) or (IsEdgeMeetingBoard(DIR.DOWN, 1) or IsEdgeMeetingPlate(DIR.DOWN)) {
		if (IS_INPUT_JUMP) {
			//show_message(1)
			_velocity.AddPolarArray([_spdJump, image_angle + 90]);
			
			_pressure = false;
			//show_message(_velocity.Polarize());
		}
	}
	
	var JUMP_VELO = _velocity.Polarize();
	if (JUMP_VELO[0] != 0) {
		var JUMP_STEP = JUMP_VELO[0] / 10;
		var JUMP_DIR = JUMP_VELO[1];
		repeat (JUMP_VELO[0] * 10) {
			if ((not IsEdgeMeetingBoard(DIR.UP)) and (not IsEdgeMeetingBoard(DIR.DOWN) or IS_INPUT_JUMP) and (not IsEdgeMeetingBoard(DIR.LEFT)) and (not IsEdgeMeetingBoard(DIR.RIGHT))) {
				x += lengthdir_x(JUMP_STEP, JUMP_DIR);
				y += lengthdir_y(JUMP_STEP, JUMP_DIR);
			}
			else {
				_velocity.Zero();
				if (IsEdgeMeetingBoard(DIR.DOWN)) _pressure = true;
				break;
			}
		}
	}
		
	//x = (round(x) * 10) / 10;
	//y = (round(y) * 10) / 10;
}

if (x > room_width + EDGE) {
	x = -EDGE;
}
else if (x < -EDGE) {
	x = room_width + EDGE;
}

if (y > room_height + EDGE) {
	y = -EDGE;
}
else if (y < -EDGE) {
	y = room_height + EDGE;
}

PlanetLimit();