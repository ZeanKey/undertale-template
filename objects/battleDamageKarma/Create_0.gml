/// @desc
_dmgSrcContainer = [];
_dmgPreContainer = [];
Value		= 0;
Maximum		= 40;
HPMinimum	= 1;

Limit = function () {
	if (Value > Maximum) then Value = Maximum;
	if (Value > WORLD_PLAYER.HP.Value - HPMinimum) then Value = WORLD_PLAYER.HP.Value - HPMinimum;
};

Cause = function (paraArgArray) {
	var DMG_REG = paraArgArray[0];
	var DMG_KAR = paraArgArray[1];
	var DMG_SRC = paraArgArray[2];
	
	if (array_contains(_dmgSrcContainer, DMG_SRC)) then return false;
	if (array_contains(_dmgPreContainer, DMG_SRC)) then DMG_KAR = 1;
	
	array_push(_dmgSrcContainer, DMG_SRC);
	WORLD_PLAYER.HP.Reduce(DMG_REG);
	Value += DMG_KAR;
	
	Limit();
};

GetCoolDown = function () {
	if (Value == 40) {
		return 2;
	}
	else if (Value >= 30) {
		return 4;
	}
	else if (Value >= 20) {
		return 10;
	}
	else if (Value >= 10) {
		return 30;
	}
	else {
		return 60;
	}
	return 1;
};

Render = function () {
	var T_NUMBER	= string(WORLD_PLAYER.HP.Value) + " / " + string(WORLD_PLAYER.MaxHP);
	var COLOR		= make_color_rgb(255, 0, 255);
	if (Value != 0) {
		with (battleUI) {
			Render.Bar(-other.Value, COLOR, WORLD_PLAYER.HP.Value);
			draw_text_color(x + 295 + WORLD_PLAYER.MaxHP * 1.25, y + 1, T_NUMBER, COLOR, COLOR, COLOR, COLOR, 1);
		}
	}
};

alarm[0] = 1;



