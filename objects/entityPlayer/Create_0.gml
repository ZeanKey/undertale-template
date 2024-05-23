/// @desc Set
event_inherited();

event_user(0)

Movenable = {
	_premises : {},
	Add : function (paraName, paraInit) {
		variable_struct_set(_premises, paraName, paraInit);
	},
	Set : function (paraName = -1, paraBool) {
		if (paraName == -1) {
			var NAMES = struct_get_names(_premises);
			for (var INDEX = 0; INDEX < array_length(NAMES); INDEX ++) {
				variable_struct_set(_premises, NAMES[INDEX], paraBool);
			}
		}
		else if (variable_struct_exists(_premises, paraName)) {
			variable_struct_set(_premises, paraName, paraBool);
		}
	},
	Value : function () {
		var NAMES = struct_get_names(_premises);
		var RESULT = true;
		for (var INDEX = 0; INDEX < array_length(NAMES); INDEX ++) {
			if (variable_struct_get(_premises, NAMES[INDEX]) == false) then RESULT = false;
		}
		return RESULT;
	}
};

Movenable.Add("UI", true);
Movenable.Add("Custom", true);

AutoAnim = true;

Direciton = DIR.DOWN;

IsUICaptured = false;
IsControlled = true;

TryMoveX = function (paraVal, paraCollider = mask_index) {
	var STEP = sign(paraVal) / MOTION_PRECISE;
	repeat (abs(paraVal) * MOTION_PRECISE) {
		if (not place_meeting(x + STEP, y, grid)) then x += STEP;
	}
}

TryMoveY = function (paraVal, paraCollider = mask_index) {
	var STEP = sign(paraVal) / MOTION_PRECISE;
	repeat (abs(paraVal) * MOTION_PRECISE) {
		if (not place_meeting(x, y + STEP, grid)) then y += STEP;
	}
}

GetFacingEntity = function (paraDir) {
	var ENTITY = -1;
	var SPR_GET = Animations.GetCurrentSprite();
	var SPR_WID = sprite_get_width(SPR_GET) * image_xscale;
	var SPR_HEI = sprite_get_height(SPR_GET) * image_yscale;
	switch (paraDir) {
		case DIR.UP:
		ENTITY = collision_rectangle(	x - SPR_WID / 2 + 5, y - 5,
										x + SPR_WID / 2 - 5, y - SPR_HEI + 5, entity, false, true);
		break;
		case DIR.DOWN:
		ENTITY = collision_rectangle(	x - SPR_WID / 2 + 5, y - SPR_HEI + 20,
										x + SPR_WID / 2 - 5, y + 15, entity, false, true);
		break;
		case DIR.LEFT:
		ENTITY = collision_rectangle(	x, y - SPR_HEI + 20,
										x - SPR_WID / 2 - 15, y - 1, entity, false, true);
		break;
		case DIR.RIGHT:
		ENTITY = collision_rectangle(	x, y - SPR_HEI + 20,
										x + SPR_WID / 2 + 15, y - 1, entity, false, true);
		break;
	}
	return ENTITY;
}

GetTransBattleRenderer = function () {
	var tmpRenderer = Animations.GetCurrentSpriteRenderer(x - camera_get_view_x(camera.Camera), y - camera_get_view_y(camera.Camera));
	tmpRenderer._posX *= 2;
	tmpRenderer._posY *= 2;
	tmpRenderer._scale.Mul(2);
	return tmpRenderer;
}
