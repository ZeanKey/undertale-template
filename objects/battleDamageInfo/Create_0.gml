/// @desc Init
depth = DEPTH.BOARD - 20;

_isInitialized	= false;
_counter		= 0;
_text			= "";
_renderPos		= new Vector2D(x, y);

Launch = function (paraDamage) {
	if (paraDamage == -1) {
		_text = "Miss";
	}
	else {
		_text = string(paraDamage);
		audio_play_sound(sndDamage, 0, 0);
	}
	
	_isInitialized = true;
	
	alarm[0] = 60;
};
