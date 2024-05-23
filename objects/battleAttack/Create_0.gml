/// @desc
Apply = function (paraIndex, paraVal, paraEffect) {
	var ENEMY_SELECTED = battle.Enemies.Find(paraIndex);
	
	if (paraVal != -1) {
		var ATTACK = instance_create_depth(	ENEMY_SELECTED.AimPos.X,
											ENEMY_SELECTED.AimPos.Y, 0, paraEffect);
		ATTACK.Launch(paraIndex, paraVal);
	}
	else {
		var DMG_INFO = instance_create_depth(	ENEMY_SELECTED.AimPos.X,
												ENEMY_SELECTED.AimPos.Y, 0, battleDamageInfo);
		DMG_INFO.Launch(-1);
	}
};

