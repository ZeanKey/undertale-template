/// @desc Init
event_inherited();

y			= battleAimBar.y;
depth		= DEPTH.BOARD - 20;
image_speed = 0;

_isPressed	= false;
_dir		= choose(DIR.LEFT,DIR.RIGHT);
_start		= 0;
_time		= 90;
_timer		= 0;

Index = -1;

Eval = function () {
	// Initial damage evaluation
	var ATK		= 1;
	var DEF		= 1;
	var DIST	= abs(x - battleAimBar.x);
	var HALF	= sprite_get_width(sprBattleAimBar) / 2;
	var DMG		= ATK - DEF + random(2);
	
	// Damage ratio evaluation
	if (DIST <= 12) {
		DMG *= 2.2;
	}
	else {
		DMG *= (1 - DIST / HALF) * 2;
	}
	
	// Post evaluation
	DMG = round(DMG);
	if (DMG <= 0) then DMG = 1;
	
	return DMG;
};

switch (_dir) {
	case DIR.LEFT:
	x = 320 + sprite_get_width(sprBattleAimBar) / 2;
	_start = x;
	Anim_New(id, "x", 0, 0, x, -sprite_get_width(sprBattleAimBar), _time);
	break;
	
	case DIR.RIGHT:
	x = 320 - sprite_get_width(sprBattleAimBar) / 2;
	_start = x;
	Anim_New(id, "x", 0, 0, x, sprite_get_width(sprBattleAimBar), _time);
	break;
}

battleAimBar.Open();