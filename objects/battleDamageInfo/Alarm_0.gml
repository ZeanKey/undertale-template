/// @desc Destruction & Update Button Phase
if (battleButtonFight._phase == 2) {
	with (battleButton) event_user(BUTTON_EVENT.OUTER_CONFIRM);
}

instance_destroy(battleEnemyHealthBar);
instance_destroy();