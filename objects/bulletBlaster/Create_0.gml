/// @desc 
IS_DEBUG = false;

audio_play_sound(sndBlasterCharge, 0, 0);

depth = DEPTH.BULLET_OUTSIDE_HIGH;

image_speed		= 0;
image_xscale	= 2;
image_yscale	= 2;
image_alpha		= 0;

sprite_index = sprBulletBlasterGBS;

_isInitialized = false;
_phase		= 0;
_timer		= 0;
_pause		= 5;
_speed		= 5;
_laser		= noone;

Init = function (paraOX, paraOY, paraTX, paraTY, paraTDir, paraPause, paraXScale, paraYScale, paraColor = BULLET_TYPE.WHITE) {
	x = paraOX;
	y = paraOY;	
	_targetX	= paraTX;
	_targetY	= paraTY;
	_targetRot	= paraTDir;
	_pause		= paraPause;
	image_xscale = paraXScale;
	image_yscale = paraYScale;
	
	var tmpColor;

	switch (paraColor) {
		case BULLET_TYPE.WHITE:
		tmpColor = UT_WHITE;
		break;
		case BULLET_TYPE.BLUE:
		tmpColor = UT_BLUE
		break;
		case BULLET_TYPE.ORANGE:
		tmpColor = UT_ORANGE;
		break;
	}

	image_blend = tmpColor;
	
	_isInitialized = true;
};