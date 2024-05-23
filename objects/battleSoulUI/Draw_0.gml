/// @desc
if (not instance_exists(battle)) {
	instance_destroy();
}

sprite_index = battle.Soul.GetSprite();

draw_self();
