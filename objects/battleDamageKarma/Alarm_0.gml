/// @desc
Limit();

if (Value > 0) {
	Value -= 1;
	WORLD_PLAYER.HP.Reduce(1);
}

alarm[0] = GetCoolDown();


