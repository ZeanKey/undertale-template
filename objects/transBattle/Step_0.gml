/// @desc
_timer ++;
_counter += 0.25;

if (_counter == 6) {
	Anim_Target(id, "_soulX", 87, 30, 1, 1);
	Anim_Target(id, "_soulY", 453, 30, 1, 1);
	_timer = 0;
}

if (_counter > 6) {
	if (_timer == 30) {
		_fader = Fader_Fade(0, 1, 30, c_black, 1);
	}
	
	if (_timer == 60) {
		_soulDrawEnable = false;
		_fader._persist = false;
		WORLD_ENCOUNTER.Launch(_encounter);
	}
}


