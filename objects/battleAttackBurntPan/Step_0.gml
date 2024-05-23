/// @desc
if (array_length(_result) == 4) {
	battleAimBar.Close();
	if (IsMiss()) {
		Apply(Index, -1, noone);
		instance_destroy();
		exit;
	}
	
	Apply(Index, Eval(), battleAttackEffectBurntImpact);
	if (IsGolden()) then battleAttackEffectBurntImpact.image_blend = c_yellow;
	instance_destroy();
}




