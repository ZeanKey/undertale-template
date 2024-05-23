/// @desc Init
/// @desc Init
event_inherited();

_bulletNum		= 4;
_bulletCounter	= 0;

y			= battleAimBar.y;
depth		= DEPTH.BOARD - 20;
image_speed = 0;

_dir		= choose(DIR.LEFT,DIR.RIGHT);
_result		= [];
_isCooldown = false;

Index = -1;

Cooldown = function (paraTime = 1) {
	_isCooldown = true;
	alarm[1] = paraTime;
};

Report = function (paraResult) {
	array_push(_result, paraResult);
};

TryShoot = function (paraIndex) {
	if (not _isCooldown and paraIndex == array_length(_result)) {
		return true;
	}
	return false;
};

EvalResult = function () {
	var SUM = 0;
	for (var INDEX = 0; INDEX < array_length(_result); INDEX ++) {
		SUM += _result[INDEX];
	}
	return SUM;
};

IsGolden = function () {
	var NUM_A = 0;
	var NUM_H = 0;
	var NUM_C = 0;
	for (var INDEX = 0; INDEX < array_length(_result); INDEX ++) {
		NUM_C = _result[INDEX];
		if (NUM_C == 2) {
			NUM_H ++;
		}
		else if (NUM_C == 1) {
			NUM_A ++;
		}
		else if (NUM_C == 0) {
			return false;
		}
	}
	if (NUM_H >= 2 && (NUM_H + NUM_A) >= 4) then return true;
	return false;
};

IsMiss = function () {
	for (var INDEX = 0; INDEX < array_length(_result); INDEX ++) {
		if (_result[INDEX] != 0) {
			return false;
		}
	}
	return true;
}

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
	break;
	
	case DIR.RIGHT:
	x = 320 - sprite_get_width(sprBattleAimBar) / 2;
	break;
}

battleAimBar.Open();

alarm[0] = 1;


